import SwiftUI

struct CameraView: View {
    @State private var camera = CameraService()
    @State private var detector = DetectionService()
    @State private var aiInfo: AIObjectInfo?
    @State private var isLoadingAI = false
    @State private var showObjectSheet = false
    @State private var selectedObject: DetectedObject?
    @StateObject private var history = HistoryService.shared

    var body: some View {

        NavigationStack {

            ZStack {

                // MARK: Camera Placeholder

                CameraPreview(camera: camera)
                    .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])

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
                    
                    if !history.history.isEmpty {

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 12) {

                                ForEach(history.history.prefix(10)) { item in

                                    Button {

                                        selectedObject = DetectedObject(
                                            name: item.name,
                                            category: "Object",
                                            shortSummary: "",
                                            detailedSummary: "",
                                            confidence: item.confidence,
                                            icon: "camera.viewfinder",
                                            facts: []
                                        )

                                        aiInfo = nil
                                        showObjectSheet = true

                                    } label: {

                                        Text(item.name)
                                            .font(.caption.weight(.semibold))
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 8)
                                            .background(.ultraThinMaterial)
                                            .clipShape(Capsule())

                                    }

                                }

                            }
                            .padding(.horizontal)

                        }
                        .padding(.bottom, 12)

                    }
                    
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

                }

            }
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: detector.detectedObject != nil)
            
            .onAppear {

                detector.onObjectDetected = { object, pixelBuffer in

                    HistoryService.shared.save(
                        object: object,
                        pixelBuffer: pixelBuffer
                    )

                }
                camera.onFrameCaptured = { pixelBuffer in
                   
                    detector.processFrame(pixelBuffer)
                    
                }

                camera.checkPermissions()
                camera.start()
            }
            .onDisappear {

                camera.stop()
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
