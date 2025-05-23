import SwiftUI

struct CycleTitleView: View {
    @Binding var cycles: [Cycle]
    @Binding var overall: Cycle
    @Binding var cycleIndex: Int
    @Binding var isOverall: Bool

    var body: some View {
        // isOverall이 true일 때 overall을 사용하고, false일 때 cycleIndex에 해당하는 cycle을 사용
        let cycle: Cycle = isOverall ? overall : cycles[cycleIndex]

        Text(cycle.name)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.seabed)
    }
}
