import UIKit

extension UIView {

    // MARK: - UIView

    public func addConstrainedSubview(_ view: UIView) {
        addSubview(view)
        translatesAutoresizingMaskIntoConstraints = false
        view.constrainToAllSides(of: self)
    }

    public func constrainToAllSides(of view: UIView, constant: CGFloat = 0) {
        constrainTop(to: view, constant: constant)
        constrainBottom(to: view, constant: constant)
        constrainLeading(to: view, constant: constant)
        constrainTrailing(to: view, constant: constant)
    }

    public func constrainCenterY(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public func constraintCenterX(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    public func constrainTrailing(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (constant * -1)).isActive = true
    }

    public func constrainLeading(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
    }

    public func constrainTop(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }

    public func constrainBottom(to view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (constant * -1)).isActive = true
    }

    public func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    public func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    // MARK: - UIViewController

    public func constrainToLRSidesAndTBLayoutGuides(of viewController: UIViewController) {
        constrainTopToLayoutGuide(of: viewController)
        constrainBottomToLayoutGuide(of: viewController)
        constrainLeading(to: viewController.view)
        constrainTrailing(to: viewController.view)
    }

    public func constrainTopToLayoutGuide(of viewController: UIViewController, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(
            equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor,
            constant: constant
            ).isActive = true
    }

    public func constrainBottomToLayoutGuide(of viewController: UIViewController, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(
            equalTo: viewController.view.safeAreaLayoutGuide.topAnchor,
            constant: (constant * -1)
            ).isActive = true
    }
}
