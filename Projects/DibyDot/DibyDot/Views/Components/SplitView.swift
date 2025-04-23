import SwiftUI

struct SplitView<Top: View, Bottom: View>: View {
    let topContent: () -> Top
    let bottomContent: () -> Bottom

    var body: some View {
        GeometryReader { geometry in
            let safeAreaInsets = geometry.safeAreaInsets
            let maxHeight = geometry.size.height - safeAreaInsets.top - safeAreaInsets.bottom

            ZStack(alignment: .topLeading) {
                BubbleBackgroundView(topRatio: 0.35)

                VStack(spacing: 0) {
                    topContent()
                        .frame(height: maxHeight * 0.35)
                    bottomContent()
                        .frame(height: maxHeight * 0.65)
                }
                .padding(.top)
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
    }
}
