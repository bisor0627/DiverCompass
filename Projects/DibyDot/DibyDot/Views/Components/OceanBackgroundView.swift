import SwiftUI

struct OceanBackgroundView: View {
    @State private var animateOpacity: Bool = false
    private let animationDuration: Double = 3
    private let gradientColors = [
        (Color.cyan, (min: 0.4, max: 0.6)),
        (Color.teal, (min: 0.6, max: 0.8)),
        (Color.teal, (min: 0.9, max: 1.0)),
        (Color.teal, (min: 0.7, max: 0.9))
    ]

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                gradientColors[0].0.opacity(animateOpacity ? gradientColors[0].1.min : gradientColors[0].1.max),
                gradientColors[1].0.opacity(animateOpacity ? gradientColors[1].1.min : gradientColors[1].1.max),
                gradientColors[2].0.opacity(animateOpacity ? gradientColors[2].1.min : gradientColors[2].1.max),
                gradientColors[3].0.opacity(animateOpacity ? gradientColors[3].1.min : gradientColors[3].1.max)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .animation(.easeInOut(duration: animationDuration).repeatForever(autoreverses: true), value: animateOpacity)
        .onAppear {
            // 처음 한 번만 애니메이션 시작하기 위한 방어 코드 추가
            DispatchQueue.main.async {
                animateOpacity.toggle()
            }
        }
    }
}
