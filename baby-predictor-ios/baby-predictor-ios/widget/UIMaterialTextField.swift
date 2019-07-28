
//
//  UIMaterialSelect.swift
//  shooting alert
//
//  Created by Sid Bhat on 9/10/18.
//  Copyright © 2018 tbd. All rights reserved.
//

import UIKit

class UIMaterialTextField: UITextField, UITextFieldDelegate {
    let vc: UIViewController
    let borderColor: UIColor!
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    let hintText: String!
    var maxLength = -1
    
    init(frame: CGRect, borderColor: UIColor, vc: UIViewController, hintText: String) {
        self.vc = vc
        self.hintText = hintText
        self.borderColor = borderColor
        super.init(frame: frame)
        self.delegate = self
        buildView(frame: frame)
    }
    
    init(frame: CGRect, borderColor: UIColor, vc: UIViewController, hintText: String, maxLength: Int) {
        self.vc = vc
        self.hintText = hintText
        self.borderColor = borderColor
        self.maxLength = maxLength
        super.init(frame: frame)
        self.delegate = self
        buildView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView(frame: CGRect) {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        let attr = NSAttributedString(string: hintText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        //self.placeholder = hintText
        self.attributedPlaceholder = attr
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(UIMaterialTextField.closeKeyboard))
        doneButton.tintColor = UIColor.blue
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.isUserInteractionEnabled = true
        
        self.inputAccessoryView = toolBar
    }
    
    func setSecureMode(secure: Bool) {
        self.isSecureTextEntry = secure
    }
    
    @objc func closeKeyboard() {
        self.resignFirstResponder()
        //        if vc is HomeController {
        //            (vc as! HomeController).updateButtonState()
        //        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (maxLength != -1) {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true;
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
