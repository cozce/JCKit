import Foundation
import UIKit
import RxSwift
import RxCocoa

public class LabelView: NibView {

    public struct State {
        let model: Any?
        let title: String
        let subtitle: String?
        let subSubtitle: String?
        let selected: Bool
        let ghosted: Bool
        let margins: UIEdgeInsets
        let textColor: ColorPicker.Color?
        let backgroundColor: ColorPicker.Color?
    }

    @IBOutlet private weak var labelStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var subSubtitleLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var ghostView: UIView!
    @IBOutlet private weak var backgroundView: UIView!

    override public func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.textColor = Kit.colorPicker.pick(.softBlack)
        subtitleLabel.textColor = Kit.colorPicker.pick(.softBlack)
        subSubtitleLabel.textColor = Kit.colorPicker.pick(.softBlack)
        lineView.backgroundColor = Kit.colorPicker.pick(.softBlack)
        ghostView.backgroundColor = Kit.colorPicker.pick(.white, transparency: .semi)
        ghostView.alpha = 1
    }

    public func render(with state: State) {
        labelStackView.addMargins(state.margins)
        titleLabel.text = state.title
        
        subtitleLabel.text = state.subtitle
        subtitleLabel.hideOnNil(state.subtitle)

        subSubtitleLabel.text = state.subSubtitle
        subSubtitleLabel.hideOnNil(state.subSubtitle)

        lineView.alpha = state.selected ? 1 : 0
        ghostView.isHidden = !state.ghosted

        titleLabel.textColor = Kit.colorPicker.pick(state.textColor ?? .softBlack)
        subtitleLabel.textColor = Kit.colorPicker.pick(state.textColor ?? .softBlack)
        subSubtitleLabel.textColor = Kit.colorPicker.pick(state.textColor ?? .softBlack)
        backgroundView.backgroundColor = Kit.colorPicker.pick(state.backgroundColor ?? .white)
    }
}
