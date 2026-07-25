import UIKit
import CoreImage
import CoreVideo

enum ImageConverter {

    static func jpegData(
        from pixelBuffer: CVPixelBuffer,
        compressionQuality: CGFloat = 0.8
    ) -> Data? {

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

        let context = CIContext()

        guard let cgImage = context.createCGImage(
            ciImage,
            from: ciImage.extent
        ) else {
            return nil
        }

        let image = UIImage(cgImage: cgImage)

        return image.jpegData(compressionQuality: compressionQuality)
    }
}
