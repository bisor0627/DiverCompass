import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            .padding()
            .navigationTitle("나의 여정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView()
}
