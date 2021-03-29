import Foundation
import RxSwift
import RxSwiftExt

public class InputView: NibView {
    public struct State {
        let title: String
        let text: String?
        let keyboard: UIKeyboardType
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!

    override public func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.textColor = Kit.colorPicker.pick(.softBlack)
        textField.tintColor = Kit.colorPicker.pick(.softBlack)
        textField.borderStyle = .none
        textField.textAlignment = .center
    }

    public func render(with state: State) {
        titleLabel.text = state.title
        textField.text = state.text
        textField.keyboardType = state.keyboard
    }

    public func didEnterText() -> Observable<String> {
        return textField.rx.text
            .asObservable()
            .filterMap { optionalText -> FilterMap<String> in
                guard let text = optionalText else {
                    return .ignore
                }
                if text == "" {
                    return .ignore
                }
                return .map(text)
            }
    }

    public func showKeyboard() {
        textField.becomeFirstResponder()
    }

    public func hideKeyboard() {
        textField.resignFirstResponder()
    }
}
