import SwiftUI

struct FunFactCard: View {

    var body: some View {

        AppCard {
            
            VStack(alignment: .leading, spacing: 20) {
                
                Label("FUN FACT", systemImage: "sparkles")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.orange)
                
                Text("Did you know?")
                    .font(.title3.bold())
                
                Text("All electronic devices contain small amounts of gold because it is an excellent conductor of electricity.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                Text("Was this interesting?")
                    .font(.subheadline.weight(.medium))
                
                HStack(spacing: 12) {
                    
                    Button("Yes") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("No") {
                        
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Text("+1 LP")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)
                    
                }
                
            }
        }
    }

}

#Preview {

    FunFactCard()

}
