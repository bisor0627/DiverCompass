import SwiftUI

struct BubbleOverlayView: View {
    let bubbleArea: CGFloat
    let numberOfBubbles = 12

    var body: some View {
        ZStack {
            ForEach(0..<numberOfBubbles, id: \.self) { index in
                BubbleView(maxHeight: bubbleArea)
                    .opacity(Double.random(in: 0.2...0.5))
                    .scaleEffect(Double.random(in: 0.4...1.2))
                    .offset(x: CGFloat.random(in: -150...150))
            }
        }
    }
}
