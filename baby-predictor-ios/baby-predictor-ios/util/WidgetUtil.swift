
import UIKit

class WidgetUtil {
    static let greenFontTag = "<font color='#00FF00' face='Avenir Black' size='4'>"
    static let whiteFontTag = "<font color='#FFFFFF' face='Avenir Black' size='4'>"
    static let blackFontTag = "<font color='#000000' face='Avenir Black' size='4'>"
    static let redFontTag = "<font color='#FF423D' face='Avenir Black' size='4'>"
    static let redBoldFontTag = "<font color='#FF423D' face='Avenir Black' size='4'><b>"
    static let darkGrayFontTag = "<font color='#7A7A7A' face='Avenir Black' size='4'>"
    static let closeFontTag = "</font>"
    static let closeBoldFontTag = "</b></font>"
    
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let userY = statusBarHeight
    static let logoY = statusBarHeight + 7
    static let homeY = statusBarHeight + 15
    static let backY = statusBarHeight
    
    static func RGBToUIColor(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static func createLabel(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String) -> UILabel {
        return createLabel(x, y: y, width: width, height: height, text: text, textColor: UIColor.white)
    }
    
    static func createLabel(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, textColor: UIColor) -> UILabel {
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        label.text = text
        label.backgroundColor = UIColor.clear
        label.textColor = textColor
        label.font = UIFont(name: "Avenir-Book", size: 14)
        return label
    }
    
    static func createLabel(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, textColor: UIColor, backgroundColor: UIColor) -> UILabel {
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        label.text = text
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.font = UIFont(name: "Avenir-Book", size: 14)
        return label
    }
    
    static func createLabel(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, hintText: String) -> UIView {
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        let text = createLabel(0, y: 0, width: width, height: 21, text: text)
        let hint = createLabel(0, y: 21, width: width, height: 12, text: hintText, textColor: UIColor(red:0.62, green:0.62, blue:0.62, alpha:1.0))
        hint.font = hint.font.withSize(12)
        
        view.addSubview(text)
        view.addSubview(hint)
        
        return view
    }
    
    static func createLabel(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, hintText: String, fontName: String, size: Int) -> UIView {
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        let text = createLabel(0, y: 0, width: width, height: 21, text: text)
        text.font = UIFont(name: fontName, size: CGFloat(size))
        let hint = createLabel(0, y: 21, width: width, height: 12, text: hintText, textColor: UIColor(red:0.62, green:0.62, blue:0.62, alpha:1.0))
        hint.font = hint.font.withSize(12)
        
        view.addSubview(text)
        view.addSubview(hint)
        
        return view
    }
    
    static func createTextField(_ rect: CGRect, hint: String) -> UITextField {
        let field = UITextField(frame: rect)
        field.backgroundColor = UIColor.black
        field.textColor = UIColor.white
        field.font = UIFont(name: "Avenir-Book", size: 14)
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: field.frame.size.height - borderWidth, width:  field.frame.size.width, height: field.frame.size.height)
        border.borderWidth = borderWidth
        
        field.layer.addSublayer(border)
        field.layer.masksToBounds = true
        field.attributedPlaceholder = NSAttributedString(string:hint, attributes:[NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        field.isUserInteractionEnabled = true
        
        return field
    }
    
    static func createImage(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, imageName: String) -> UIImageView {
        let image = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        image.image = UIImage(named: imageName)
        image.contentMode = .scaleAspectFit
        return image
    }
    
    static func createImageUnscaled(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, imageName: String) -> UIImageView {
        let image = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        image.image = UIImage(named: imageName)
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleToFill
        return image
    }
    
    static func createButton(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String, enabled: Bool) -> UILabel {
        let bla = CGFloat(168)/CGFloat(255)
        let button = WidgetUtil.createLabel(x, y: y, width: width, height: height, text: text)
        if (enabled) {
            button.backgroundColor = UIColor.init(red: 71/256, green: 176/256, blue: 75/256, alpha: 1)
            button.textColor = UIColor.white
        } else {
            button.backgroundColor = UIColor.init(red: 208/256, green: 208/256, blue: 202/256, alpha: 1)
            button.textColor = UIColor.init(red: bla, green: bla, blue: bla, alpha: 1)
        }
        
        button.textAlignment = .center
        button.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        //        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        //        button.layer.shadowOpacity = 1
        //        button.layer.shadowRadius = 2
        return button
    }
    
    //    static func getRightNavBarButtonItems(_ viewc: UIViewController, picksSold: UIImage?) -> [UIBarButtonItem] {
    //        var navButtonsRight = [UIBarButtonItem]()
    //
    //        let logo = UIImage(named: "pfu_icon_logo_24.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    //        let logoButton: UIBarButtonItem = UIBarButtonItem(image: logo, style: UIBarButtonItemStyle.plain, target: viewc, action: #selector(BaseViewController.userAccount))
    //        logoButton.width = 20.0;
    //        logoButton.isEnabled = false
    //
    //        navButtonsRight.append(logoButton)
    //
    //        if (picksSold != nil) {
    //            let soldButton: UIBarButtonItem = UIBarButtonItem(image: picksSold, style: UIBarButtonItemStyle.plain, target: viewc, action: #selector(BaseViewController.showPicksSoldHelper))
    //            soldButton.width = 24.0;
    //            soldButton.isEnabled = true
    //            navButtonsRight.append(soldButton)
    //        }
    //
    //        return navButtonsRight
    //    }
    
    static func createSpacer(x: Int, y: Int, width: Int) -> UIView {
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: 1))
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    static func createContestSpacer(x: Int, y: Int, width: Int) -> UIView {
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: 1))
        view.backgroundColor = UIColor.orange
        return view
    }
    
    static func getLeagueImageString(league: String) -> String {
        var imageString = ""
        if (league == "NFL") {
            imageString = "football_icon.png"
        } else if (league == "NHL") {
            imageString = "hockey_icon.png"
        } else if (league == "MLB") {
            imageString = "baseball_icon.png"
        } else if (league == "NBA") {
            imageString = "basketball_icon.png"
        } else if (league == "NCAAF") {
            imageString = "college_football_icon.png"
        } else if (league == "NCAAB") {
            imageString = "college_basketball_icon.png"
        }
        
        return imageString
    }
}

