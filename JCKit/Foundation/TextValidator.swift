import Foundation

public protocol iTextValidator {
    func validate(postalCode: String) -> TextValidator.Validation
}

public struct TextValidator: iTextValidator {
    public enum Error: Swift.Error {
        case invalid
    }

    public struct Validation {
        let value: String
        let errors: [Error]
    }

    public func validate(postalCode: String) -> Validation {
        if postalCode.count < 5 {
            return Validation(value: postalCode, errors: [.invalid])
        }
        if postalCode.count > 5 {
            let trimmedPostalCode = String(postalCode.prefix(5))
            return Validation(value: trimmedPostalCode, errors: [])
        }
        return Validation(value: postalCode, errors: [])
    }
}
