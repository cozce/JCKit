import Foundation
import UIKit

public struct ColorPicker {
    public enum Color: String {
        case red = "235-102-090"
        case yellow = "224-193-075"
        case green = "116-191-070"
        case blue = "36-89-201"

        case softBlack = "50-50-50"
        case mediumGray = "150-150-150"
        case gray = "170-170-170"
        case lightGray = "220-220-220"
        case ultraLightGray = "247-247-247"
        case white = "255-255-255"
    }

    public enum Transparency {
        case full
        case half
        case semi
        case none
    }

    public func pick(_ color: Color, transparency: Transparency = .none) -> UIColor {
        let (red, green, blue) = color.rawValue
            .split(separator: "-")
            .compactMap { string in
                Int(string)
            }
            .enumerated()
            .reduce((0, 0, 0)) { (lastOutput, tuple) -> (Int, Int, Int) in
                let (index, value) = tuple
                switch index {
                case 0:
                    return (value,          lastOutput.1,   lastOutput.2)
                case 1:
                    return (lastOutput.0,   value,          lastOutput.2)
                default:
                    return (lastOutput.0,   lastOutput.1,   value)
                }
            }

        let alpha: CGFloat
        switch transparency {
        case .full:
            alpha = 0
        case .half:
            alpha = 0.5
        case .semi:
            alpha = 0.85
        case .none:
            alpha = 1
        }
        return UIColor(
            red: red.asCGFloat / 255,
            green: green.asCGFloat / 255,
            blue: blue.asCGFloat / 255,
            alpha: alpha
        )
    }
}
