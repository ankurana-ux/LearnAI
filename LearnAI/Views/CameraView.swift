import SwiftUI

struct CameraView: View {
    @State private var camera = CameraService()
    @State private var selectedTab: AppTab = .lens
    @State private var detector = DetectionService()
    @State private var aiInfo: AIObjectInfo?
    @State private var isLoadingAI = false
    @State private var showObjectSheet = false
    @State private var selectedObject: DetectedObject?

    var body: some View {

        NavigationStack {

            ZStack {

                // MARK: Camera Placeholder

                CameraPreview(camera: camera)
                    .ignoresSafeArea()

                // MARK: AI Status

                VStack {

                    HStack {

                        Spacer()

                        AIStatusIndicator()

                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    Spacer()

                }

                // MARK: Scanning Frame

                ScanningFrame()

                // MARK: Bottom Content

                VStack {

                    Spacer()
                    
                    if let object = detector.detectedObject {

                        DetectionCard(
                            object: object,
                            onTap: {

                                // If a different object is selected, clear the old AI information.
                                if selectedObject?.name != object.name {
                                    aiInfo = nil
                                }

                                selectedObject = object
                                showObjectSheet = true
                            }
                        )
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))

                    } else {

                        Text("Point your camera at an object")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                            .padding(.bottom, 8)

                    }
                    BottomTabBar(selectedTab: $selectedTab)

                }

            }
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: detector.detectedObject != nil)
            
            .onAppear {


                camera.onFrameCaptured = { pixelBuffer in
                   
                    detector.processFrame(pixelBuffer)
                    
                }

                camera.checkPermissions()
            }
            .onDisappear {

                detector.stop()
                aiInfo = nil
                selectedObject = nil

            }
            .sheet(isPresented: $showObjectSheet) {

                if let object = selectedObject {

                    ObjectInfoSheet(
                        object: object,
                        aiInfo: aiInfo,
                        isLoading: isLoadingAI,
                        onLearnMore:{

                            Task {

                                await MainActor.run {
                                    isLoadingAI = true
                                }

                                defer {
                                    Task { @MainActor in
                                        isLoadingAI = false
                                    }
                                }

                                do {

                                    let info = try await AIService.shared.fetchInfo(for: object.name)

                                    await MainActor.run {
                                        aiInfo = info
                                    }

                                } catch {

                                    print(error)

                                }

                            }

                        }
                    )
                    .presentationDetents([
                        .fraction(0.42),
                        .large
                    ])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.ultraThinMaterial)

                }

            }

        }

    }


}
