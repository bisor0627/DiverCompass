import SwiftUI

struct PopupCardView: View {
    @Binding var isPresented: Bool
    @State private var text: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Button("취소") {
                isPresented = false
            }
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal, 40)
    }
}
