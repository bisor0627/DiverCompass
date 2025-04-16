import SwiftUI

struct SettingView: View {
    @State private var showDialog = false

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Button("Dialog") {
                    showDialog = true
                }
                .padding()
            }
            // 커스텀 다이얼로그
            if showDialog {
                PopupCardView(isPresented: $showDialog)
                    .transition(.scale)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: showDialog)
        .navigationTitle("목표/회고 설정")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
