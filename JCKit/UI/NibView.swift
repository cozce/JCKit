import Foundation
import UIKit

public class NibView: UIView {

    override public var backgroundColor: UIColor? {
        get {
            return subviews.first?.backgroundColor
        }
        set {
            subviews.first?.backgroundColor = newValue
        }
    }

    deinit {
        let string = String(describing: self)
        let name = string
            .split(separator: ".", maxSplits: 1)
            .last?
            .split(separator: ":")
            .first ?? "UNKNOWN UIView"
        print("\(name) deallocated")
    }

    required convenience public init() {
        self.init(frame: .zero)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXib()
        awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromXib()
    }

    private func loadFromXib() {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)

        guard let nibNameSubString = String(describing: selfType).split(separator: "<").first else {
            fatalError("bad")
        }
        let nibNameString = String(nibNameSubString)
        let nib = UINib(nibName: nibNameString, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("unable to instante nib for owner \(self)")
        }
        addConstrainedSubview(view)
        clipsToBounds = true
    }
}
