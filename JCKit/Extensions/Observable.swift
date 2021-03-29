import Foundation
import RxSwift

extension ObservableType {

    static public func justDo(_ f: () -> Element) -> Observable<Element> {
        return Observable.just(f())
    }

    public func withLatestFrom<A, B>(_ a: Observable<A>, _ b: Observable<B>) -> Observable<(A, B)> {
        return self.withLatestFrom(a).andLatestFrom(b)
    }

    public func withLatestFrom<A, B, C>(_ a: Observable<A>, _ b: Observable<B>, _ c: Observable<C>) -> Observable<(A, B, C)> {
        return self.withLatestFrom(a).andLatestFrom(b, c)
    }

    public func andLatestFrom<B>(_ b: Observable<B>) -> Observable<(Element, B)> {
        return self.withLatestFrom(b) { (a: Element, b: B) in
            return (a, b)
        }
    }

    public func andLatestFrom<B, C>(_ b: Observable<B>, _ c: Observable<C>) -> Observable<(Element, B, C)> {
        return self
            .withLatestFrom(b) { (a: Element, b: B) in
                return (a, b)
            }
            .withLatestFrom(c) { (ab, c) in
                let (a, b) = ab
                return (a, b, c)
            }
    }

    public func asOptional() -> Observable<Element?> {
        return self.map { e in e }
    }

    public func delay(_ seconds: Int) -> Observable<Element> {
        return self.delay(.seconds(seconds), scheduler: MainScheduler.instance)
    }
    
    public func toggle(startWith: Bool) -> Observable<Bool> {
        return self.scan(startWith) { lastValue, _ in
            return !lastValue
        }
        .startWith(startWith)
    }

    public func debugTrimmed() -> Observable<Element> {
        return self.debug(nil, trimOutput: true)
    }
}
