import Foundation

extension Date {
    static public func make(year: Int = 2000, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        guard let date = Calendar.current.date(from: components) else {
            fatalError("bad")
        }
        return date
    }
}
