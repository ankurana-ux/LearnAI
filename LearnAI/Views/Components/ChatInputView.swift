import SwiftUI

struct ChatInputView: View {
    
    @Binding var question: String
    let isLoading: Bool
    let onSend: () -> Void
    
    var body: some View {
        
        Divider()
            .padding(.top, 8)

        Text("Ask AI")
            .font(.headline)
            .padding(.top, 8)
        
        HStack(alignment: .bottom, spacing: 12) {
            
            TextField("Ask anything about this object...", text: $question, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...4)
            
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.blue)
            }
            .disabled(question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading)
        }
    }
}
