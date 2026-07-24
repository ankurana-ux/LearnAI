import Foundation

enum ScanState: Equatable {
    case scanning
    case identifying
    case generatingSummary
    case reading
    case generatingDetails
    case ready
    case error(String)
}
