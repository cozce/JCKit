import Foundation
import UIKit
import RxSwift
import RxCocoa

public class ImageView: NibView {

    public enum ImageType {
        case local(ImageFinder.Image)
        case remote(Observable<UIImage>)
        case color(ColorPicker.Color)
    }
    
    public enum Mode {
        case fit
        case fill
    }

    public struct State {
        let model: Any?
        let type: ImageType
        let height: Points
        let width: Points
        let fractionMod: Fraction
        let circular: Bool
        let contentMode: Mode
        let borderWidth: Points?
        let borderColor: ColorPicker.Color?
        let ghosted: Bool
        let title: String?
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ghostView: UIView!

    private let disposeBag = DisposeBag()

    override public func awakeFromNib() {
        super.awakeFromNib()

        imageView.clipsToBounds = true
        ghostView.backgroundColor = Kit.colorPicker.pick(.white, transparency: .semi)
        ghostView.alpha = 1
        imageView.tintColor = Kit.colorPicker.pick(.lightGray)
        titleLabel.textColor = Kit.colorPicker.pick(.softBlack)
    }

    public func render(with state: State) {
        imageViewHeightConstraint.constant = state.height.rawValue * state.fractionMod.rawValue
        imageViewWidthConstraint.constant = state.width.rawValue * state.fractionMod.rawValue
        layoutIfNeeded()
        
        imageView.layer.cornerRadius = state.circular ? imageView.frame.width / 2 : 0
        imageView.layer.borderWidth = state.borderWidth?.rawValue ?? 0
        imageView.layer.borderColor = state.borderColor.map { color in
            return Kit.colorPicker.pick(color).cgColor
        }

        switch state.contentMode {
        case .fit:
            imageView.contentMode = .scaleAspectFit
        case .fill:
            imageView.contentMode = .scaleAspectFill
        }

        let imageObs: Observable<UIImage>
        switch state.type {
        case .local(let imageFinderImage):
            imageObs = Observable.just(Kit.imageFinder.find(imageFinderImage))
        case .remote(let fetchedImage):
            imageObs = fetchedImage
        case .color(let colorPickerColor):
            let size = CGSize(width: state.width.rawValue, height: state.height.rawValue)
            let color = Kit.colorPicker.pick(colorPickerColor)
            let solidColorImage = UIGraphicsImageRenderer(size: size).image { rendererContext in
                color.setFill()
                rendererContext.fill(CGRect(origin: .zero, size: size))
            }
            imageObs = Observable.just(solidColorImage)
        }

        imageObs.subscribe(onNext: { [weak self] image in
            self?.imageView.image = image
        }).disposed(by: disposeBag)
        ghostView.isHidden = !state.ghosted

        titleLabel.alpha = state.title == nil ? 0 : 1
        titleLabel.text = state.title
    }
}
