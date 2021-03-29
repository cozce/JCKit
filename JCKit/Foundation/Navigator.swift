import Foundation
import UIKit

public struct Navigator {
    public func push(_ viewController: UIViewController, from parentViewController: UIViewController, animated: Bool) {
        parentViewController.navigationController?.pushViewController(viewController, animated: animated)
    }

    public func pop(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationController?.popViewController(animated: animated)
    }
}
