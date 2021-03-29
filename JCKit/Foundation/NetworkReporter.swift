import Foundation
import RxSwift
import RxAppState

public class NetworkReporter {

    private let isOnlineSubject = ReplaySubject<Bool?>.create(bufferSize: 1)
    private let disposeBag = DisposeBag()

    public func start(isOnlineSingle: Single<Bool>) {
        let serviceIsUp = Kit.application.rx.applicationDidBecomeActive
            .flatMap { _ -> Observable<Bool> in
                return isOnlineSingle
                    .asObservable()
                    .timeout(.seconds(5), scheduler: MainScheduler.instance)
                    .catchErrorJustReturn(false)
                    .takeUntil(Kit.application.rx.applicationWillResignActive)
            }

        Observable<Bool?>
            .merge(
                serviceIsUp.asOptional(),
                Kit.application.rx.applicationWillResignActive.mapTo(nil)
            )
            .startWith(nil)
            .bind(to: isOnlineSubject)
            .disposed(by: disposeBag)
    }

    public func isOnline() -> Observable<Bool> {
        return isOnlineSubject.unwrap().take(1)
    }
}
