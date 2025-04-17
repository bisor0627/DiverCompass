import SwiftUI

struct SettingView: View {
    @Binding var globalGoal: GlobalGoal?
    @Binding var currentCycleGoal: CycleGoal?
    @State private var showDialog = false

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
                            // 전체 목표 편집 로직
                            showDialog = true
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                } else {
                    Button("전체 목표 설정") {
                        showDialog = true
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
                            // 사이클 목표 편집 로직
                            showDialog = true
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                } else {
                    Button("사이클 목표 설정") {
                        showDialog = true
                    }
                    .padding()
                }
            }
            
            Spacer()
        }
        
        // 커스텀 다이얼로그
        if showDialog {
            PopupCardView(
                isPresented: $showDialog,
                globalGoal: $globalGoal
            )
        }
    }
    .animation(
        .easeInOut,
        value: showDialog
    )
    .navigationTitle("목표/회고 설정")
    .navigationBarTitleDisplayMode(.inline)
    .padding()
}
}

