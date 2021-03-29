import Foundation

public enum Result<A, E> {
    case success(A)
    case failure(E)

    public var success: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    public var error: E? {
        switch self {
        case .success:
            return nil
        case .failure(let e):
            return e
        }
    }

    public var value: A? {
        switch self {
        case .success(let a):
            return a
        case .failure:
            return nil
        }
    }

    public init(_ f: () -> Result<A, E>) {
        self = f()
    }

    public func map<B>(_ transform: (A) -> B) -> Result<B, E> {
        switch self {
        case let .success(a):
            return .success(transform(a))
        case let .failure(e):
            return .failure(e)
        }
    }

    public func flatMap<B>(_ transform: (A) -> Result<B, E>) -> Result<B, E> {
        switch self {
        case let .success(a):
            return transform(a)
        case let .failure(e):
            return .failure(e)
        }
    }

    public func mapError<F>(_ transform: (E) -> F) -> Result<A, F> {
        switch self {
        case let .success(a):
            return .success(a)
        case let .failure(e):
            return .failure(transform(e))
        }
    }

    public func flatMapError<F>(_ transform: (E) -> Result<A, F>) -> Result<A, F> {
        switch self {
        case let .success(a):
            return .success(a)
        case let .failure(e):
            return transform(e)
        }
    }

    public func zip<B>(_ b: Result<B, E>) -> Result<(A, B), E> {
        switch (self, b) {
        case (.success(let a), .success(let b)):
            return .success((a, b))
        case (.failure(let a), .failure):
            return .failure(a)
        case (.success, .failure(let b)):
            return .failure(b)
        case (.failure(let a), .success):
            return .failure(a)
        }
    }

    public func recover(_ value: A) -> A {
        switch self {
        case .success(let a):
            return a
        case .failure:
            return value
        }
    }

    public func recover(_ transform: (E) -> A) -> A {
        switch self {
        case .success(let a):
            return a
        case .failure(let e):
            return transform(e)
        }
    }

    public func attemptRecovery(_ transform: (E) -> Result<A, E>) -> Result<A, E> {
        switch self {
        case .success(let a):
            return .success(a)
        case .failure(let e):
            return transform(e)
        }
    }

    public func onSuccess(_ f: (A) -> Void) -> Result<A, E> {
        switch self {
        case .success(let a):
            f(a)
        case .failure:
            break
        }
        return self
    }

    public func onFailure(_ f: (E) -> Void) -> Result<A, E> {
        switch self {
        case .success:
            break
        case .failure(let e):
            f(e)
        }
        return self
    }
}

extension Result where E == Swift.Error {
    public init(_ f: () throws -> A) {
        do {
            self = .success(try f())
        } catch {
            self = .failure(error)
        }
    }
}
