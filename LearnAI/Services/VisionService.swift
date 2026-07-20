import Vision
import CoreML

final class VisionService {
    
    private let visionModel: VNCoreMLModel
    private let decoder = YOLODecoder()
    
    init?() {
        guard let model = try? VNCoreMLModel(
            for: yolov8n(configuration: MLModelConfiguration()).model
        ) else {
            return nil
        }
        
        self.visionModel = model
    }
    
    func detect(
        pixelBuffer: CVPixelBuffer,
        completion: @escaping ([YOLODetection]) -> Void
    ){
        
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            
            if let error = error {
                print(error)
                completion([])
                return
            }
            
            //            let results =
            //                request.results as? [VNRecognizedObjectObservation] ?? []
            //
            //            print("Detected \(results.count) objects")
            
            guard let results = request.results,
                  let feature = results.first as? VNCoreMLFeatureValueObservation,
                  let multiArray = feature.featureValue.multiArrayValue else {
                
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            
            let detections = self.decoder.decode(multiArray)

            DispatchQueue.main.async {
                completion(detections)
            }
        }
            request.imageCropAndScaleOption = .scaleFill
            
            let handler = VNImageRequestHandler(
                cvPixelBuffer: pixelBuffer,
                orientation: .up
            )
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
                }
            }
        }
    }

