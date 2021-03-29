import Foundation
import UIKit

public struct ImageFinder {
    public enum Image: String {
        case starFilled = "star.fill"
        case starUnfilled = "star"
        case person = "person.fill"
        case down = "chevron.down"
        case square = "square.fill"
        case error = "exclamationmark.triangle"
        case circleFilled = "circle.fill"
        case circleUnfilled = "circle"
    }

    public func find(_ image: Image) -> UIImage {
        guard let uiImage = UIImage(systemName: image.rawValue) else {
            fatalError("bad")
        }
        return uiImage
    }
}
