import SwiftUI

struct BubbleView: View {
    let maxHeight: CGFloat
    @State private var yOffset: CGFloat = .zero
    @State private var delay: Double = .zero

    var body: some View {
        Circle()
            .fill(Color.white.opacity(0.2))
            .frame(width: CGFloat.random(in: 10...25))
            .offset(y: yOffset)
            .onAppear {
                delay = Double.random(in: 0...2)
                withAnimation(
                    .easeOut(duration: Double.random(in: 5...8))
                    .delay(delay)
                    .repeatForever(autoreverses: false)
                ) {
                    yOffset = -maxHeight - 50
                }
            }
    }
}
