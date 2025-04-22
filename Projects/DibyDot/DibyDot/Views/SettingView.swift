import SwiftUI

struct SettingView: View {

    @Binding var cycles: [Cycle]
    @Binding var overall: Cycle
    @Binding var overallGoal: Goal?
    @Binding var cycleGoals: [Goal]
    @Binding var cycleIndex: Int
    @Binding var reflections: [Reflection]

    @State private var popupMode: PopupCardMode?

    @State private var overallGoalText = ""
    @State private var cycleGoalText = ""
    @State private var reflectionText = ""

    @State private var selectedReflection: Reflection?
    @State private var selectedCycleId: UUID = UUID()

    var body: some View {
        SplitView {
            VStack(alignment: .center, spacing: 16) {
                CycleGoalView(cycle: overall, goal: overallGoal) {
                    popupMode = .overallGoal
                    overallGoalText = overallGoal?.title ?? ""
                }
                cycleTabView
            }
        } bottomContent: {
            reflectionListView
        }
        .onAppear {
            updateCycleSelection()
        }
        .onChange(of: selectedCycleId) { newValue in
            if let newIndex = cycles.firstIndex(where: { $0.id == newValue }) {
                cycleIndex = newIndex
            }
        }
        .popupOverlay(
            mode: popupMode,
            isPresented: Binding(
                get: { popupMode != nil },
                set: { if !$0 { popupMode = nil; selectedReflection = nil } }
            ),
            text: bindingText(for: popupMode),
            intent: currentIntent,
            onSave: handleSave,
            onDelete: handleDelete
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("+ 회고") {
                    selectedReflection = nil
                    reflectionText = ""
                    popupMode = .reflection
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private var currentIntent: PopupCardIntent {
        switch popupMode {
        case .reflection:
            return selectedReflection != nil ? .edit : .create
        case .cycleGoal:
            let currentCycle = cycles[safe: cycleIndex]
            let hasGoal = currentCycle.flatMap { cycle in
                cycleGoals.first(where: { $0.cycleID == cycle.id })
            } != nil
            return hasGoal ? .edit : .create
        case .overallGoal:
            return overallGoal != nil ? .edit : .create
        case .none:
            return .create
        }
    }
    
    private func bindingText(for mode: PopupCardMode?) -> Binding<String> {
        switch mode {
        case .overallGoal: return $overallGoalText
        case .cycleGoal: return $cycleGoalText
        case .reflection: return $reflectionText
        case .none: return .constant("")
        }
    }

    private func handleSave() {
        guard let mode = popupMode else { return }
        switch mode {
        case .overallGoal:
            overallGoal = Goal(
                cycleID: overall.id,
                title: overallGoalText
            )
        case .cycleGoal:
            let targetCycle = cycles[cycleIndex]
            if let index = cycleGoals.firstIndex(where: { $0.cycleID == targetCycle.id }) {
                cycleGoals[index].title = cycleGoalText
            } else {
                let newGoal = Goal(cycleID: targetCycle.id, title: cycleGoalText)
                cycleGoals.append(newGoal)
            }
        case .reflection:
            if let selected = selectedReflection {
                if let index = reflections.firstIndex(where: { $0.id == selected.id }) {
                    reflections[index].content = reflectionText
                }
            } else {
                let new = Reflection(
                    content: reflectionText,
                    cycleID: cycles.closestAccurateCycle().id
                )
                reflections.insert(new, at: 0)
            }
        }
        popupMode = nil
        selectedReflection = nil
    }

    private func handleDelete() {
        guard let mode = popupMode else { return }
        switch mode {
        case .overallGoal:
            overallGoal = nil
        case .cycleGoal:
            let targetCycle = cycles[cycleIndex]
            cycleGoals.removeAll { $0.cycleID == targetCycle.id }
        case .reflection:
            if let selected = selectedReflection {
                reflections.removeAll { $0.id == selected.id }
            }
        }
        popupMode = nil
        selectedReflection = nil
    }

    private func updateCycleSelection() {
        let closestIndex = cycles.closestAccurateCycleIndex()
        if !cycles.isEmpty && closestIndex < cycles.count {
            cycleIndex = closestIndex
            selectedCycleId = cycles[closestIndex].id
        } else {
            cycleIndex = 0
            selectedCycleId = cycles.first?.id ?? UUID()
        }
    }
    
    private var cycleTabView: some View {
        GeometryReader { geometry in
            TabView(selection: $selectedCycleId) {
                ForEach(Array(cycles.enumerated()), id: \.1.id) { index, cycle in
                    let goal = cycleGoals.first(where: { $0.cycleID == cycle.id })
                    CycleGoalView(cycle: cycle, goal: goal) {
                        cycleIndex = index
                        popupMode = .cycleGoal
                        cycleGoalText = goal?.title ?? ""
                    }
                    .tag(cycle.id)
                    .frame(width: geometry.size.width * 0.95)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: geometry.size.width, height: 90)
            .background(.clear)
            .cornerRadius(12)
        }
    }
    
    private var reflectionListView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(reflections.reversed()) { reflection in
                    ReflectionBubble(reflection: reflection) {
                        selectedReflection = reflection
                        reflectionText = reflection.content
                        popupMode = .reflection
                    }
                }
            }
        }
    }
}
