import SwiftUI

struct LibraryHeader: View {

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text("My Discoveries")
                .font(.largeTitle.bold())

            Text("Browse everything you've discovered through scanning and AI research.")
                .font(.title3)
                .foregroundStyle(.secondary)

        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }

}

#Preview {
    LibraryHeader()
}
