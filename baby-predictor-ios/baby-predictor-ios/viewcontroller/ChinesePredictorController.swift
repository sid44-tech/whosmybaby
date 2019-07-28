
import UIKit

class ChinesePredictorController : BaseViewController, UITextFieldDelegate {
    
    var conceptionAgeText: String?
    var conceptionYearText: String?
    var conceptionDateLabel: UILabel!
    var dueDateLabel: UILabel!
    var cdateInput: UIDatePicker!
    var bdayInput: UIDatePicker!
    var selectedDate = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if StorageUtil.getPropFor(key: "chinese-date-selection") == "" {
            selectedDate = 0
            StorageUtil.updatePropStringFor(key: "chinese-date-selection", value: "0")
        } else {
            if StorageUtil.getPropFor(key: "chinese-date-selection") == "0" {
                selectedDate = 0
            } else {
                selectedDate = 1
            }
        }
        setBackgroundPlain()
        buildHeaderSection()
        buildContent()
    }
    
    func buildContent() {
        var y = WidgetUtil.statusBarHeight + 78
        let x = self.view.frame.width/2 - 150
        let firstX = self.view.frame.width/2 - 130 - 24
        
        let title = WidgetUtil.createImage(x, y: y, width: 300, height: 75, imageName: "chinese_title_center.png")
        
        y += 100
        
        conceptionDateLabel = WidgetUtil.createLabel(firstX, y: y, width: 170, height: 23, text: "Conception date")
        conceptionDateLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        conceptionDateLabel.textAlignment = .left
        
        if selectedDate == 0 {
            conceptionDateLabel.textColor = UIColor.white
            let textRange = NSMakeRange(0, conceptionDateLabel.text!.count)
            let attributedText = NSMutableAttributedString(string: conceptionDateLabel.text!)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            conceptionDateLabel.attributedText = attributedText
        } else {
            conceptionDateLabel.textColor = UIColor.white.withAlphaComponent(0.4)
        }
        
        conceptionDateLabel.isUserInteractionEnabled = true
        let conceptionsGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectConceptionDate))
        conceptionDateLabel.addGestureRecognizer(conceptionsGesture)
        
        let orLabel = WidgetUtil.createLabel(firstX+171, y: y, width: 20, height: 23, text: "or")
        orLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        orLabel.textAlignment = .center
        
        dueDateLabel = WidgetUtil.createLabel(firstX+190, y: y, width: 110, height: 23, text: "Due date")
        dueDateLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        dueDateLabel.textColor = UIColor.white.withAlphaComponent(0.4)
        dueDateLabel.textAlignment = .right
        
        if selectedDate == 1 {
            dueDateLabel.textColor = UIColor.white
            let textRange = NSMakeRange(0, dueDateLabel.text!.count)
            let attributedText = NSMutableAttributedString(string: dueDateLabel.text!)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            dueDateLabel.attributedText = attributedText
        } else {
            dueDateLabel.textColor = UIColor.white.withAlphaComponent(0.4)
        }
        
        dueDateLabel.isUserInteractionEnabled = true
        let dueDateGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectDueDate))
        dueDateLabel.addGestureRecognizer(dueDateGesture)
        
        y += 36
        
        cdateInput = UIDatePicker(frame: CGRect(x: x, y: y, width: 300, height: 60))
        cdateInput.datePickerMode = .date
        cdateInput.setValue(UIColor.white, forKeyPath: "textColor")
        if StorageUtil.getPropFor(key: "chinese-conception-date") != "" {
            loadDate(datePicker: cdateInput, propertyName: "chinese-conception-date")
        }
        
        y += 86
        let birthDateLabel = WidgetUtil.createLabel(x, y: y, width: 300, height: 23, text: "Your birth date")
        birthDateLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        birthDateLabel.textAlignment = .center
        y += 31
        
        bdayInput = UIDatePicker(frame: CGRect(x: x, y: y, width: 300, height: 60))
        bdayInput.datePickerMode = .date
        bdayInput.setValue(UIColor.white, forKeyPath: "textColor")
        if StorageUtil.getPropFor(key: "chinese-birth-date") != "" {
            loadDate(datePicker: bdayInput, propertyName: "chinese-birth-date")
        }
        
        y += 86
        let resultsButton = UIMaterialButton(frame: CGRect(x: x+25, y: y, width: 250, height: 41), text: "Get Results!", color: ColorsUtil.RGBToUIColor(red: 144, green: 202, blue: 249), target: self, action: #selector(getResults))
        
        self.view.addSubview(title)
        self.view.addSubview(conceptionDateLabel)
        self.view.addSubview(cdateInput)
        self.view.addSubview(orLabel)
        self.view.addSubview(dueDateLabel)
        self.view.addSubview(birthDateLabel)
        self.view.addSubview(bdayInput)
        self.view.addSubview(resultsButton)
    }
    
    @objc func getResults() {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .short
        
        let conceptionDate = timeFormatter.string(from: cdateInput.date)
        StorageUtil.updatePropStringFor(key: "chinese-conception-date", value: conceptionDate)
        
        let birthDate = timeFormatter.string(from: bdayInput.date)
        StorageUtil.updatePropStringFor(key: "chinese-birth-date", value: birthDate)
        
        if (selectedDate == 0) {
            StorageUtil.updatePropStringFor(key: "chinese-date-selection", value: "0")
        } else {
            StorageUtil.updatePropStringFor(key: "chinese-date-selection", value: "1")
        }
        
        GenderSelectController.LOAD_INTERSTITIAL = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        if newLength > 4 {
            return false
        }
        
        let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    @objc func selectConceptionDate() {
        let textRange = NSMakeRange(0, conceptionDateLabel.text!.count)
        let attributedText = NSMutableAttributedString(string: conceptionDateLabel.text!)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        conceptionDateLabel.attributedText = attributedText
        conceptionDateLabel.textColor = UIColor.white
        
        let textRange2 = NSMakeRange(0, dueDateLabel.text!.count)
        let attributedText2 = NSMutableAttributedString(string: dueDateLabel.text!)
        attributedText2.removeAttribute(NSAttributedString.Key.underlineStyle, range: textRange2)
        dueDateLabel.attributedText = attributedText2
        dueDateLabel.textColor = UIColor.white.withAlphaComponent(0.4)
        
        selectedDate = 0
    }
    
    @objc func selectDueDate() {
        let textRange = NSMakeRange(0, conceptionDateLabel.text!.count)
        let attributedText = NSMutableAttributedString(string: conceptionDateLabel.text!)
        attributedText.removeAttribute(NSAttributedString.Key.underlineStyle, range: textRange)
        conceptionDateLabel.attributedText = attributedText
        conceptionDateLabel.textColor = UIColor.white.withAlphaComponent(0.4)
        
        let textRange2 = NSMakeRange(0, dueDateLabel.text!.count)
        let attributedText2 = NSMutableAttributedString(string: dueDateLabel.text!)
        attributedText2.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange2)
        dueDateLabel.attributedText = attributedText2
        dueDateLabel.textColor = UIColor.white
        
        selectedDate = 1
    }
    
    func loadDate(datePicker: UIDatePicker, propertyName: String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US_en")
        formatter.dateStyle = .short
        let date = formatter.date(from: StorageUtil.getPropFor(key: propertyName))
        
        datePicker.date = date!
    }
}

