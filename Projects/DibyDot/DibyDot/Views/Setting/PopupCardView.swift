import SwiftUI

struct PopupCardView: View {
    @Binding var isPresented: Bool
    @Binding var globalGoal: GlobalGoal?

    @State private var text: String = ""

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("전체 목표 입력")
                    .font(.headline)

                TextField("목표 입력", text: $text)
                    .textFieldStyle(.roundedBorder)

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
            .padding()
            .background(.thinMaterial)
            .cornerRadius(16)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
            .onAppear {
                if let goal = globalGoal {
                    text = goal.title
                }
            }
        }
    }
}
