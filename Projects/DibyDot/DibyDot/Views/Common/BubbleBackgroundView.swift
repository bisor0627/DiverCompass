import SwiftUI

struct BubbleBackgroundView: View {
    // 상단 비율을 매개변수화 (기본값 35%)
    var topRatio: CGFloat = 0.35

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                // 다크 모드 지원을 위한 적응형 색상 사용
                Color(UIColor.systemBackground)
                    .frame(height: geo.size.height * topRatio)

                ZStack {
                    OceanBackgroundView()
                    BubbleOverlayView(bubbleArea: geo.size.height * (1 - topRatio))
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
