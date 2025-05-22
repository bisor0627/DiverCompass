import SwiftUI

struct BubbleOverlayView: View {
    let bubbleArea: CGFloat
    let numberOfBubbles: Int
    
    // 버블 속성 범위 설정
    private let opacityRange: ClosedRange<Double> = 0.2...0.5
    private let scaleRange: ClosedRange<Double> = 0.4...1.2
    private let horizontalOffsetRange: ClosedRange<CGFloat> = -150...150
    
    // 기본 생성자
    init(bubbleArea: CGFloat, numberOfBubbles: Int = 16) {
        self.bubbleArea = bubbleArea
        self.numberOfBubbles = numberOfBubbles
    }

    var body: some View {
        ZStack {
            ForEach(0..<numberOfBubbles, id: \.self) { index in
                BubbleView(maxHeight: bubbleArea)
                    .opacity(Double.random(in: opacityRange))
                    .scaleEffect(Double.random(in: scaleRange))
                    .offset(x: CGFloat.random(in: horizontalOffsetRange))
                    .id(UUID()) // 독립적 렌더링 보장
            }
        }
    }
}
