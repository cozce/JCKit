import Foundation
import UIKit

public protocol iVCFactory {
    func make<ViewController: UIViewController>(type viewController: ViewController.Type) -> ViewController
}

public struct VCFactory: iVCFactory {
    public func make<ViewController: UIViewController>(type viewController: ViewController.Type) -> ViewController {
        return ViewController()
    }
}
