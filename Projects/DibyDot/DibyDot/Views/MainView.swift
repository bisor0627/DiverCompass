import SwiftUI

struct MainView: View {
    
    @State private var overallGoal: Goal?
    @State private var cycleGoals: [Goal] = []
    @State private var cycles: [Cycle] = childCycles(of: kCycles.topLevelCycles.first!, in: kCycles)
    @State private var overall: Cycle = kCycles.topLevelCycles.first!
    @State private var cycleIndex: Int = kCycles.closestAccurateCycleIndex(from: .now)
    @State private var reflections: [Reflection] = []
    @State private var selectedCycleId: UUID = kCycles.topLevelCycles.first?.id ?? UUID()  // MainView에서 제어
    @State private var isOverall: Bool = true   // MainView에서 전체/개별 탭 뷰를 제어

    var body: some View {
        NavigationStack {
            SplitView {
                VStack(spacing: 20) {
                    CycleTitle(
                        cycles: $cycles,
                        overall: $overall,
                        selectedCycleId: $selectedCycleId,
                        isOverall: $isOverall
                    )
                    Spacer()
                    CycleProgressView(
                        cycles: $cycles,
                        overall: $overall,
                        overallGoal: $overallGoal,
                        cycleGoals: $cycleGoals,
                        selectedCycleId: $selectedCycleId,
                        isOverall: $isOverall   // Binding 전달
                    )
                }
            } bottomContent: {
                VStack(spacing: 20) {
                    ProgressTextView(
                        cycles: $cycles,
                        overall: $overall,
                        selectedCycleId: $selectedCycleId,
                        isOverall: $isOverall
                    )
                    Spacer()
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: SettingView(
                            cycles: $cycles,
                            overall: $overall,
                            overallGoal: $overallGoal,
                            cycleGoals: $cycleGoals,
                            cycleIndex: $cycleIndex,
                            reflections: $reflections
                        )
                    ) {
                        Image(systemName: "ellipsis")
                            .symbolEffect(.scale.up.byLayer, options: .repeat(.periodic(delay: 20.0)))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func updateDate(by days: Int) {
        cycleIndex = cycles.closestAccurateCycleIndex(from: .now)
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


