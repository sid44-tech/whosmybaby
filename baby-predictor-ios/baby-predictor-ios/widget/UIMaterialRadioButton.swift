
import UIKit

class UIMaterialRadioButton: UIButton {

    init(frame: CGRect, text: String, selected: Bool, tag: Int, target: Any?, action: Selector?) {
        super.init(frame: frame)
        buildView(frame: frame, text: text, selected: selected, tag: tag, target: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView(frame: CGRect, text: String, selected: Bool, tag: Int, target: Any?, action: Selector?) {
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 14)
        self.setImage(UIImage(named: "radio.png"), for: .normal)
        self.setImage(UIImage(named: "radio.png"), for: .highlighted)
        self.setImage(UIImage(named: "radio_selected.png"), for: .selected)
        self.imageView?.contentMode = .scaleAspectFit
        self.contentHorizontalAlignment = .left
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -52, bottom: 0, right: 0)
        self.adjustsImageWhenHighlighted = false
        self.isSelected = selected
        self.isUserInteractionEnabled = true
        self.tag = tag
        if action != nil {
            let gesture = UITapGestureRecognizer(target: target, action: action)
            self.addGestureRecognizer(gesture)
        }
    }
}
