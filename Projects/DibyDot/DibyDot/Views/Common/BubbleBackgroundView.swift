import SwiftUI

struct BubbleBackgroundView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Color.white
                    .frame(height: geo.size.height * 0.35)

                ZStack {
                    OceanBackgroundView()
                    BubbleOverlayView(bubbleArea: geo.size.height * 0.65)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
