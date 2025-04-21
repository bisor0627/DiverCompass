import SwiftUI

struct MainView: View {

    @State private var globalGoal: GlobalGoal?
    @State private var cycleGoals: [String: CycleGoal] = [:]

    @State private var currentDate: Date = .now

    private var progressList: [CycleProgress] {
        CycleProgressUtil.generateProgressList(from: kCycles, today: currentDate)
    }
    private var currentCycle: CycleProgress? {
        CycleProgressUtil.currentCycle(from: progressList)
    }
    private var overallCycle: CycleProgress {
        CycleProgressUtil.overallProgress(from: kCycles, today: currentDate)
    }

    var body: some View {
        ZStack {
            BubbleBackgroundView()
            NavigationStack {
                VStack(spacing: 20) {
                    NavigationLink(
                        destination: SettingView(
                            progressList: progressList,
                            globalGoal: $globalGoal,
                            cycleGoals: $cycleGoals,
                            currentCycleId: kCycles[kCycles.closestUpcomingCycleIndex()].id
                        )
                    ) {
                        Text("🎯 목표/회고 설정")
                            .tint(.oceanSplash)
                    }
                    
                   CycleProgressView(
                       progressList: progressList,
                       overallCycle: overallCycle
                   )
                    // 날짜 조작 테스트용 버튼
                    VStack(spacing: 10) {
                        Text("현재 날짜: \(formattedDate(currentDate))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        HStack(spacing: 16) {
                            Button("◀︎ 하루 전") {
                                currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                            }
                            .buttonStyle(.bordered)
                            Button("하루 후 ▶︎") {
                                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

#Preview {
    MainView()
}
