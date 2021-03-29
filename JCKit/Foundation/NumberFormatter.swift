import Foundation

public struct NumberFormatter {
    public enum NumberStyle {
        case wholeNumber
        case dollars
        case percentage
    }

    private let numberFormatter = Foundation.NumberFormatter()

    public func dollars(from cents: Int) -> String {
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        let centsDecimal = NSDecimalNumber(value: cents)
        let oneHundred = NSDecimalNumber(value: 100)
        let decimal = centsDecimal.dividing(by: oneHundred)
        let string = numberFormatter.string(from: decimal) ?? ""
        if string.split(separator: ".").last?.count == 1 {
            // $0.1 -> $0.10
            return string + "0"
        }
        return string
    }

    public func cents(from dollars: String, formatted: Bool = false) -> Int {
        numberFormatter.numberStyle = formatted ? .currency : .none
        guard let number = numberFormatter.number(from: dollars) else {
            fatalError("unable to format, invalid string")
        }
        let oneHundred = NSDecimalNumber(value: 100)
        let decimalNumber = NSDecimalNumber(decimal: number.decimalValue)
        let cents = decimalNumber.multiplying(by: oneHundred)
        let int = Int(truncating: cents)
        return int
    }

    public func string(from number: Double, style: NumberStyle) -> String {
        let decimalNumber: NSDecimalNumber
        switch style {
        case .wholeNumber:
            numberFormatter.numberStyle = .decimal
            decimalNumber = NSDecimalNumber(value: number)
        case .dollars:
            numberFormatter.numberStyle = .currency
            decimalNumber = NSDecimalNumber(value: number)
        case .percentage:
            numberFormatter.numberStyle = .percent
            let percentOff = number.asFloat / 100
            decimalNumber = NSDecimalNumber(value: percentOff)
        }

        guard let string = numberFormatter.string(from: decimalNumber) else {
            fatalError("bad")
        }

        return string
    }
}
