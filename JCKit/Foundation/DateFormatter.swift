import Foundation

public struct DateFormatter {
    public enum Style: String {
        /// 1st | 10th
        case ordinal = ""

        /// Mon | Tue
        case weekday = "EEE"

        /// Jan | Feb | Mar
        case MMM_YYYY = "MMM YYYY"

        /// 1/1/10, 10/10/10
        case MdYY = "M/d/YY"

        /// 2000 | 2001
        case YYYY = "yyyy"

        /// January 2000 | February 2001
        case MMMM_YYYY = "MMMM YYYY"

        /// Mon, Jan 1 2001 | Tue, Jan 10 2001
        case EEE_MMM_d_YYYY = "EEE, MMM d YYYY"

        /// Mon, 01/01 | Tue, 01/10
        case E_MM_dd = "E, MM/dd"
    }

    public enum Format {
        case iso
    }

    private let isoDateFormatter = ISO8601DateFormatter()
    private let dateFormatter = Foundation.DateFormatter()
    private let ordinalFormatter: Foundation.NumberFormatter = {
        let formatter = Foundation.NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()

    public func date(string: String, format: Format) -> Date {
        switch format {
        case .iso:
            guard let date = isoDateFormatter.date(from: string) else {
                fatalError("bad")
            }
            return date
        }
    }

    public func string(from date: Date, style: Style) -> String {
        dateFormatter.dateFormat = style.rawValue
        switch style {
        case .ordinal:
            dateFormatter.dateFormat = "dd"
            let dayNumberString = dateFormatter.string(from: date)
            guard let dayNumber = Int(dayNumberString) else {
                fatalError("bad")
            }
            let weekdayNSNumber = NSNumber(value: dayNumber)
            guard let ordinalString = ordinalFormatter.string(from: weekdayNSNumber) else {
                fatalError("bad")
            }
            return ordinalString
        default:
            return dateFormatter.string(from: date)
        }
    }
}
