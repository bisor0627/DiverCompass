import SwiftUI

struct BubbleView: View {
    let maxHeight: CGFloat
    @State private var yOffset: CGFloat = .zero
    @State private var delay: Double = .zero
    
    // 커스터마이징 가능한 속성들
    var minSize: CGFloat = 10
    var maxSize: CGFloat = 25
    var minAnimationDuration: Double = 5
    var maxAnimationDuration: Double = 8
    var minDelay: Double = 0
    var maxDelay: Double = 2
    var bubbleOpacity: Double = 0.6
    
    // 버블 크기를 미리 계산하여 렌더링 성능 향상
    private let bubbleSize: CGFloat
    
    init(maxHeight: CGFloat, minSize: CGFloat = 10, maxSize: CGFloat = 25) {
        self.maxHeight = maxHeight
        self.minSize = minSize
        self.maxSize = maxSize
        self.bubbleSize = CGFloat.random(in: minSize...maxSize)
    }

    var body: some View {
        Circle()
            .fill(Color.white.opacity(Double.random(in: 0.1...bubbleOpacity))) // bubbleOpacity에 랜덤 값 추가
            .frame(width: bubbleSize)
            .offset(y: yOffset)
            .onAppear {
                delay = Double.random(in: minDelay...maxDelay)
                
                // 초기 yOffset을 maxHeight의 31%~90% 사이로 설정
                yOffset = maxHeight * CGFloat.random(in: 0.31...0.9)
                
                // 수직 애니메이션
                withAnimation(
                    .easeOut(duration: Double.random(in: minAnimationDuration...maxAnimationDuration))
                    .delay(delay)
                    .repeatForever(autoreverses: false)
                ) {
                    yOffset = -maxHeight - 50
                }
            }
    }
}
