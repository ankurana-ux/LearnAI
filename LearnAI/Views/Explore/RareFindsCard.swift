import SwiftUI

struct RareFindsCard: View {

    var body: some View {

        AppCard {
            
            VStack(spacing: 20) {
                
                AppSectionHeader(
                    title: "Rare Finds",
                    icon: "diamond.fill",
                    color: .purple
                )
                
                Text("Find rare objects and earn points")
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)
                
                Text("20 / 300")
                    .font(.system(size: 38, weight: .bold))
                
                Text("+450 LP")
                    .font(.headline)
                    .foregroundStyle(.orange)
                
                ProgressView(value: 20, total: 300)
                    .tint(.purple)
                
                Button {
                    
                } label: {
                    
                    Text("Let's Scan & Learn")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(.borderedProminent)
                
            }
        }

    }

}

#Preview {

    RareFindsCard()

}
