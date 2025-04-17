import SwiftUI

struct MainView: View {

    @State private var globalGoal: GlobalGoal?
    @State private var currentCycleGoal: CycleGoal?
    @State private var progressList: [CycleProgress] = CycleProgressUtil.generateProgressList(
        from: kCycles
    )
    private var currentCycle: CycleProgress? {
        CycleProgressUtil
            .currentCycle(
                from: progressList
            )
    }
    private var overallCycle: CycleProgress {
        CycleProgressUtil
            .overallProgress(
                from: kCycles
            )
    }
    
    var body: some View {
        NavigationStack {
            VStack(
                spacing: 20
            ) {
                NavigationLink(
                    destination: SettingView(
                        globalGoal: $globalGoal,
                        currentCycleGoal: $currentCycleGoal
                    )
                ) {
                    Text(
                        "🎯 목표/회고 설정"
                    )
                    .tint(
                        .oceanSplash
                    )
                }
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    Text(
                        "전체 목표"
                    )
                    .font(
                        .caption
                    )
                    Text(
                        globalGoal?.title ?? "목표가 아직 없어요!"
                    )
                    CycleProgressView(
                        isOverall: true,
                        progressList: progressList,
                        currentCycle: overallCycle
                    ).padding(
                        .vertical,
                        16
                    )
                }
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    Text(
                        "현재 사이클 목표"
                    )
                    .font(
                        .caption
                    )
                    Text(
                        currentCycleGoal?.title ?? "사이클 목표를 설정해보세요"
                    )
                    CycleProgressView(
                        isOverall: false,
                        progressList: progressList,
                        currentCycle: currentCycle
                    ).padding(
                        .vertical,
                        16
                    )
                }
            }
            .padding()
            .navigationTitle(
                "나의 여정"
            )
            .navigationBarTitleDisplayMode(
                .inline
            )
        }
    }
}

#Preview {
    MainView()
}
