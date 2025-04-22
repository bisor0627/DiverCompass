import SwiftUI

struct CycleProgressView: View {
    @Binding  var cycles: [Cycle]
    @Binding  var overall: Cycle
    @Binding var targetDate: Date
    @Binding var cycleIndex: Int
    @State private var showOverall: Bool = true

    init(cycles: Binding<[Cycle]>, overall: Binding<Cycle>, targetDate: Binding<Date>, cycleIndex: Binding<Int>) {
        self._cycles = cycles
        self._overall = overall
        self._targetDate = targetDate
        self._cycleIndex = cycleIndex  // ✅ 외부 cycleIndex 연결
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                    if showOverall {
                        VStack{
                            HStack(spacing: 4) {
                                ForEach(cycles, id: \.id) {
                                    cycle in
                                      createProgressBar(cycle: cycle)
                                }
                            }
                            createProgressText(cycle: overall)
                        }
                        .frame(height: 70)
                    } else {
                        TabView(selection: $cycles[cycleIndex].id) {
                            ForEach(cycles) { cycle in
                                VStack(alignment: .leading) {
                                    Text(cycle.name).font(.caption).bold()
                                    createProgressBar(cycle: cycle)
                                    createProgressText(cycle: cycle)
                                }
                                .tag(cycle.id)
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
