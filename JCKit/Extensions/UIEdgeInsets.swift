import Foundation
import UIKit

extension UIEdgeInsets {
    static public func make(tb: Points, lr: Points) -> UIEdgeInsets {
        return UIEdgeInsets(top: tb.rawValue, left: lr.rawValue, bottom: tb.rawValue, right: lr.rawValue)
    }

    static public func make(t: Points, b: Points, l: Points, r: Points) -> UIEdgeInsets {
        return UIEdgeInsets(top: t.rawValue, left: l.rawValue, bottom: b.rawValue, right: r.rawValue)
    }
}
