import Foundation
import UIKit

extension UIStackView {
    public func addMargins(_ margins: UIEdgeInsets) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = margins
    }
}
