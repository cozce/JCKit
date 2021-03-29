import Foundation
import UIKit
import RxSwift

public class BaseVC<TheView: UIView>: UIViewController {

    public let disposeBag = DisposeBag()

    public var theView: TheView {
        return view as! TheView
    }

    override public func loadView() {
        view = Kit.viewFactory.make(type: TheView.self)
        view.translatesAutoresizingMaskIntoConstraints = true
    }

    deinit {
        let string = String(describing: self)
        let name = string
            .split(separator: ".", maxSplits: 1)
            .last?
            .split(separator: ":")
            .first ?? "UNKNOWN UIViewController"
        print("\(name) deallocated")
    }
}
