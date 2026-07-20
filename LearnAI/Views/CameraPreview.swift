import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {

    let camera: CameraService

    func makeUIView(context: Context) -> PreviewView {

        let view = PreviewView()

        view.videoPreviewLayer.session = camera.session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill

        return view

    }

    func updateUIView(_ uiView: PreviewView, context: Context) {}

}

final class PreviewView: UIView {

    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }

}
