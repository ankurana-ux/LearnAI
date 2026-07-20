import Foundation
import CoreML
import CoreGraphics

struct YOLODetection {

    let classIndex: Int
    let confidence: Float
    let rect: CGRect

}

final class YOLODecoder {

    private let confidenceThreshold: Float = 0.4

    func decode(_ multiArray: MLMultiArray) -> [YOLODetection] {

        let pointer = multiArray.dataPointer.bindMemory(
            to: Float32.self,
            capacity: multiArray.count
        )

        var detections: [YOLODetection] = []

        let numClasses = 80
        let numPredictions = 8400

        for i in 0..<numPredictions {

            let x = pointer[i]
            let y = pointer[numPredictions + i]
            let w = pointer[numPredictions * 2 + i]
            let h = pointer[numPredictions * 3 + i]

            var bestClass = -1
            var bestScore: Float = 0

            for c in 0..<numClasses {

                let score = pointer[(4 + c) * numPredictions + i]

                if score > bestScore {
                    bestScore = score
                    bestClass = c
                }
            }

            guard bestScore > confidenceThreshold else {
                continue
            }

            let rect = CGRect(
                x: CGFloat(x),
                y: CGFloat(y),
                width: CGFloat(w),
                height: CGFloat(h)
            )

            detections.append(
                YOLODetection(
                    classIndex: bestClass,
                    confidence: bestScore,
                    rect: rect
                )
            )
        }

        return detections
    }

}
