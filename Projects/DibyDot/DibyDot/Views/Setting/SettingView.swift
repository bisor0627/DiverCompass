import SwiftUI

struct SettingView: View {
    let progressList: [CycleProgress]

    @Binding var globalGoal: GlobalGoal?
    @Binding var cycleGoals: [String: CycleGoal]
    var currentCycleId: UUID?

    @State private var reflections: [Reflection] = []

    @State private var popupMode: PopupCardMode?
    @State private var globalGoalText = ""
    @State private var cycleGoalText = ""
    @State private var reflectionText = ""
    @State private var selectedReflection: Reflection?
    @State private var selectedTabIndex: Int = 0

    var body: some View {
        ZStack(alignment: .top) {
            BubbleBackgroundView()

            VStack(alignment: .leading, spacing: 16) {

                Text("전체 여정")
                    .font(.title2)
                    .bold()

                GoalInputBubble(
                    text: globalGoal?.title ?? "나의 여정을 어떻게 마무리하고 싶나요?",
                    isPlaceholder: globalGoal == nil,
                    onTap: {
                        popupMode = .globalGoal
                        globalGoalText = globalGoal?.title ?? ""
                    }
                )

                Text("단위 여정")
                    .font(.title3)
                    .bold()

                TabView(selection: $selectedTabIndex) {
                    ForEach(Array(progressList.enumerated()), id: \.0) { index, cycle in
                        VStack(alignment: .leading) {
                            Text(cycle.name)
                                .font(.headline)
                                .bold()
                            let goal = cycleGoals[cycle.name]
                            GoalInputBubble(
                                text: goal?.title ?? "\(cycle.name)의 목표를 입력해주세요",
                                isPlaceholder: goal == nil,
                                onTap: {
                                    selectedTabIndex = index
                                    popupMode = .cycleGoal
                                    cycleGoalText = goal?.title ?? ""
                                }
                            )
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 70)
                .background(.thinMaterial)
                .cornerRadius(12)

                Section(header: Text("회고 작성하기").bold()) {
                    Button("+ 회고 작성") {
                        selectedReflection = nil
                        reflectionText = ""
                        popupMode = .reflection
                    }
                }

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
            .padding()
            .onAppear {
                let closestIndex = kCycles.closestUpcomingCycleIndex()
                if !progressList.isEmpty && closestIndex < progressList.count {
                    selectedTabIndex = closestIndex
                } else {
                    selectedTabIndex = 0
                }
            }
            .popupOverlay(
                mode: popupMode,
                isPresented: Binding(
                    get: { popupMode != nil },
                    set: { if !$0 { popupMode = nil; selectedReflection = nil } }
                ),
                text: bindingText(for: popupMode),
                onSave: handleSave,
                onDelete: handleDelete
            )
            .navigationTitle("목표/회고 설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func bindingText(for mode: PopupCardMode?) -> Binding<String> {
        switch mode {
        case .globalGoal: return $globalGoalText
        case .cycleGoal: return $cycleGoalText
        case .reflection: return $reflectionText
        case .none: return .constant("")
        }
    }

    private func handleSave() {
        guard let mode = popupMode else { return }

        switch mode {
        case .globalGoal:
            guard let first = kCycles.first, let last = kCycles.last else { return }
            globalGoal = GlobalGoal(
                id: globalGoal?.id ?? UUID(),
                title: globalGoalText,
                period: first.startDate...last.endDate
            )

        case .cycleGoal:
            let selectedCycleName = progressList[selectedTabIndex].name
            cycleGoals[selectedCycleName] = CycleGoal(
                id: cycleGoals[selectedCycleName]?.id ?? UUID(),
                cycleName: selectedCycleName,
                title: cycleGoalText,
                createdAt: Date()
            )

        case .reflection:
            if let selected = selectedReflection {
                if let idx = reflections.firstIndex(where: { $0.id == selected.id }) {
                    reflections[idx].content = reflectionText
                }
            } else {
                let new = Reflection(
                    content: reflectionText,
                    createdAt: Date(),
                    cycleID: currentCycleId
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
        case .globalGoal:
            globalGoal = nil
        case .cycleGoal:
            let selectedCycleName = progressList[selectedTabIndex].name
            cycleGoals.removeValue(forKey: selectedCycleName)
        case .reflection:
            if let selected = selectedReflection {
                reflections.removeAll { $0.id == selected.id }
            }
        }

        popupMode = nil
        selectedReflection = nil
    }
}



struct GoalInputBubble: View {
    let text: String
    let isPlaceholder: Bool
    let onTap: () -> Void

    var body: some View {
        Text(text)
            .foregroundColor(isPlaceholder ? .gray : .primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(Color(white: 1, opacity: 0.7))
            )
            .overlay(
                Capsule()
                    .stroke(isPlaceholder ? .gray.opacity(0.5) : .gray.opacity(0.2))
            )
            .onTapGesture { onTap() }
    }
}

struct ReflectionBubble: View {
    let reflection: Reflection
    let onTap: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(reflection.content)
                    .font(.body)

                if let cycle = reflection.cycleID {
                    Text("📍 \(cycle)")
                        .font(.caption2)
                        .foregroundColor(.blue)
                }

                Text(reflection.createdAt, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(Color(white: 1, opacity: 0.7))
        )
        .overlay(
            Capsule()
                .stroke(.gray.opacity(0.2))
        )
        .onTapGesture { onTap() }
    }
}

extension View {
    func popupOverlay(
        mode: PopupCardMode?,
        isPresented: Binding<Bool>,
        text: Binding<String>,
        onSave: @escaping () -> Void,
        onDelete: (() -> Void)? = nil
    ) -> some View {
        self.overlay {
            if isPresented.wrappedValue {
                PopupCardView(
                    isPresented: isPresented,
                    text: text,
                    mode: mode ?? .globalGoal,
                    onSave: onSave,
                    onDelete: onDelete
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}
extension Array where Element == Cycle {
    /// 오늘 포함으로 가장 가까운 이후 Cycle의 index 반환
    /// - Returns: 오늘 포함되는 Cycle 또는 가장 가까운 미래 Cycle의 index (없으면 마지막 index)
    func closestUpcomingCycleIndex(from today: Date = .now) -> Int {
        // 1️⃣ 오늘이 포함된 Cycle이 있다면
        if let currentIndex = self.firstIndex(where: { $0.dateRange.contains(today) }) {
            return currentIndex
        }

        // 2️⃣ 오늘 이후 시작되는 Cycle 중 가장 가까운 것
        if let (index, _) = self.enumerated()
            .filter({ $0.element.startDate > today })
            .min(by: { $0.element.startDate < $1.element.startDate }) {
            return index
        }

        // 3️⃣ 모든 Cycle이 지난 경우
        return self.count - 1
    }
}
