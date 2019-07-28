
import UIKit

class MayanPredictorController : BaseViewController, UITextFieldDelegate {
    
    var conceptionAgeText: String?
    var conceptionYearText: String?
    var conceptionAgeInput: UIMaterialTextField!
    var conceptionYearInput: UIMaterialTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundPlain()
        buildHeaderSection()
        buildContent()
    }
    
    func buildContent() {
        var y = WidgetUtil.statusBarHeight + 78
        let x = self.view.frame.width/2 - 150
        
        let title = WidgetUtil.createImage(x, y: y, width: 300, height: 75, imageName: "mayan_title_center.png")
        
        y += 100
        
        let conceptionAgeLabel = WidgetUtil.createLabel(x, y: y, width: 300, height: 23, text: "Your age at conception")
        conceptionAgeLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        conceptionAgeLabel.textAlignment = .center
        y += 36
        conceptionAgeInput = UIMaterialTextField(frame: CGRect(x: x, y: y, width: 300, height: 41), borderColor: UIColor.white, vc: self, hintText: "Age", maxLength: 3)
        conceptionAgeInput.textAlignment = .center
        conceptionAgeInput.delegate = self
        conceptionAgeInput.keyboardType = .numberPad
        conceptionAgeInput.text = StorageUtil.getPropFor(key: "mayan-age")
        
        y += 78
        let conceptionYearLabel = WidgetUtil.createLabel(x, y: y, width: 300, height: 23, text: "Year of conception")
        conceptionYearLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
        conceptionYearLabel.textAlignment = .center
        y += 36
        //let conceptionYearInput = WidgetUtil.createTextField(CGRect(x: x, y: y, width: 300, height: 23), hint: "")
        conceptionYearInput = UIMaterialTextField(frame: CGRect(x: x, y: y, width: 300, height: 41), borderColor: UIColor.white, vc: self, hintText: "Year", maxLength: 4)
        conceptionYearInput.delegate = self
        conceptionYearInput.textAlignment = .center
        conceptionYearInput.keyboardType = .numberPad
        conceptionYearInput.text = StorageUtil.getPropFor(key: "mayan-year")
        
        y += 78
        let resultsButton = UIMaterialButton(frame: CGRect(x: x+25, y: y, width: 250, height: 41), text: "Get Results!", color: ColorsUtil.RGBToUIColor(red: 144, green: 202, blue: 249), target: self, action: #selector(getResults))
        
        self.view.addSubview(title)
        self.view.addSubview(conceptionAgeLabel)
        self.view.addSubview(conceptionAgeInput)
        self.view.addSubview(conceptionYearLabel)
        self.view.addSubview(conceptionYearInput)
        self.view.addSubview(resultsButton)
    }
    
    @objc func getResults() {
        StorageUtil.updatePropStringFor(key: "mayan-age", value: conceptionAgeInput.text!)
        StorageUtil.updatePropStringFor(key: "mayan-year", value: conceptionYearInput.text!)
        
        GenderSelectController.LOAD_INTERSTITIAL = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clearAllInfo() {
        
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
}

