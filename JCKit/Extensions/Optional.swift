import Foundation
import RxSwift

extension Optional {
    public init(_ f: () -> Optional<Wrapped>) {
        self = f()
    }

    public func recover(_ wrapped: Wrapped) -> Wrapped {
        return self ?? wrapped
    }

    public func recover(_ f: () -> Wrapped) -> Wrapped {
        return self ?? f()
    }

    public func unwrap<A>(_ f: (Optional<Wrapped>) -> A) -> A {
        return f(self)
    }

    public func on(_ f: (Optional<Wrapped>) -> Void) -> Optional<Wrapped> {
        f(self)
        return self
    }

    public func printOut() -> Optional<Wrapped> {
        print("\(String(describing: self))")
        return self
    }

    public func zip<A>(_ optional: Optional<A>) -> Optional<(Wrapped, A)> {
        guard let first = self, let second = optional else {
            return nil
        }
        return (first, second)
    }

    public func recoverTo(_ wrapped: Wrapped) -> Wrapped {
        return self ?? wrapped
    }

    public func flatMapOnNil(_ f: () -> Wrapped?) -> Wrapped? {
        guard let wrapped = self else {
            return f()
        }
        return wrapped
    }

    public func on(_ f: (Wrapped) -> ()) -> Wrapped? {
        guard let wrapped = self else {
            return self
        }
        f(wrapped)
        return self
    }

    public static func zip<O>(_ first: Wrapped?, _ second: O?) -> (Wrapped, O)? {
        return first.zip(second)
    }

}
