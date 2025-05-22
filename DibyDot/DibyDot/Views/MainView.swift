import SwiftUI

struct MainView: View {
    
    @State private var cycles: [Cycle] = kCycles
    @State private var overall: Cycle = overallCycle
    @State private var cycleIndex: Int = kCycles.closestAccurateCycleIndex(from: .now)
    @State private var isOverall: Bool = true   // MainView에서 전체/개별 탭 뷰를 제어

    var body: some View {
        NavigationStack {
            SplitView {
                VStack(spacing: 20) {
                    Spacer()
                    CycleTitle(
                        cycles: $cycles,
                        overall: $overall,
                        cycleIndex: $cycleIndex,
                        isOverall: $isOverall
                    )
                    ProgressTextView(
                        cycles: $cycles,
                        overall: $overall,
                        cycleIndex: $cycleIndex,
                        isOverall: $isOverall
                    )
                    Spacer()
                    CycleProgressView(
                        cycles: $cycles,
                        overall: $overall,
                        cycleIndex: $cycleIndex,
                        isOverall: $isOverall   // Binding 전달
                    )
                }
            } bottomContent: {
                VStack(spacing: 20) {
                   
                    Spacer()
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


