import UIKit

public class CursorLessTextField: UITextField {

    override public func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    override public var canBecomeFirstResponder: Bool {
        return false
    }
}
