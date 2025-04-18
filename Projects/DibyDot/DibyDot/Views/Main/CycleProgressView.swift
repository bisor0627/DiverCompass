import SwiftUI

struct CycleProgressView: View {
    let progressList: [CycleProgress]
    let overallCycle: CycleProgress
    let currentCycle: CycleProgress?

    let globalGoal: GlobalGoal?
    let cycleGoals: [String: CycleGoal]

    @State private var showOverall: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                Text(showOverall ? "전체 목표" : "현재 사이클 목표")
                    .font(.caption)
                Text(goalTitle)
                    .font(.body)
                    if showOverall {
                        // 전체 사이클 진행률
                            HStack(spacing: 4) {
                                ForEach(progressList, id: \.name) { cycle in
                                createProgressBar(cycle: cycle)
                             }
                            }
                        createProgressText(cycle: overallCycle)
                    } else {
                        // 현재 사이클 진행률
                        createProgressBar(cycle: currentCycle)
                        createProgressText(cycle: currentCycle)
                    }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            withAnimation {
                showOverall.toggle()
            }
        }
        
    }

    private var goalTitle: String {
        if showOverall {
            return globalGoal?.title ?? "목표가 아직 없어요!"
        } else {
            if let name = currentCycle?.name,
               let goal = cycleGoals[name] {
                return goal.title
            } else {
                return "사이클 목표를 설정해보세요"
            }
        }
    }

    @ViewBuilder
    func createProgressBar(cycle: CycleProgress?) -> some View {
        if let cycle = cycle {
            ProgressView(value: cycle.progressRatio)
                .tint(Color.accentColor)
                .frame(height: 20)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func createProgressText(cycle: CycleProgress?) -> some View {
        if let cycle = cycle {
            Text("\(cycle.progressPercentage)% (\(cycle.daysPassed)/\(cycle.totalDays) days)")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            EmptyView()
        }
    }
}
