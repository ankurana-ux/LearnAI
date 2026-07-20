import SwiftUI
import Observation
import AVFoundation



@Observable final class CameraService: NSObject {

    let session = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    var onFrameCaptured: ((CVPixelBuffer) -> Void)?
    func checkPermissions() {

        switch AVCaptureDevice.authorizationStatus(for: .video) {

        case .authorized:
            setupCamera()

        case .notDetermined:

            AVCaptureDevice.requestAccess(for: .video) { granted in

                if granted {

                    DispatchQueue.main.async {
                        self.setupCamera()
                    }

                }

            }

        default:
            break
        }

    }

    private func setupCamera() {

        if session.isRunning {
            return
        }

        session.beginConfiguration()
        defer { session.commitConfiguration() }

        session.sessionPreset = .high

        guard let camera = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .back
        ) else {
            print("❌ No camera")
            return
        }

        do {

            let input = try AVCaptureDeviceInput(device: camera)

            if session.inputs.isEmpty, session.canAddInput(input) {
                session.addInput(input)
            }

            videoOutput.alwaysDiscardsLateVideoFrames = true

            videoOutput.videoSettings = [
                kCVPixelBufferPixelFormatTypeKey as String:
                    kCVPixelFormatType_32BGRA
            ]

            videoOutput.setSampleBufferDelegate(
                self,
                queue: DispatchQueue(label: "camera.frame.queue")
            )

            if session.outputs.isEmpty, session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
            }

            if let connection = videoOutput.connection(with: .video) {
                connection.videoOrientation = .portrait
                print("✅ Video connection created")
            } else {
                print("❌ No video connection")
            }

        } catch {
            print(error)
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {

            self.session.startRunning()

            print("Running:", self.session.isRunning)
            print("Inputs:", self.session.inputs.count)
            print("Outputs:", self.session.outputs.count)
        }
    }

}
extension CameraService: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {

        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        onFrameCaptured?(pixelBuffer)

    }

}
