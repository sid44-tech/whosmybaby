
import UIKit

class UIMaterialButton: UIButton {
    let bgColor: UIColor!
    
    init(frame: CGRect, text: String, color: UIColor, target: Any?, action: Selector?) {
        bgColor = color
        super.init(frame: frame)
        buildView(frame: frame, text: text, color: color, target: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView(frame: CGRect, text: String, color: UIColor, target: Any?, action: Selector?) {
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y , width: frame.width, height: frame.height)
        self.backgroundColor = color
        
        let fontSize = 18
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let textFont = UIFont(name: "Avenir-Black", size: CGFloat(fontSize))!
        let textFontAttributes = NSAttributedString(string: text,
                                                    attributes: [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): textFont, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: style])
        
        self.setAttributedTitle(textFontAttributes, for: UIControl.State.normal)
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        if target != nil {
            let gesture = UITapGestureRecognizer(target: target, action: action)
            self.addGestureRecognizer(gesture)
        }
    }
    
    func enable() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = bgColor
    }
    
    @objc func disable() {
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.gray
    }
}

