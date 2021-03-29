import Foundation
import RxSwift
import RxSwiftExt

extension RxSwift.Reactive where Base: UIViewController {
    public func isAppearing() -> Observable<Bool> {
        return viewState
            .filterMap { viewState -> FilterMap<Bool> in
                switch viewState {
                case .viewWillAppear:
                    return .map(false)
                case .viewDidAppear:
                    return .map(true)
                case .viewWillDisappear:
                    return .map(false)
                case .viewDidDisappear:
                    return .map(false)
                case .viewDidLoad:
                    return .map(false)
                case .viewDidLayoutSubviews:
                    return .ignore
                }
            }
            .ignore(false)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
    }
}

extension UIViewController {
    public static var defaultNib: String {
        return self.description()
            .components(separatedBy: ".")
            .dropFirst()
            .joined(separator: ".")
    }

    public static var storyboardIdentifier: String {
        return self.description()
            .components(separatedBy: ".")
            .dropFirst()
            .joined(separator: ".")
    }
}
