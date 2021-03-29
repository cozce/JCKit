import UIKit

extension UIScrollView {
    public func enableKeyboardHandling() {
        Kit.notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        Kit.notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            fatalError("unable to reference keyboardValue")
        }

        let scrollViewRectFlattened = convert(bounds, to: nil)
        let bottomOfScrollViewYPos = scrollViewRectFlattened.origin.y + scrollViewRectFlattened.size.height
        let bottomOfScreenYPos = UIScreen.main.bounds.height
        let distanceBetweenBottomOfScreenAndScrollView = bottomOfScreenYPos - bottomOfScrollViewYPos
        let keyboardSize = keyboardValue.cgRectValue.size
        let newBottomInset = keyboardSize.height - distanceBetweenBottomOfScreenAndScrollView
        let keyboardPadding : CGFloat = 16
        let newBottomInsetPlusKeyboardPadding = newBottomInset + keyboardPadding

        contentInset.bottom = newBottomInsetPlusKeyboardPadding
        verticalScrollIndicatorInsets.bottom = newBottomInset
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        contentInset = .zero
        scrollIndicatorInsets = .zero
    }
}
