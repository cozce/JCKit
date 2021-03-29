import Foundation
import UIKit

extension UIView {
    public enum AnimationDuration: TimeInterval {
        case short = 0.25
        case medium = 0.4
        case long = 0.75
    }

    class public func springAnimation(duration: AnimationDuration = .medium, toAnimate: @escaping (() -> Void), afterAnimation: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: duration.rawValue,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [.allowUserInteraction, .curveEaseOut],
            animations: {
                toAnimate()
            },
            completion: { _ in
                afterAnimation?()
            }
        )
    }
}
