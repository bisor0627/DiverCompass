import SwiftUI

struct OceanBackgroundView: View {
    @State private var animateOpacity: Bool = false

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.cyan.opacity(animateOpacity ? 0.4 : 0.6),
                Color.teal.opacity(animateOpacity ? 0.6 : 0.8),
                Color.teal.opacity(animateOpacity ? 0.9 : 1.0),
                Color.teal.opacity(animateOpacity ? 0.7 : 0.9)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: animateOpacity)
        .onAppear {
            animateOpacity.toggle()
        }
    }
}
