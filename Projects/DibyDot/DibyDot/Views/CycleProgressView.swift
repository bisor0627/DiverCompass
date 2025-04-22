import SwiftUI

struct CycleProgressView: View {
    @Binding var cycles: [Cycle]
    @Binding var overall: Cycle
    @Binding var targetDate: Date
    @Binding var overallGoal: Goal?
    @Binding var cycleGoals: [Goal]
    
    @State private var showOverall: Bool = true
    @State private var selectedCycleId: UUID?
    
    init(cycles: Binding<[Cycle]>,
         overall: Binding<Cycle>,
         targetDate: Binding<Date>,
         overallGoal: Binding<Goal?>,
         cycleGoals: Binding<[Goal]>) {
        self._cycles = cycles
        self._overall = overall
        self._targetDate = targetDate
        self._overallGoal = overallGoal
        self._cycleGoals = cycleGoals
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if showOverall {
                overallProgressView
            } else {
                cycleProgressTabView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            withAnimation {
                showOverall.toggle()
            }
        }
        .onAppear(perform: updateSelectedCycle)
        .onChange(of: targetDate) { newDate in
            updateSelectedCycle()
        }
    }
    
    private var overallProgressView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(overallGoal?.title ?? "전체 목표를 설정해보세요")
                .font(.body)
            HStack(spacing: 4) {
                ForEach(cycles, id: \.id) { cycle in
                    progressBar(for: cycle)
                }
            }
            progressText(for: overall)
        }
        .frame(height: 80)
    }
    
    private var cycleProgressTabView: some View {
        TabView(selection: $selectedCycleId) {
            ForEach(cycles, id: \.id) { cycle in
                VStack(alignment: .leading, spacing: 4) {
                    goalView(for: cycle)
                    progressBar(for: cycle)
                    progressText(for: cycle)
                }
                .tag(cycle.id)
            }
        }
        .frame(height: 80)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.clear)
    }
    
    private func updateSelectedCycle() {
        let index = cycles.closestAccurateCycleIndex(from: targetDate)
        if index >= 0 && index < cycles.count {
            selectedCycleId = cycles[index].id
        }
    }
    
    private func goalForCycle(_ cycle: Cycle) -> Goal? {
        cycleGoals.first(where: { $0.cycleID == cycle.id })
    }
    
    @ViewBuilder
    private func goalView(for cycle: Cycle) -> some View {
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
    private func progressBar(for cycle: Cycle?) -> some View {
        if let cycle = cycle {
            ProgressView(value: cycle.progressRatio(target: targetDate))
                .tint(Color.accentColor)
                .frame(height: 20)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func progressText(for cycle: Cycle?) -> some View {
        if let cycle = cycle {
            Text("\(cycle.progressPercentage(target: targetDate))% \(cycle.daysPassed(target: targetDate))/\(cycle.totalDays) days Remaining... \(cycle.daysRemaining(target: targetDate)) days")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            EmptyView()
        }
    }
}
