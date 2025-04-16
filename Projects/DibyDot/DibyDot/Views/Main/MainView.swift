import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink(destination: SettingView()) {
                    Text("🎯 목표/회고 설정")
                }
                ProgressView(value: 0.5, total: 1)
                    .padding()
            }
            .padding()
            .navigationTitle("나의 여정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}
