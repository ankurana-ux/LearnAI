import SwiftUI

struct SwipeableRow<Content: View, Trailing: View>: View {
    let id: UUID
    @Binding var openSwipeID: UUID?
    let isEnabled: Bool
    let trailingWidth: CGFloat
    let content: Content
    let trailing: Trailing
    
    @GestureState
    private var dragOffset: CGFloat = 0
    
    @State
    private var restingOffset: CGFloat = 0
    
    init(
        id: UUID,
        openSwipeID: Binding<UUID?>,
        isEnabled: Bool = true,
        trailingWidth: CGFloat = 90,
        @ViewBuilder trailing: () -> Trailing,
        @ViewBuilder content: () -> Content
    ) {
        
        self.id = id
        self._openSwipeID = openSwipeID
        self.isEnabled = isEnabled
        self.trailingWidth = trailingWidth
        self.trailing = trailing()
        self.content = content()
        
    }
    private var totalOffset: CGFloat {
        
        max(
            min(restingOffset + dragOffset, 0),
            -trailingWidth
        )
        
    }
    var body: some View {

        ZStack(alignment: .trailing) {

            HStack(spacing: 0) {

                Spacer()

                trailing
                    .frame(width: trailingWidth)
            }

            content
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .offset(x: totalOffset)
                .contentShape(Rectangle())
                .highPriorityGesture(swipeGesture)
                .animation(
                    .interactiveSpring(
                        response: 0.30,
                        dampingFraction: 0.85
                    ),
                    value: totalOffset
                )

        }
        .clipped()
        .onChange(of: openSwipeID) { _, newValue in

            guard newValue != id else { return }

            restingOffset = 0

        }
        .onChange(of: isEnabled) { _, enabled in

            if !enabled {

                openSwipeID = nil
                restingOffset = 0

            }

        }

    }
    private var swipeGesture: some Gesture {
        
        DragGesture()
        
            .updating($dragOffset) { value, state, _ in
                
                guard isEnabled else { return }
                
                if value.translation.width < 0 {
                    
                    state = value.translation.width
                    
                }
                
            }
        
            .onEnded { value in
                
                guard isEnabled else { return }
                
                let finalOffset = restingOffset + value.translation.width
                
                withAnimation(.spring(
                    response: 0.30,
                    dampingFraction: 0.85
                )) {
                    
                    if finalOffset < -(trailingWidth / 2) {
                        
                        openSwipeID = id
                        restingOffset = -trailingWidth
                        
                    } else {
                        
                        openSwipeID = nil
                        restingOffset = 0
                        
                    }
                    
                }
                
            }
        
    }
}
