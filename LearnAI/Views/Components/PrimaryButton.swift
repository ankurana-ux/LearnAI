import SwiftUI

struct PrimaryButton: View {

    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    PrimaryButton(title: "Scan Object")
        .padding()
}
