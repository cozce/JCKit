import Foundation
import UIKit
import RxSwift

public struct Environment {
    public var application                         = UIApplication.shared
    public var userDefaults                        = UserDefaults.standard
    public var notificationCenter                  = NotificationCenter.default
    public var appStateReporter: iAppStateReporter = AppStateReporter()
    public var screen                              = UIScreen.main
    public var timezone                            = TimeZone.current
    public var calendar                            = Calendar.current
    public var vcFactory: iVCFactory               = VCFactory()
    public var viewFactory: iViewFactory           = ViewFactory()
    public var date                                = { Date() }
    public var uuid                                = { UUID().uuidString }
    public var formatter                           = Formatter()
    public var textValidator: iTextValidator       = TextValidator()
    public var presenter: iPresenter               = Presenter()
    public var navigator                           = Navigator()
    public var imageFinder                         = ImageFinder()
    public var colorPicker                         = ColorPicker()
    public var queue                               = ObservableQueue()
}

public var Kit = Environment()
