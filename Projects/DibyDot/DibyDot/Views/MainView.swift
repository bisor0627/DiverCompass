import SwiftUI

struct MainView: View {

    @State private var overallGoal: Goal?
    @State private var cycleGoals: [String: Goal] = [:]
    @State private var currentDate: Date = .now
    @State private var cycles: [Cycle] = childCycles(of: kCycles.topLevelCycles.first!, in: kCycles)
    @State private var overall: Cycle = kCycles.topLevelCycles.first!
    @State private var cycleIndex: Int =
    kCycles.closestAccurateCycleIndex(from: .now)
    
 
    var body: some View {
        ZStack {
            BubbleBackgroundView()
            NavigationStack {
                VStack(spacing: 20) {
                    NavigationLink(
                        destination: SettingView(
                            currentCycleId: kCycles[kCycles.closestAccurateCycleIndex()].id, cycles: $cycles,
                            overallGoal: $overallGoal,
                            cycleGoals: $cycleGoals
                        )
                    ) {
                        Text("🎯 목표/회고 설정")
                            .tint(.oceanSplash)
                    }
                    
                   CycleProgressView(
                    cycles: $cycles,
                    overall: $overall,
                    targetDate: $currentDate,
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
                                cycleIndex = cycles.closestAccurateCycleIndex(from: currentDate)
                                
                            }
                            .buttonStyle(.bordered)
                            Button("하루 후 ▶︎") {
                                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                                cycleIndex = cycles.closestAccurateCycleIndex(from: currentDate)
                                
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
