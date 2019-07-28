import UIKit

class ColorsUtil {
    static func RGBToUIColor(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

