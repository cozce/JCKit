import UIKit
import RxSwift
import RxGesture

public class ModalVC: UIViewController {

    private let childVC: UIViewController
    private let blurView = UIVisualEffectView(effect: nil)
    private let containerView = UIView()
    private var containerViewBottomConstraint: NSLayoutConstraint?

    public init(with childVC: UIViewController) {
        self.childVC = childVC
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        view.addSubview(blurView)
        blurView.constrainToAllSides(of: view)
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTap)
        )
        blurView.addGestureRecognizer(tapGesture)

        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.constraintCenterX(to: view)
        containerView.constrainWidth(constant: view.frame.width)
        containerView.constrainHeight(constant: view.frame.height * 0.80)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: initialContainerViewYPos()
        )
        containerViewBottomConstraint?.isActive = true

        childVC.willMove(toParent: self)
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        childVC.view.constrainToAllSides(of: containerView)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.layoutIfNeeded()
        present()
    }

    // MARK: - Helpers

    private func initialContainerViewYPos() -> CGFloat {
        return view.frame.height
    }

    private func present() {
        containerViewBottomConstraint?.constant = 0
        UIView.springAnimation(
            duration: .long,
            toAnimate: { [weak self] in
                self?.blurView.effect = UIBlurEffect(style: .dark)
                self?.view.layoutIfNeeded()
            }
        )
    }

    public func dismiss() {
        containerViewBottomConstraint?.constant = initialContainerViewYPos()
        UIView.springAnimation(
            duration: .long,
            toAnimate: { [weak self] in
                self?.view.layoutIfNeeded()
                self?.blurView.effect = nil
            },
            afterAnimation: { [weak self] in
                self?.dismiss(animated: false)
            }
        )
    }

    @objc private func didTap() {
        dismiss()
    }
}
