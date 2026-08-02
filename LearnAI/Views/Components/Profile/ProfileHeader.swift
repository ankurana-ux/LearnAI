import SwiftUI

struct ProfileHeader: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {

        let profile = learning.profile

        HStack(alignment: .top, spacing: 24) {

            ZStack {

                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.orange.opacity(0.35))
                    .frame(width: 64, height: 64)

                Text("\(profile.level)")
                    .font(.system(size: 24, weight: .bold))

            }
            .overlay(alignment: .bottomTrailing) {

                Circle()
                    .fill(.yellow)
                    .frame(width: 18, height: 18)
                    .overlay {

                        Image(systemName: "crown.fill")
                            .font(.system(size: 8))
                            .foregroundStyle(.black)

                    }

            }

            VStack(alignment: .leading, spacing: 6) {

                HStack {

                    Text("Curiosity Spark")
                        .font(.system(size: 28, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Spacer()

                    NavigationLink {

                        SettingsView()

                    } label: {

                        Image(systemName: "gearshape")
                            .font(.title3)
                            .foregroundStyle(.black)

                    }

                }

                Text("LEVEL \(profile.level) | PROGRESS")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)

            }

        }

    }

}

#Preview {

    ProfileHeader()

}
