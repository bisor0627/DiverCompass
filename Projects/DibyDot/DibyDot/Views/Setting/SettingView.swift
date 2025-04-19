import SwiftUI

struct SettingView: View {
    let progressList: [CycleProgress]

    @Binding var globalGoal: GlobalGoal?
    @Binding var cycleGoals: [String: CycleGoal]
    var currentCycleName: String?

    @State private var reflections: [Reflection] = []

    @State private var popupMode: PopupCardMode?
    @State private var globalGoalText = ""
    @State private var cycleGoalText = ""
    @State private var reflectionText = ""
    @State private var selectedReflection: Reflection?
    @State private var editingCycleName: String? = nil

    private func showPopup(for mode: PopupCardMode, cycleName: String? = nil) {
        switch mode {
        case .globalGoal:
            globalGoalText = globalGoal?.title ?? ""
        case .cycleGoal:
            let name = cycleName ?? currentCycleName
            editingCycleName = name
            cycleGoalText = name.flatMap { cycleGoals[$0]?.title } ?? ""
        case .reflection:
            reflectionText = selectedReflection?.content ?? ""
        }
        popupMode = mode
    }

    var body: some View {
        ZStack(alignment: .top) {
            BubbleBackgroundView()
            VStack(alignment: .leading) {
            Button("회고 작성하기") {
                selectedReflection = nil
                reflectionText = "" // ✅ 회고 텍스트 초기화
                popupMode = .reflection
            }
            Section(header: Text("전체 여정").font(.headline)) {
                GoalInputBubble(
                    text: globalGoal?.title ?? "나의 여정을 어떻게 마무리하고 싶나요?",
                    isPlaceholder: globalGoal == nil,
                    onTap: {
                        showPopup(for: .globalGoal)
                    }
                )
            }
            Section(header: Text("단위 여정").font(.headline))
                {
                    ScrollViewReader{ proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(progressList, id: \.name) { cycle in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(cycle.name)
                                        .font(.headline)
                                        .bold()

                                    let goal = cycleGoals[cycle.name]
                                    GoalInputBubble(
                                        text: goal?.title ?? "\(cycle.name)의 목표를 입력해주세요",
                                        isPlaceholder: goal == nil,
                                        onTap: {
                                            showPopup(for: .cycleGoal, cycleName: cycle.name)
                                        }
                                    )
                                }
                                .id(cycle.name) // ✅ scrollTo 대상 ID
                            }
                        }
                        .padding(.horizontal)
                    }
                    .onAppear {
                        if let closest = findClosestCycleName(to: Date()) {
                            withAnimation {
                                proxy.scrollTo(closest, anchor: .leading) // ✅ 가운데 정렬
                            }
                        }
                    }
                    }
                }
                Section(header: Text("회고").font(.headline)) {
                    VStack {
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
        .popupOverlay(
            mode: popupMode,
            isPresented: Binding(
                get:
                    {
                    popupMode != nil
                    },
                set:
                    {
                        if !$0 {
                            popupMode = nil;
                            selectedReflection = nil;
                            editingCycleName = nil
                        }
                    }
            ),
            text: bindingText(for: popupMode),
            onSave: handleSave,
            onDelete: handleDelete
        )
        .navigationTitle("목표/회고 설정")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func bindingText(for mode: PopupCardMode?) -> Binding<String> {
        switch mode {
        case .globalGoal:
            return $globalGoalText
        case .cycleGoal:
            return $cycleGoalText
        case .reflection:
            return $reflectionText
        case .none:
            return .constant("")
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
            if let name = editingCycleName {
                cycleGoals[name] = CycleGoal(
                    id: cycleGoals[name]?.id ?? UUID(),
                    cycleName: name,
                    title: cycleGoalText,
                    createdAt: Date()
                )
            }

        case .reflection:
            if let selected = selectedReflection {
                if let idx = reflections.firstIndex(where: { $0.id == selected.id }) {
                    reflections[idx].content = reflectionText
                }
            } else {
                let new = Reflection(
                    content: reflectionText,
                    createdAt: Date(),
                    cycleNameAtWrittenTime: currentCycleName,
                    linkedGoalID: currentCycleName.flatMap { cycleGoals[$0]?.id }
                )
                reflections.insert(new, at: 0)
            }
        }

        popupMode = nil
        selectedReflection = nil
        editingCycleName = nil
    }

    private func handleDelete() {
        guard let mode = popupMode else { return }

        switch mode {
        case .globalGoal:
            globalGoal = nil

        case .cycleGoal:
            if let name = editingCycleName {
                cycleGoals.removeValue(forKey: name)
            }

        case .reflection:
            if let selected = selectedReflection {
                reflections.removeAll { $0.id == selected.id }
            }
        }

        popupMode = nil
        selectedReflection = nil
        editingCycleName = nil
    }

    private func findClosestCycleName(to date: Date) -> String? {
    let sorted = kCycles.sorted {
        abs($0.startDate.timeIntervalSince(date)) < abs($1.startDate.timeIntervalSince(date))
    }
    return sorted.first?.name
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

                if let cycle = reflection.cycleNameAtWrittenTime {
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
