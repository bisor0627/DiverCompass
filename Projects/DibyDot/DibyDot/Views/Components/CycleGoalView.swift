import SwiftUI

struct CycleGoalView: View {
    let cycle: Cycle
    let goal: Goal?
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(cycle.name) (\(cycle.periodString))")
                .font(.preTitle)
                .bold()
            GoalInputBubble(
                text: goal?.title ?? "\(cycle.name)의 목표를 입력해주세요",
                isPlaceholder: goal == nil,
                onTap: onTap
            )
        }
    }
}
