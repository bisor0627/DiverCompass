import SwiftUI
enum PopupCardIntent {
    case create
    case edit
}
enum PopupCardMode: Equatable {
    case overallGoal
    case cycleGoal
    case reflection
}

struct PopupCardView: View {
    @Binding var isPresented: Bool
    @Binding var text: String
    var mode: PopupCardMode
    var intent: PopupCardIntent = .create
    var onSave: () -> Void
    var onDelete: (() -> Void)?
    @State private var backgroundOpacity: Double = 0

    var body: some View {
        ZStack {
            Color.black
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
                .onTapGesture { dismissWithFade() }

            GeometryReader { geometry in
                let cardWidth = min(geometry.size.width * 0.85, 400)
                let editorHeight = max(geometry.size.height * 0.18, 120)

                VStack {
                    Spacer()

                    VStack(alignment: .leading, spacing: 16) {
                        // 상단 라벨 + 버튼
                        HStack(alignment: .center) {
                            Text(headerTitle)
                                .font(.headline)
                                .foregroundColor(.primary.opacity(0.9))

                            Spacer()

                            if intent == .edit, let onDelete = onDelete {
                                Button {
                                    onDelete()
                                    dismissWithFade()
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.black)
                                }
                            }

                            Button {
                                dismissWithFade()
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.primary.opacity(0.6))
                            }
                        }

                        ZStack(alignment: .topLeading) {
                            if text.isEmpty {
                                Text(placeholderText)
                                    .foregroundColor(.black.opacity(0.7))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 16)
                            }

                            TextEditor(text: $text)
                                .scrollContentBackground(.hidden)
                                .frame(height: editorHeight)
                                .padding(8)
                                .background(Color(.systemBackground).opacity(0.5))
                                .cornerRadius(14)
                        }

                        HStack {
                            Spacer()
                            Button("저장") {
                                text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                                onSave()
                                dismissWithFade()
                            }
                            .font(.callout.weight(.semibold))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray.opacity(0.3) : Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                    }
                    .padding(24)
                    .frame(width: cardWidth)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.15), radius: 16, x: 0, y: 10)
                    .transition(.scale.combined(with: .opacity))

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

    private func dismissWithFade() {
        withAnimation { backgroundOpacity = 0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }

    private var headerTitle: String {
        switch mode {
        case .overallGoal: return "전체 목표"
        case .cycleGoal: return "사이클 목표"
        case .reflection: return "오늘의 회고"
        }
    }

    private var placeholderText: String {
        switch mode {
        case .overallGoal:
            return "전체 여정을 통해 이루고 싶은 것은?"
        case .cycleGoal:
            return "이번 사이클에서 집중하고 싶은 것은?"
        case .reflection:
            return "오늘 어떤 순간을 기억하고 싶나요?"
        }
    }
}
