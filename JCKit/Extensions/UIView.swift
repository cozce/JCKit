import UIKit

extension UIView {
    public var isVisible: Bool {
        set {
            isHidden = !newValue
        }
        get {
            return !isHidden
        }
    }

    public func hideOnNil(_ any: Any?) {
        isHidden = any == nil
    }

}
