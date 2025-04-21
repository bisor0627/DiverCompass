import SwiftUI

struct CycleProgressView: View {
    let cycleList: [Cycle]
    let overallCycle: Cycle
    @Binding private var targetDate: Date
    
    @Binding private var cycleIndex: Int
    @State private var showOverall: Bool = true

init(cycleList: [Cycle], overallCycle: Cycle, cycleIndex: Binding<Int>, targetDate: Binding<Date>) {
    self.cycleList = cycleList
    self.overallCycle = overallCycle
    self._cycleIndex = cycleIndex
    self._targetDate = targetDate
}
        
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                    if showOverall {
                        VStack{
                            HStack(spacing: 4) {
                                ForEach(cycleList, id: \.name) { cycle in
                                    createProgressBar(cycle: cycle)
                                }
                            }
                            createProgressText(cycle: overallCycle)
                        }
                        .frame(height: 70)
                    } else {
                        TabView(selection: $cycleIndex) {
                            ForEach(Array(cycleList.enumerated()), id: \.0) { index, cycle in  
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
    func createProgressBar(cycle: Cycle?) -> some View {
        if let cycle = cycle {
            ProgressView(value: cycle.progressRatio(target: targetDate))
                .tint(Color.accentColor)
                .frame(height: 20)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func createProgressText(cycle: Cycle?) -> some View {
        if let cycle = cycle {
            Text("\(cycle.progressPercentage(target: targetDate))%\t \(cycle.daysPassed(target: targetDate))/\(cycle.totalDays) days\t Remaining... \(cycle.daysRemaining(target: targetDate)) days")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            EmptyView()
        }
    }
}
