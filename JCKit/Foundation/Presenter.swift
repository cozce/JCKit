import Foundation
import UIKit

public protocol iPresenter {
    func present(_ viewController: UIViewController, withParent parentViewController: UIViewController?, animated: Bool)
    func dismiss(_ viewController: UIViewController?, animated: Bool)
}

public struct Presenter: iPresenter {
    public func present(_ viewController: UIViewController, withParent parentViewController: UIViewController?, animated: Bool) {
        parentViewController?.present(viewController, animated: animated, completion: nil)
    }

    public func dismiss(_ viewController: UIViewController?, animated: Bool) {
        viewController?.dismiss(animated: animated, completion: nil)
    }
}
