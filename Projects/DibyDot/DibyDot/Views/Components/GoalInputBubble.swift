import SwiftUI

struct GoalInputBubble: View {
    let text: String
    let isPlaceholder: Bool
    let onTap: () -> Void

    var body: some View {
        Text(text)
            .foregroundColor(isPlaceholder ? .gray : .inkDepth)
            .font(.body.weight(.medium))
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(isPlaceholder ? Color.white.opacity(0.3) : Color.white.opacity(0.5), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            .onTapGesture { onTap() }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
