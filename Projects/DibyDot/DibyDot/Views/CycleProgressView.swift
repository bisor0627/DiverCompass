import SwiftUI

struct CycleProgressView: View {
    @Binding  var cycles: [Cycle]
    @Binding  var overall: Cycle
    @Binding var targetDate: Date

    
    @Binding  var overallGoal: Goal?
    @Binding  var cycleGoals: [Goal]
    
    @State private var showOverall: Bool = true
    @State private var selectedCycleId: UUID?
    
    init(cycles: Binding<[Cycle]>, overall: Binding<Cycle>, targetDate: Binding<Date>, overallGoal: Binding<Goal?>, cycleGoals: Binding<[Goal]>) {
        self._cycles = cycles
        self._overall = overall
        self._targetDate = targetDate
        self._cycleGoals = cycleGoals
        self._overallGoal = overallGoal
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                    if showOverall {
                        
                        VStack{
                            Text(overallGoal?.title ?? "전체 목표를 설정해보세요")
                                            .font(.body)
                            HStack(spacing: 4) {
                                ForEach(cycles, id: \.id) {
                                    cycle in
                                      createProgressBar(cycle: cycle)
                                }
                            }
                            createProgressText(cycle: overall)
                        }
                        .frame(height: 80)
                    } else {
                        TabView(selection: $selectedCycleId) {
                            ForEach(Array(cycles.enumerated()), id: \.1.id) { index, cycle in
                                VStack(alignment: .leading) {
                                    goalView(for: cycle)
                                    createProgressBar(cycle: cycle)
                                    createProgressText(cycle: cycle)
                                }
                                .tag(cycle.id)
                            }
                        }
                      
                        .frame(height: 80)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .background(.clear)
                    }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            withAnimation {
                showOverall.toggle()
            }
        }
        .onAppear {
            let index = cycles.closestAccurateCycleIndex(from: targetDate)
            if index >= 0 && index < cycles.count {
                selectedCycleId = cycles[index].id
            }
        }
        .onChange(of: targetDate) { newDate in
            let index = cycles.closestAccurateCycleIndex(from: newDate)
            if index >= 0 && index < cycles.count {
                selectedCycleId = cycles[index].id
            }
        }
    }
    private func goalForCycle(_ cycle: Cycle) -> Goal? {
         return cycleGoals.first(where: { $0.cycleID == cycle.id })
     }
    @ViewBuilder
    func goalView(for cycle: Cycle) -> some View {
        if let goal = goalForCycle(cycle) {
            Text(goal.title)
                .font(.body)
        } else {
            Text("목표가 없습니다")
                .font(.body)
                .foregroundColor(.gray)
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

