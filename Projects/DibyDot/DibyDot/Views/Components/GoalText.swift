import SwiftUI

struct GoalView: View {
    let cycle: Cycle
    let goal: Goal?

    var body: some View {
        if let goal = goal {
            Text(goal.title)
                .font(.body)
        } else {
            Text("\(cycle.name)동안 어떤 것을 가꾸고 싶나요?")
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}