import Foundation
import Observation
import Vision

@Observable
final class DetectionService {
    var onObjectDetected: ((DetectedObject, CVPixelBuffer) -> Void)?
    private let minimumConfidence: Float = 0.80

    var detectedObject: DetectedObject?
    var isScanning = false
    var isPaused = false
    private var lastDetectedName: String?
    private var stableDetectionCount = 0

    private let requiredStableDetections = 3

    private let visionService = VisionService()

    func processFrame(_ pixelBuffer: CVPixelBuffer) {

        guard let visionService else { return }
        guard !isPaused else { return }
        guard !isScanning else { return }

        isScanning = true

        visionService.detect(pixelBuffer: pixelBuffer) { [weak self] detections in
            
            guard let self else { return }
            
            defer {
                self.isScanning = false
            }
            
            print("Detections: \(detections.count)")
            
            guard let best = detections.max(by: {
                $0.confidence < $1.confidence
            }),
                  best.confidence >= minimumConfidence
            else {
                
                detectedObject = nil
                return
            }
            
            let object = DetectedObject(
                name: cocoClasses[best.classIndex].capitalized,
                category: "Object",
                shortSummary: "Detected using YOLOv8.",
                detailedSummary: "This object was recognized by the on-device YOLOv8 Core ML model.",
                confidence: Double(best.confidence),
                icon: "camera.viewfinder",
                facts: [
                    ObjectFact(
                        icon: "checkmark.circle.fill",
                        title: "Detection",
                        value: "\(Int(best.confidence * 100))%"
                    )
                ]
            )
            
            if lastDetectedName == object.name {
                stableDetectionCount += 1
            } else {
                lastDetectedName = object.name
                stableDetectionCount = 1
            }

            guard stableDetectionCount >= requiredStableDetections else {
                return
            }

            detectedObject = object
            isPaused = true
            onObjectDetected?(object, pixelBuffer)
        }
    }

    func stop() {
        detectedObject = nil
        isScanning = false
        isPaused = false

        lastDetectedName = nil
        stableDetectionCount = 0
    }
    
    func pause() {
        isPaused = true
    }

    func resume() {
        isPaused = false
        detectedObject = nil
        lastDetectedName = nil
        stableDetectionCount = 0
    }
}
