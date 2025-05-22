import SwiftUI

struct CycleProgressView: View {
    @Binding var cycles: [Cycle]
    @Binding var overall: Cycle
    @Binding var cycleIndex: Int  // MainView에서 전달받음
    @Binding var isOverall: Bool        // MainView에서 컨트롤하는 상태

    // internalTargetDate로 Date.now 사용
    private var internalTargetDate: Date {
        Date.now
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if isOverall {
                overallProgressView
            } else {
                cycleProgressTabView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            withAnimation { isOverall.toggle() }
        }
        .onAppear(perform: updateSelectedCycle)
    }
    
    // MARK: - Overall ProgressView
    private var overallProgressView: some View {
    
            HStack(spacing: 4) {
                ForEach(cycles, id: \.id) { cycle in
                    progressBar(for: cycle)
                }
            }
        .frame(height: 80)
    }
    
    // MARK: - Cycle TabView
    private var cycleProgressTabView: some View {
        TabView(selection: $cycleIndex) {
            ForEach(Array(cycles.enumerated()), id: \.1.id) { index, cycle in
                VStack(alignment: .leading, spacing: 4) {
                    // optional: GoalView 등 삽입 가능
                    progressBar(for: cycle)
                }
                .tag(index) // 여기서 index를 tag로 지정
            }
        }
        .frame(height: 80)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.clear)
    }
    
    private func updateSelectedCycle() {
        if isOverall == false {
            let index = cycles.closestAccurateCycleIndex(from: internalTargetDate)
            if index >= 0 && index < cycles.count {
                cycleIndex = index
            }
        }
    }
    

    
    @ViewBuilder
    private func progressBar(for cycle: Cycle?) -> some View {
        if let cycle = cycle {
            ClippedProgressBar(progress: cycle.progressRatio())
                .tint(Color.accentColor)
                .frame(height: 20)
        } else {
            EmptyView()
        }
    }
}


struct ClippedProgressBar: View {
    var progress: Double // 0.0 ~ 1.0
    @State private var animateGradient = false
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height: CGFloat = 20

            ZStack(alignment: .leading) {
                // 🔽 배경 레이어 (흐릿한 이미지 or 그라데이션)
                Image("wave_background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .background(Color.deepCurrent)
                    .clipped()
                    .opacity(0.1)

                // 진행 이미지 + 그라데이션 애니메이션
                Image("wave_foreground")
                    .resizable()
                    .scaledToFill()
                    .frame(width:  width * progress, height: height)
                    .overlay(
                        // 그라데이션 애니메이션 오버레이
                        LinearGradient(
                            gradient: Gradient(colors: [.oceanSplash, .inkDepth, .oceanSplash]),
                            startPoint: animateGradient ? .trailing : .leading,
                            endPoint: animateGradient ? .trailing : .leading
                        )
                        .blendMode(.darken)
                        .opacity(0.7)
                        .animation(
                            .linear(duration: 5)
                                .repeatForever(autoreverses: true),
                            value: animateGradient
                        )
                    )
                    .clipped()
                    .onAppear {
                        animateGradient.toggle()
                    }
            }
            .frame(height: height)
            .clipShape(Capsule())
        }
        .frame(height: 20)
    }
}
