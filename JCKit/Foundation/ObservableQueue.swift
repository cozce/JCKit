import Foundation
import RxSwift

public class ObservableQueue {

    private let semaphore = DispatchSemaphore(value: 1)
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)

    public func enqueue<T>(_ observable: Observable<T>) -> Observable<T> {
        return Observable
            .create { [semaphore] observer in
                semaphore.wait()
                let disposable = observable.subscribe { event in
                    switch event {
                    case .next:
                        observer.on(event)
                    case .error, .completed:
                        observer.on(event)
                    }
                }
                return Disposables.create {
                    disposable.dispose()
                    semaphore.signal()
                }
            }
            .subscribeOn(scheduler)
    }
}
