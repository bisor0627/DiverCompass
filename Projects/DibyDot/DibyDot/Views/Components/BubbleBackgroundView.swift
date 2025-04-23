import SwiftUI
struct BubbleBackgroundView: View {
    var topRatio: CGFloat = 0.4

    var body: some View {
        GeometryReader { geometry in
            let safeAreaInsets = geometry.safeAreaInsets
            let maxHeight = geometry.size.height - safeAreaInsets.top - safeAreaInsets.bottom
            VStack(spacing: 0) {
                Color(UIColor.systemBackground)
                    .frame(height: maxHeight * topRatio)

                ZStack {
                    OceanBackgroundView()
                    BubbleOverlayView(bubbleArea: maxHeight * (1 - topRatio))
                }
            }
            .frame(height: geometry.size.height) // 전체 높이 보장
            .padding(.top)
            .padding(.bottom)
        }
        .ignoresSafeArea() // 이건 유지 (배경이 safe area까지 덮기 위해)
    }
}
