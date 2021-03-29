import Foundation
import UIKit

public protocol iViewFactory {
    func make<View: UIView>(type view: View.Type) -> View
}

public struct ViewFactory: iViewFactory {
    public func make<View: UIView>(type view: View.Type) -> View {
        return View()
    }
}
