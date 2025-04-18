import SwiftUI

struct CycleProgressView: View {
    let isOverall: Bool
    let progressList: [CycleProgress]
    let currentCycle: CycleProgress?

    var body: some View {
        VStack(spacing: 8) {
            if isOverall {
            
                HStack(spacing: 4) {
                    ForEach(progressList, id: \.name) { cycle in
                        createProgressBar(cycle: cycle)
                    }
                }
                createProgressText(cycle: currentCycle)
            } else {                
                createProgressBar(cycle: currentCycle)
                createProgressText(cycle: currentCycle)
            }
        }
    }

    @ViewBuilder
    func createProgressBar(cycle: CycleProgress?) -> some View {
        if let cycle = cycle {
            let progress = cycle.progressRatio
            let color = Color.accentColor

                ProgressView(value: cycle.progressRatio)
                    .tint(color)
                    .frame(height: 20)
            }
         else {
            EmptyView()
        }
    }

    func createProgressText(cycle: CycleProgress?) -> some View {
        if let cycle = cycle {
            Text("\(Int(cycle.progressRatio * 100))% (\(cycle.daysPassed)/\(cycle.totalDays) days)")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            Text("현재 진행 중인 사이클이 없습니다.")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}



