import SwiftUI

struct ReflectionBubble: View {
    let reflection: Reflection
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(reflection.content)
                .font(.body)
            HStack(spacing: 4) {
                cycleNameView(for: reflection)
                Text(reflection.createdAt, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .foregroundColor(.inkDepth)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .onTapGesture { onTap() }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func cycleNameView(for reflection: Reflection) -> some View {
        if let cycleID = reflection.cycleID {
            let cycleName = kCycles.first(where: { $0.id == cycleID })?.name ?? "Unknown Cycle"
            Text("🌊 \(cycleName)")
                .font(.caption2)
                .foregroundColor(.blue)
        }
    }
}
