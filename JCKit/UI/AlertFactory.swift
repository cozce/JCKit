import Foundation
import RxSwift

public class AlertFactory {

    public enum Kind {
        case delete
    }

    public func make(kind: Kind) -> (UIAlertController, Observable<Void>) {
        let title: String
        let message: String
        let style: UIAlertController.Style
        let primaryButtonTitle: String
        let secondaryActionTitle: String
        let primaryStyle: UIAlertAction.Style
        switch kind {
        case .delete:
            title = "Confirm"
            message = "Please confirm you want to delete this transaction"
            style = .alert
            primaryButtonTitle = "Delete"
            primaryStyle = .destructive
            secondaryActionTitle = "Cancel"
        }
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        let didTap = Observable<Void>.create { observer -> Disposable in
            let secondaryAction = UIAlertAction(title: secondaryActionTitle, style: .default)
            let primaryAction = UIAlertAction(title: primaryButtonTitle, style: primaryStyle) { _ in
                observer.onNext(())
                observer.onCompleted()
            }
            alert.addAction(secondaryAction)
            alert.addAction(primaryAction)
            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
        return (alert, didTap)
    }
}
