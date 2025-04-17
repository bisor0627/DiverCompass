import SwiftUI

struct PopupCardView: View {
    @Binding var isPresented: Bool
    @Binding var globalGoal: GlobalGoal?

    @State private var text: String = ""

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }

            GeometryReader { geometry in
    let cardWidth = min(geometry.size.width * 0.85, 400)
    let editorHeight = max(geometry.size.height * 0.18, 120) // 최소 120, 비율 적용

    VStack {
        Spacer()

        VStack(spacing: 20) {
            Text("전체 목표 입력")
                .font(.headline)

            TextEditor(text: $text)
                .frame(height: editorHeight)
                .background(Color(.systemBackground).opacity(0.6))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )

            HStack(spacing: 16) {
                Button("취소") {
                    isPresented = false
                }
                .foregroundColor(.red)

                if globalGoal != nil {
                    Button("삭제") {
                        globalGoal = nil
                        isPresented = false
                    }
                    .foregroundColor(.red)
                }

                Button(globalGoal == nil ? "저장" : "수정") {
                    let newGoal = GlobalGoal(
                        id: globalGoal?.id ?? UUID(),
                        title: text,
                        period: DateFormatter.kst.date(from: "2025-03-10")!...DateFormatter.kst.date(from: "2025-12-12")!
                    )
                    globalGoal = newGoal
                    isPresented = false
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .padding(24)
        .frame(width: cardWidth)
        .background(.thinMaterial)
        .cornerRadius(16)
        .shadow(radius: 10)

        Spacer()
    }
    .frame(width: geometry.size.width, height: geometry.size.height)
}
                       }
    }
}
