import SwiftUI

struct QuickFactsView: View {

    let facts: [ObjectFact]

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("Quick Facts")
                .font(.headline)

            ForEach(facts) { fact in

                HStack(spacing: 14) {

                    Image(systemName: fact.icon)
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 26)

                    Text(fact.title)

                    Spacer()

                    Text(fact.value)
                        .foregroundStyle(.secondary)

                }

            }

        }

    }

}
