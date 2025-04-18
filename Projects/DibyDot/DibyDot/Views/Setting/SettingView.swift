import SwiftUI

struct SettingView: View {
    @Binding var globalGoal: GlobalGoal?
    @Binding var cycleGoals: [String: CycleGoal]
    var currentCycleName: String?

    @State private var globalGoalText = ""
    @State private var cycleGoalText = ""
    @State private var reflectionText = ""
    @State private var popupMode: PopupCardMode?

    @State private var reflections: [Reflection] = []
    @State private var selectedReflection: Reflection?

    private func showPopup(for mode: PopupCardMode) {
        switch mode {
        case .globalGoal:
            globalGoalText = globalGoal?.title ?? ""
        case .cycleGoal:
            if let currentName = currentCycleName {
                cycleGoalText = cycleGoals[currentName]?.title ?? ""
            } else {
                cycleGoalText = ""
            }
        case .reflection:
            reflectionText = selectedReflection?.content ?? ""
        }
        popupMode = mode
    }

    var body: some View {
        ZStack {
            BubbleBackgroundView()
            VStack(spacing: 20) {
                // GlobalGoal 표시 및 편집 섹션
                Section(header: Text("전체 목표").font(.headline)) {
                    if let goal = globalGoal {
                        HStack {
                            Text(goal.title)
                            Spacer()
                            Button("편집") {
                                showPopup(for: .globalGoal)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    } else {
                        Button("전체 목표 설정") {
                            showPopup(for: .globalGoal)
                        }
                        .padding()
                    }
                }

                // CycleGoal 표시 및 편집 섹션
                Section(header: Text("현재 사이클 목표").font(.headline)) {
                    if let currentName = currentCycleName,
                       let goal = cycleGoals[currentName] {
                        HStack {
                            Text(goal.title)
                            Spacer()
                            Button("편집") {
                                showPopup(for: .cycleGoal)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    } else {
                        Button("사이클 목표 설정") {
                            showPopup(for: .cycleGoal)
                        }
                        .padding()
                    }
                }

                // 회고 작성 버튼
                Section(header: Text("회고").font(.headline)) {
                    Button("회고 작성하기") {
                        selectedReflection = nil
                        showPopup(for: .reflection)
                    }
                    .padding(.vertical, 4)

                    ForEach(reflections.reversed()) { reflection in
                        Button {
                            selectedReflection = reflection
                            showPopup(for: .reflection)
                        } label: {
                            HStack(alignment: .top) {
                                Image(systemName: "bubble.left.fill")
                                    .foregroundColor(.blue)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(reflection.content)
                                        .font(.body)
                                    if let name = reflection.cycleNameAtWrittenTime {
                                        Text("\u{1F4CD} \(name)")
                                            .font(.caption2)
                                            .foregroundColor(.blue)
                                    }
                                    Text(reflection.createdAt, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .buttonStyle(.plain)
                    }
                }

                Spacer()
            }

            // PopupCardView
            if let mode = popupMode {
                PopupCardView(
                    isPresented: Binding(
                        get: { popupMode != nil },
                        set: { if !$0 { popupMode = nil; selectedReflection = nil } }
                    ),
                    text: bindingText(for: mode),
                    mode: mode,
                    onSave: {
                        switch mode {
                        case .globalGoal:
                            guard let firstCycle = kCycles.first,
                                  let lastCycle = kCycles.last else { return }
                            globalGoal = GlobalGoal(
                                id: globalGoal?.id ?? UUID(),
                                title: globalGoalText,
                                period: firstCycle.startDate...lastCycle.endDate
                            )
                        case .cycleGoal:
                            if let currentName = currentCycleName {
                                cycleGoals[currentName] = CycleGoal(
                                    id: cycleGoals[currentName]?.id ?? UUID(),
                                    cycleName: currentName,
                                    title: cycleGoalText,
                                    createdAt: Date()
                                )
                            }
                        case .reflection:
                            if let selected = selectedReflection {
                                if let index = reflections.firstIndex(where: { $0.id == selected.id }) {
                                    reflections[index].content = reflectionText
                                }
                            } else {
                                let newReflection = Reflection(
                                    id: UUID(),
                                    content: reflectionText,
                                    createdAt: Date(),
                                    cycleNameAtWrittenTime: currentCycleName,
                                    linkedGoalID: currentCycleName.flatMap { cycleGoals[$0]?.id }
                                )
                                reflections.insert(newReflection, at: 0)
                            }
                        }
                    },
                    onDelete: {
                        switch mode {
                        case .globalGoal:
                            globalGoal = nil
                        case .cycleGoal:
                            if let currentName = currentCycleName {
                                cycleGoals.removeValue(forKey: currentName)
                            }
                        case .reflection:
                            if let selected = selectedReflection {
                                reflections.removeAll { $0.id == selected.id }
                            }
                        }
                    }
                ).transition(.opacity)
                    .zIndex(1)
            }
        }
        .navigationTitle("목표/회고 설정")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
        .animation(.easeInOut(duration: 0.3), value: popupMode)
    }

    private func bindingText(for mode: PopupCardMode) -> Binding<String> {
        switch mode {
        case .globalGoal:
            return $globalGoalText
        case .cycleGoal:
            return $cycleGoalText
        case .reflection:
            return $reflectionText
        }
    }
}
