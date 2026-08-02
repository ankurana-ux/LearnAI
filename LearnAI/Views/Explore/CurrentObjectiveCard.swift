import SwiftUI

struct CurrentObjectiveCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {
        
        let profile = learning.profile
       
        
        AppCard {

            VStack(alignment: .leading, spacing: 20) {

                AppSectionHeader(
                    title: "Current Objective",
                    icon: "target",
                    color: .blue
                )

                Text("Scan 5 Kitchen Items")
                    .font(.title3.bold())

                Text("Discover the molecular history of your workspace.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 10) {

                    ForEach(0..<5, id: \.self) { index in

                        RoundedRectangle(cornerRadius: 10)
                            .fill(index < profile.currentObjectiveProgress ? Color.green.opacity(0.2) : Color.gray.opacity(0.12))
                            .frame(width: 42, height: 42)
                            .overlay {

                                if index < profile.currentObjectiveProgress {

                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.green)

                                }

                            }

                    }

                }

                HStack {

                    Text("\(profile.currentObjectiveProgress)/5 Completed")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("+30 LP")
                        .font(.caption.bold())
                        .foregroundStyle(.blue)

                }

            }

        }
    }

}

#Preview {

    CurrentObjectiveCard()

}
