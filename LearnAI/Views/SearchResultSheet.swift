import SwiftUI

struct SearchResultSheet: View {

    let info: AIObjectInfo

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    Text(info.name)
                        .font(.largeTitle.bold())

                    Text(info.summary)

                    Divider()

                    Text("History")
                        .font(.headline)

                    Text(info.history)

                    Divider()

                    Text("Uses")
                        .font(.headline)

                    ForEach(info.uses, id: \.self) { use in
                        Label(use, systemImage: "checkmark.circle.fill")
                    }

                    Divider()

                    Text("Fun Facts")
                        .font(.headline)

                    ForEach(info.funFacts, id: \.self) { fact in
                        Label(fact, systemImage: "sparkles")
                    }

                    Divider()

                    Text("Safety")
                        .font(.headline)

                    Text(info.safety)

                }
                .padding()

            }
            .navigationTitle("Result")
            .navigationBarTitleDisplayMode(.inline)

        }

    }

}

#Preview {
    SearchResultSheet(
        info: AIObjectInfo(
            name: "Apple",
            summary: "A fruit.",
            history: "History",
            uses: ["Eat"],
            funFacts: ["Healthy"],
            safety: "Safe"
        )
    )
}
