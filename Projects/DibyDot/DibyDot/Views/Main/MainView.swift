import SwiftUI

struct MainView: View {

    private var progressList: [CycleProgress] {
    CycleProgressUtil.generateProgressList(from: kCycles)
    }

    private var currentCycle: CycleProgress? {
        CycleProgressUtil.currentCycle(from: progressList)
    }

    private var overallCycle: CycleProgress {
        CycleProgressUtil.overallProgress(from: kCycles)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink(destination: SettingView()) {
                    Text("🎯 목표/회고 설정")
                }
                CycleProgressView(
                    isOverall: true,
                    progressList: progressList,
                    currentCycle: overallCycle
                )
                CycleProgressView(
                    isOverall: false,
                    progressList: progressList,
                    currentCycle: currentCycle
                )

            }
            .padding()
            .navigationTitle("나의 여정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}
