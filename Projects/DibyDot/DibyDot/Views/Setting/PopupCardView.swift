import SwiftUI

enum PopupCardMode: Equatable {
    case globalGoal
    case cycleGoal
    case reflection
}

struct PopupCardView: View {
    @Binding var isPresented: Bool
    @Binding var text: String
    var mode: PopupCardMode
    var onSave: () -> Void
    var onDelete: (() -> Void)?
    @State private var backgroundOpacity: Double = 0
    var body: some View {
        ZStack {
            Color.black
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        backgroundOpacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isPresented = false
                    }
                }
            GeometryReader { geometry in
                let cardWidth = min(geometry.size.width * 0.85, 400)
                let editorHeight = max(geometry.size.height * 0.18, 120)

                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Text(titleText)
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

                            if let onDelete = onDelete {
                                Button("삭제") {
                                    onDelete()
                                    isPresented = false
                                }
                                .foregroundColor(.red)
                            }

                            Button("저장") {
                                onSave()
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
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        backgroundOpacity = 0.3
                    }
                }
            }
        }
    }

    private var titleText: String {
        switch mode {
        case .globalGoal: return "전체 목표 입력"
        case .cycleGoal: return "사이클 목표 입력"
        case .reflection: return "회고 작성"
        }
    }
}
