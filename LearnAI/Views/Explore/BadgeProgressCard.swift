import SwiftUI

struct BadgeProgressCard: View {

    var body: some View {
       
        AppCard {
            
            VStack(alignment: .leading, spacing: 18) {
                
                HStack {
                    
                    Text("SILVER")
                        .font(.caption2.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.gray.opacity(0.15))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                }
                
                Image(systemName: "shield.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.yellow)
                
                Text("Explorer")
                    .font(.title3.bold())
                
                Text("Scan 5 currencies")
                    .foregroundStyle(.secondary)
                
                ProgressView(value: 0.4)
                    .tint(.blue)
                
                HStack {
                    
                    Text("2 / 5")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("+20 LP")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)
                    
                }
                
            }
        }

    }

}

#Preview {

    BadgeProgressCard()

}
