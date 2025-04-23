import SwiftUI

extension View {
    func popupOverlay(
        mode: PopupCardMode?,
        isPresented: Binding<Bool>,
        text: Binding<String>,
        intent: PopupCardIntent,
        onSave: @escaping () -> Void,
        onDelete: (() -> Void)? = nil
    ) -> some View {
        self.overlay {
            if isPresented.wrappedValue {
                PopupCardView(
                    isPresented: isPresented,
                    text: text,
                    mode: mode ?? .overallGoal,
                    intent: intent,
                    onSave: onSave,
                    onDelete: onDelete
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}
