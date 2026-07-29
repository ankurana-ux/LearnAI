import SwiftUI

struct CameraView: View {
    @State private var camera = CameraService()
    @State private var detector = DetectionService()
    @State private var aiInfo: AIObjectInfo?
    @State private var isLoadingAI = false
    @State private var currentHistoryID: UUID?
    @State private var selectedObject: DetectedObject?
    @StateObject private var history = HistoryService.shared
    @State private var isProcessingDetection = false
    @State private var selectedPixelBuffer: CVPixelBuffer?
    
    
    private func handleDetection(
        object: DetectedObject,
        pixelBuffer: CVPixelBuffer
    ) {

        guard !isProcessingDetection else {
            return
        }

        isProcessingDetection = true
        selectedPixelBuffer = pixelBuffer
        
        currentHistoryID = HistoryService.shared.save(
            object: object,
            pixelBuffer: pixelBuffer
        )

        Task {

            defer {
                Task { @MainActor in
                    isProcessingDetection = false
                }
            }

            await MainActor.run {
                isLoadingAI = true
            }
            
            do {

                let info = try await AIService.shared.identifyObject(
                    from: pixelBuffer
                )
                await MainActor.run {

                    aiInfo = info

                    if let id = currentHistoryID {

                        HistoryService.shared.renameObject(
                            id: id,
                            to: info.name
                        )

                        HistoryService.shared.saveAIInfo(
                            for: id,
                            info: info
                        )

                    }

                    isLoadingAI = false
                    selectedObject = DetectedObject(
                        name: info.name,
                        category: object.category,
                        shortSummary: info.summary,
                        detailedSummary: info.history,
                        confidence: object.confidence,
                        icon: object.icon,
                        facts: object.facts
                    )
                }

            } catch {

                await MainActor.run {
                    isLoadingAI = false
                }

                print("❌ Gemini Vision Error:")
                print(error.localizedDescription)
            }

        }

    }

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

                                        aiInfo = HistoryService.shared.aiInfo(for: item.id)


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
                    DispatchQueue.main.async {
                        handleDetection(
                            object: object,
                            pixelBuffer: pixelBuffer
                        )
                    }
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
            .sheet(
                item: $selectedObject,
                onDismiss: {

                    detector.resume()


                    aiInfo = nil
                    currentHistoryID = nil

                }
            )
                { object in
                    
                    ObjectInfoSheet(
                        object: object,
                        pixelBuffer: selectedPixelBuffer,
                        aiInfo: aiInfo,
                        isLoading: isLoadingAI,
                        onLearnMore: { }
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

