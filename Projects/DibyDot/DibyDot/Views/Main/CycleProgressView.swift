import SwiftUI

struct CycleProgressView: View {
    let cycleProgressList: [CycleProgress]
    let overallCycleProgress: CycleProgress
    
    @Binding private var cycleIndex: Int
    @State private var showOverall: Bool = true

init(cycleProgressList: [CycleProgress], overallCycleProgress: CycleProgress, cycleIndex: Binding<Int>) {
    self.cycleProgressList = cycleProgressList
    self.overallCycleProgress = overallCycleProgress
    self._cycleIndex = cycleIndex
}
        
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                    if showOverall {
                        VStack{
                            HStack(spacing: 4) {
                                ForEach(cycleProgressList, id: \.name) { cycle in
                                    createProgressBar(cycle: cycle)
                                }
                            }
                            createProgressText(cycle: overallCycleProgress)
                        }
                        .frame(height: 70)
                    } else {
                        TabView(selection: $cycleIndex) {
                            ForEach(Array(cycleProgressList.enumerated()), id: \.0) { index, cycle in  
                                    VStack(alignment: .leading) {
                                        Text(cycle.name)
                                            .font(.caption)
                                            .bold()
                                        createProgressBar(cycle: cycle)
                                        createProgressText(cycle: cycle)
                                    }.tag(index)
                                }
                        }
                        .frame(height: 70)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .background(.clear)
                        .cornerRadius(12)
                    }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            withAnimation {
                showOverall.toggle()
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
