import Foundation
import RxSwift
import RxSwiftExt
import RxAppState

public protocol iAppStateReporter {
    func didBecomeActive() -> Observable<Void>
}

public struct AppStateReporter: iAppStateReporter {
    public func firstWarmOpenInAwhile() -> Observable<Void> {
        let dateOnBackground = Kit.application.rx.applicationDidEnterBackground
            .map { _ in
                return Kit.date()
            }

        return Kit.application.rx.didOpenApp
            .map {
                return Kit.date()
            }
            .andLatestFrom(dateOnBackground)
            .map { (timeOnOpen, timeOnBackground) -> Bool in
                let timeSinceLastOpen = timeOnOpen.timeIntervalSince(timeOnBackground)
                let awhileInSeconds: TimeInterval = 60
                if timeSinceLastOpen < awhileInSeconds {
                    return false
                }
                return true
            }
            .ignore(false)
            .mapTo(())
    }

    public func didBecomeActive() -> Observable<Void> {
        return Kit.application.rx.applicationDidBecomeActive.mapTo(())
    }

    public func willEnterForeground() -> Observable<Void> {
        return Kit.application.rx.applicationWillEnterForeground.mapTo(())
    }

    public func didColdOpenApp() -> Observable<Void> {
        return Kit.application.rx.isFirstLaunch.ignore(false).mapTo(())
    }

    public func didOpenApp() -> Observable<Void>{
        return Kit.application.rx.didOpenApp.mapTo(())
    }
}
