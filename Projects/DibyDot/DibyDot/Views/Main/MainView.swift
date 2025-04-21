import SwiftUI

struct MainView: View {

    @State private var overallGoal: Goal?
    @State private var cycleGoals: [String: Goal] = [:]
    @State private var currentDate: Date = .now
    @State private var cycleIndex: Int = kCycles.closestAccurateCycleIndex()

    private var cycleProgressList: [CycleProgress] {
        kCycles.generateProgressList(today: currentDate)
    }
    private var overallCycleProgress: CycleProgress {
        kOverall.generateProgress(today: currentDate)
    }

    var body: some View {
        ZStack {
            BubbleBackgroundView()
            NavigationStack {
                VStack(spacing: 20) {
                    NavigationLink(
                        destination: SettingView(
                            cycleProgressList: cycleProgressList,
                            currentCycleId: kCycles[kCycles.closestAccurateCycleIndex()].id,
                            overallGoal: $overallGoal,
                            cycleGoals: $cycleGoals
                        )
                    ) {
                        Text("🎯 목표/회고 설정")
                            .tint(.oceanSplash)
                    }
                    
                   CycleProgressView(
                       cycleProgressList: cycleProgressList,
                       overallCycleProgress: overallCycleProgress,
                       cycleIndex: $cycleIndex
                       
                   )
                    // 날짜 조작 테스트용 버튼
                    VStack(spacing: 10) {
                        Text("현재 날짜: \(formattedDate(currentDate))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        HStack(spacing: 16) {
                            Button("◀︎ 하루 전") {
                                currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                                    cycleIndex = kCycles.closestAccurateCycleIndex(from: currentDate)
                            }
                            .buttonStyle(.bordered)
                            Button("하루 후 ▶︎") {
                                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                                    cycleIndex = kCycles.closestAccurateCycleIndex(from: currentDate)
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
