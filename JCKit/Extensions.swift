import Foundation
import UIKit
import RxSwift

extension UIView {
    func addConstrainedSubview(_ view: UIView) {
        addSubview(view)
        translatesAutoresizingMaskIntoConstraints = false
        view.constrainToAllSides(of: self)
    }

    func constrainToAllSides(of view: UIView, constant: CGFloat = 0) {
        constrainTop(to: view, constant: constant)
        constrainBottom(to: view, constant: constant)
        constrainLeading(to: view, constant: constant)
        constrainTrailing(to: view, constant: constant)
    }

    func constrainTrailing(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (constant * -1)).isActive = true
    }

    func constrainLeading(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
    }

    func constrainTop(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }

    func constrainBottom(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (constant * -1)).isActive = true
    }

    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func hideOnNil(_ any: Any?) {
        self.isHidden = any == nil
    }

    enum AnimationDuration: TimeInterval {
        case short = 0.25
        case medium = 0.4
        case long = 0.75
    }

    class func springAnimation(duration: AnimationDuration = .medium, toAnimate: @escaping (() -> Void), afterAnimation: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: duration.rawValue,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [.allowUserInteraction, .curveEaseOut],
            animations: {
                toAnimate()
            },
            completion: { _ in
                afterAnimation?()
            }
        )
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

extension Int {
    var asCGFloat: CGFloat {
        return CGFloat(self)
    }

    var asFloat: Float {
        return Float(self)
    }

    var asDouble: Double {
        return Double(self)
    }
}

extension Double {
    var asFloat: Float {
        return Float(self)
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Optional {
    func recoverTo(_ wrapped: Wrapped) -> Wrapped {
        return self ?? wrapped
    }

    func recover(_ f: () -> Wrapped) -> Wrapped {
        guard let wrapped = self else {
            return f()
        }
        return wrapped
    }

    func flatMapOnNil(_ f: () -> Wrapped?) -> Wrapped? {
        guard let wrapped = self else {
            return f()
        }
        return wrapped
    }

    func on(_ f: (Wrapped) -> ()) -> Wrapped? {
        guard let wrapped = self else {
            return self
        }
        f(wrapped)
        return self
    }

    public static func zip<O>(_ first: Wrapped?, _ second: O?) -> (Wrapped, O)? {
        return first.zip(second)
    }

    public func zip<O>(_ other: O?) -> (Wrapped, O)? {
        return self.flatMap { wrapped in
            return other.map { other in
                (wrapped, other)
            }
        }
    }
}

extension ObservableType {
    func asOptional() -> Observable<Element?> {
        return self.map { e in e }
    }

    func delay(_ seconds: Int) -> Observable<Element> {
        return self.delay(.seconds(seconds), scheduler: MainScheduler.instance)
    }

    func withLatestFrom<A, B>(_ a: Observable<A>, _ b: Observable<B>) -> Observable<(A, B)> {
        return self.withLatestFrom(a).andLatestFrom(b)
    }

    func withLatestFrom<A, B, C>(_ a: Observable<A>, _ b: Observable<B>, _ c: Observable<C>) -> Observable<(A, B, C)> {
        return self.withLatestFrom(a).andLatestFrom(b, c)
    }

    func andLatestFrom<B>(_ b: Observable<B>) -> Observable<(Element, B)> {
        return self.withLatestFrom(b) { (a: Element, b: B) in
            return (a, b)
        }
    }

    func andLatestFrom<B, C>(_ b: Observable<B>, _ c: Observable<C>) -> Observable<(Element, B, C)> {
        return self
            .withLatestFrom(b) { (a: Element, b: B) in
                return (a, b)
            }
            .andLatestFrom(c)
            .map { ab, c in
                let (a, b) = ab
                return (a, b, c)
            }
    }

    func toggle(startWith: Bool) -> Observable<Bool> {
        return self.scan(startWith) { lastValue, _ in
            return !lastValue
        }
        .startWith(startWith)
    }

    func debugTrimmed() -> Observable<Element> {
        return self.debug(nil, trimOutput: true)
    }
}

extension Set where Element: Nameable {
    func alphabeticallySorted() -> [Element] {
        let array = sorted { (lhs, rhs) -> Bool in
            return lhs.name < rhs.name
        }
        return array
    }

    func numericallySorted() -> [Element] {
        let array = sorted { (lhs, rhs) -> Bool in
            return Double(lhs.name) ?? 0 < Double(rhs.name) ?? 0
        }
        return array
    }
}

extension UIEdgeInsets {
    static func make(tb: Points, lr: Points) -> UIEdgeInsets {
        return UIEdgeInsets(top: tb.rawValue, left: lr.rawValue, bottom: tb.rawValue, right: lr.rawValue)
    }

    static func make(t: Points, b: Points, l: Points, r: Points) -> UIEdgeInsets {
        return UIEdgeInsets(top: t.rawValue, left: l.rawValue, bottom: b.rawValue, right: r.rawValue)
    }
}

extension UIStackView {
    func addMargins(_ margins: UIEdgeInsets) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = margins
    }
}
