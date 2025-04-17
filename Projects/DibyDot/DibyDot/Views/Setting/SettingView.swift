import SwiftUI

struct SettingView: View {
    @Binding var globalGoal: GlobalGoal?
    @Binding var currentCycleGoal: CycleGoal?

    @State private var globalGoalText = ""
    @State private var cycleGoalText = ""
    @State private var popupMode: PopupCardMode? = nil

    private func showPopup(for mode: PopupCardMode) {
        switch mode {
        case .globalGoal:
            globalGoalText = globalGoal?.title ?? ""
        case .cycleGoal:
            cycleGoalText = currentCycleGoal?.title ?? ""
        case .reflection:
            break // 추후 구현 예정
        }
        popupMode = mode
    }

    var body: some View {
        ZStack {
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
                    if let goal = currentCycleGoal {
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

                Spacer()
            }

            // PopupCardView
            if let mode = popupMode {
                PopupCardView(
                    isPresented: Binding(
                        get: { popupMode != nil },
                        set: { if !$0 { popupMode = nil } }
                    ),
                    text: bindingText(for: mode),
                    mode: mode,
                    onSave: {
                        switch mode {
                        case .globalGoal:
                            globalGoal = GlobalGoal(
                                id: globalGoal?.id ?? UUID(),
                                title: globalGoalText,
                                period: kCycles.first!.startDate...kCycles.last!.endDate
                            )
                        case .cycleGoal:
                            if let current = CycleProgressUtil.currentCycle(from: CycleProgressUtil.generateProgressList(from: kCycles)) {
                                currentCycleGoal = CycleGoal(
                                    id: currentCycleGoal?.id ?? UUID(),
                                    cycleName: current.name,
                                    title: cycleGoalText,
                                    createdAt: Date()
                                )
                            }
                        case .reflection:
                            break // 추후 구현 예정
                        }
                    },
                    onDelete: {
                        switch mode {
                        case .globalGoal:
                            globalGoal = nil
                        case .cycleGoal:
                            currentCycleGoal = nil
                        case .reflection:
                            break // 추후 구현 예정
                        }
                    }
                )
            }
        }
        .animation(
            .easeInOut,
            value: popupMode
        )
        .navigationTitle("목표/회고 설정")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func bindingText(for mode: PopupCardMode) -> Binding<String> {
        switch mode {
        case .globalGoal:
            return $globalGoalText
        case .cycleGoal:
            return $cycleGoalText
        case .reflection:
            return .constant("") // 회고용은 추후 구현
        }
    }
} 
