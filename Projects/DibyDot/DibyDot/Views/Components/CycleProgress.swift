import SwiftUI

struct CycleProgressView: View {
    @Binding var cycles: [Cycle]
    @Binding var overall: Cycle
    @Binding var overallGoal: Goal?
    @Binding var cycleGoals: [Goal]
    
    @Binding var selectedCycleId: UUID  // MainView에서 전달받음
    @Binding var isOverall: Bool        // MainView에서 컨트롤하는 상태

    // internalTargetDate로 Date.now 사용
    private var internalTargetDate: Date {
        Date.now
    }
    
    init(cycles: Binding<[Cycle]>,
         overall: Binding<Cycle>,
         overallGoal: Binding<Goal?>,
         cycleGoals: Binding<[Goal]>,
         selectedCycleId: Binding<UUID>,
         isOverall: Binding<Bool>
        ) {
        self._cycles = cycles
        self._overall = overall
        self._overallGoal = overallGoal
        self._cycleGoals = cycleGoals
        self._selectedCycleId = selectedCycleId
        self._isOverall = isOverall
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if isOverall {
                overallProgressView
            } else {
                cycleProgressTabView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            withAnimation { isOverall.toggle() }
        }
        .onAppear(perform: updateSelectedCycle)
    }
    
    // MARK: - Overall ProgressView
    private var overallProgressView: some View {
        VStack(alignment: .leading, spacing: 4) {
            GoalView(cycle: overall, goal: overallGoal)
                .font(.body)
            HStack(spacing: 4) {
                ForEach(cycles, id: \.id) { cycle in
                    progressBar(for: cycle)
                }
            }
        }
        .frame(height: 80)
    }
    
    // MARK: - Cycle TabView
    private var cycleProgressTabView: some View {
        TabView(selection: $selectedCycleId) {
            ForEach(cycles, id: \.id) { cycle in
                VStack(alignment: .leading, spacing: 4) {
                    GoalView(cycle: cycle, goal: goalForCycle(cycle))
                        .font(.body)
                    progressBar(for: cycle)
                }
                .tag(cycle.id)
            }
        }
        .frame(height: 80)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.clear)
    }
    
    private func updateSelectedCycle() {
        let index = cycles.closestAccurateCycleIndex(from: internalTargetDate)
        if index >= 0 && index < cycles.count {
            selectedCycleId = cycles[index].id
        }
    }
    
    private func goalForCycle(_ cycle: Cycle) -> Goal? {
        cycleGoals.first { $0.cycleID == cycle.id }
    }
    
    @ViewBuilder
    private func progressBar(for cycle: Cycle?) -> some View {
        if let cycle = cycle {
            ProgressView(value: cycle.progressRatio())
                .tint(Color.accentColor)
                .frame(height: 20)
        } else {
            EmptyView()
        }
    }
}
