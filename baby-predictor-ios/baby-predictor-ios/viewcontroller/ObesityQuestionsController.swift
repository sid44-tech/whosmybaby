
import UIKit

class ObesityQuestionsController : BaseViewController {
    
    static let UNSK_TAG = 20
    static let SKMA_TAG = 21
    static let SKNM_TAG = 22
    static let ENTR_TAG = 23
    
    static let SMOKING_NO_TAG = 30
    static let SMOKING_YES_TAG = 31
    
    static let PROF_TAGS = [UNSK_TAG, SKMA_TAG, SKNM_TAG, ENTR_TAG]

    var sview: UIScrollView!
    var resultsButton: UIMaterialButton!
    
    var responseMessages = [100: "",
    101: "",
    102: "",
    103: "",
    104: "",
    105: "",
    106: "",
    107: "",
    108: "",
    109: "",
    110: ""]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rawValues = StorageUtil.getPropFor(key: "obesity-answers")
        parseAnswers(rawValues: rawValues)
        
        setBackgroundPlain()
        buildHeaderSection()
        buildContent()
    }
    
    func parseAnswers(rawValues: String) {
        if rawValues.count == 0 {
            return
        }
        
        let values = rawValues.split(separator: ",")
        
        var index = 100
        for value in values {
            responseMessages[index] = String(value)
            index += 1
        }
    }
    
    func buildContent() {
        sview = UIScrollView(frame: CGRect(x: 0, y: WidgetUtil.statusBarHeight+44, width: self.view.frame.width, height: self.view.frame.height-WidgetUtil.statusBarHeight+44))
        
        var y = WidgetUtil.statusBarHeight
        let x = self.view.frame.width/2 - 150
        
        buildTitleSection(y: y)
        y += 75
        buildHeightWeightSection(yIn: y, labelTextPrefix: "Mother's", tagStart: 100)
        y += 186
        buildHeightWeightSection(yIn: y, labelTextPrefix: "Father's", tagStart: 103)
        y += 186
        buildHouseholdSection(y: y, tagStart: 106)
        y += 106
        buildProfessionSection(yIn: y)
        y += 184
        buildSmokingSection(y: y)
        y += 86
        buildBirthWeightSection(yIn: y, tagStart: 109)
        y += 144
        
        resultsButton = UIMaterialButton(frame: CGRect(x: x+25, y: y, width: 250, height: 41), text: "Get Results!", color: ColorsUtil.RGBToUIColor(red: 144, green: 202, blue: 249), target: self, action: #selector(getResults))
        
        sview.addSubview(resultsButton)
        y += 250
        
        sview.contentSize = CGSize(width: self.view.frame.width, height: y)
        self.view.addSubview(sview)
    }
    
    func buildTitleSection(y: CGFloat) {
        let uniteLabel = UILabel(frame: CGRect(x: 16, y: y, width: 250, height: 30))
        uniteLabel.text = "Enter Information"
        uniteLabel.textColor = UIColor.white
        uniteLabel.backgroundColor = UIColor.clear
        uniteLabel.font = UIFont(name: "AvenirNext-Bold", size: 24)
        sview.addSubview(uniteLabel)
    }
    
    func buildHeightWeightSection(yIn: CGFloat, labelTextPrefix: String, tagStart: Int) {
        var x = CGFloat(16)
        var y = yIn
        
        let heightLabel = UILabel(frame: CGRect(x: x, y: y, width: 150, height: 30))
        heightLabel.text = labelTextPrefix + " Height"
        heightLabel.textColor = UIColor.white
        heightLabel.backgroundColor = UIColor.clear
        heightLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(heightLabel)
        
        y += 34
        
        var frame = CGRect(x: x, y: y, width: 75, height: 41)
        let ft = UIMaterialTextField(frame: frame, borderColor: UIColor.white, vc: self, hintText: "", maxLength: 2)
        ft.tag = tagStart
        ft.keyboardType = .numberPad
        ft.text = responseMessages[tagStart]
        sview.addSubview(ft)

        x += 80
        
        let ftLabel = UILabel(frame: CGRect(x: x, y: y, width: 20, height: 41))
        ftLabel.text = "ft"
        ftLabel.textColor = UIColor.white
        ftLabel.backgroundColor = UIColor.clear
        ftLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(ftLabel)
        
        x += 30
        
        frame = CGRect(x: x, y: y, width: 75, height: 41)
        let inch = UIMaterialTextField(frame: frame, borderColor: UIColor.white, vc: self, hintText: "", maxLength: 2)
        inch.tag = tagStart+1
        inch.keyboardType = .numberPad
        inch.text = responseMessages[tagStart+1]
        sview.addSubview(inch)
        
        x += 80
        
        let inLabel = UILabel(frame: CGRect(x: x, y: y, width: 20, height: 41))
        inLabel.text = "in"
        inLabel.textColor = UIColor.white
        inLabel.backgroundColor = UIColor.clear
        inLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(inLabel)
        
        y += 48
        x = CGFloat(16)
        
        let weightLabel = UILabel(frame: CGRect(x: x, y: y, width: 150, height: 30))
        weightLabel.text = "Weight"
        weightLabel.textColor = UIColor.white
        weightLabel.backgroundColor = UIColor.clear
        weightLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(weightLabel)
        
        y += 34
        
        frame = CGRect(x: x, y: y, width: 75, height: 41)
        let lbs = UIMaterialTextField(frame: frame, borderColor: UIColor.white, vc: self, hintText: "", maxLength: 3)
        lbs.tag = tagStart+2
        lbs.keyboardType = .numberPad
        lbs.text = responseMessages[tagStart+2]
        sview.addSubview(lbs)

        x += 80
        
        let lbLabel = UILabel(frame: CGRect(x: x, y: y, width: 30, height: 41))
        lbLabel.text = "lbs"
        lbLabel.textColor = UIColor.white
        lbLabel.backgroundColor = UIColor.clear
        lbLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(lbLabel)
    }
    
    func buildHouseholdSection(y: CGFloat, tagStart: Int) {
        let label = UILabel(frame: CGRect(x: 16, y: y, width: 250, height: 30))
        label.text = "Number of people in household"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(label)
        
        let frame = CGRect(x: 16, y: y+34, width: 75, height: 41)
        let field = UIMaterialTextField(frame: frame, borderColor: UIColor.white, vc: self, hintText: "", maxLength: 2)
        field.tag = tagStart
        field.keyboardType = .numberPad
        field.text = responseMessages[tagStart]
        sview.addSubview(field)
    }
    
    func buildProfessionSection(yIn: CGFloat) {
        let selectedIndex = radioSelected()
        var y = yIn
        
        let label = UILabel(frame: CGRect(x: 16, y: y, width: 200, height: 30))
        label.text = "Mother's profession"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(label)
        
        y += 34
        var frame = CGRect(x: 0, y: y, width: 300, height: 23)
        let opt1 = UIMaterialRadioButton(frame: frame, text: "Unskilled/Apprentice/Unemployed", selected: selectedIndex == 1, tag: ObesityQuestionsController.UNSK_TAG, target: self, action: #selector(self.toggleProfession(_:)))
        sview.addSubview(opt1)
        
        y += 34
        frame = CGRect(x: 0, y: y, width: 250, height: 23)
        let opt2 = UIMaterialRadioButton(frame: frame, text: "Skilled-Manual", selected: selectedIndex == 2, tag: ObesityQuestionsController.SKMA_TAG, target: self, action: #selector(self.toggleProfession))
        sview.addSubview(opt2)

        y += 34
        frame = CGRect(x: 0, y: y, width: 250, height: 23)
        let opt3 = UIMaterialRadioButton(frame: frame, text: "Skilled-Non Manual", selected: selectedIndex == 3, tag: ObesityQuestionsController.SKNM_TAG, target: self, action: #selector(self.toggleProfession))
        sview.addSubview(opt3)
        
        y += 34
        frame = CGRect(x: 0, y: y, width: 250, height: 23)
        let opt4 = UIMaterialRadioButton(frame: frame, text: "Professional/Entrepreneur", selected: selectedIndex == 4, tag: ObesityQuestionsController.ENTR_TAG, target: self, action: #selector(self.toggleProfession))
        sview.addSubview(opt4)
    }
    
    func buildSmokingSection(y: CGFloat) {
        let selectedIndex = smokingRadioSelected()
        let label = UILabel(frame: CGRect(x: 16, y: y, width: 340, height: 30))
        label.text = "Did the mother smoke during pregnancy?"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(label)
        
        var frame = CGRect(x: 0, y: y+34, width: 90, height: 23)
        let noButton = UIMaterialRadioButton(frame: frame, text: "No", selected: selectedIndex == 1, tag: ObesityQuestionsController.SMOKING_NO_TAG, target: self, action: #selector(self.toggleSmoking(_:)))
        sview.addSubview(noButton)
        
        frame = CGRect(x: 64, y: y+34, width: 90, height: 23)
        let yesButton = UIMaterialRadioButton(frame: frame, text: "Yes", selected: selectedIndex == 2, tag: ObesityQuestionsController.SMOKING_YES_TAG, target: self, action: #selector(self.toggleSmoking(_:)))
        sview.addSubview(yesButton)
    }
    
    func buildBirthWeightSection(yIn: CGFloat, tagStart: Int) {
        var x = CGFloat(16)
        var y = yIn
        
        let label = UILabel(frame: CGRect(x: x, y: y, width: 230, height: 30))
        label.text = "Baby's birth weight"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(label)
        
        y += 34
        
        var frame = CGRect(x: x, y: y, width: 75, height: 41)
        let ft = UIMaterialTextField(frame: frame, borderColor: UIColor.white, vc: self, hintText: "", maxLength: 2)
        ft.tag = tagStart
        ft.keyboardType = .numberPad
        ft.text = responseMessages[tagStart]
        sview.addSubview(ft)

        x += 80
        
        let ftLabel = UILabel(frame: CGRect(x: x, y: y, width: 25, height: 41))
        ftLabel.text = "lbs"
        ftLabel.textColor = UIColor.white
        ftLabel.backgroundColor = UIColor.clear
        ftLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(ftLabel)
        
        x += 35
        
        frame = CGRect(x: x, y: y, width: 75, height: 41)
        let inch = UIMaterialTextField(frame: frame, borderColor: UIColor.white, vc: self, hintText: "", maxLength: 2)
        inch.tag = tagStart+1
        inch.keyboardType = .numberPad
        inch.text = responseMessages[tagStart+1]
        sview.addSubview(inch)
        
        x += 80
        
        let inLabel = UILabel(frame: CGRect(x: x, y: y, width: 20, height: 41))
        inLabel.text = "oz"
        inLabel.textColor = UIColor.white
        inLabel.backgroundColor = UIColor.clear
        inLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sview.addSubview(inLabel)
    }
    
    
    func radioSelected() -> Int {
        if (responseMessages[107] == "") {
            return 1
        }
        return Int(responseMessages[107]!)!
    }
    
    func smokingRadioSelected() -> Int {
        if (responseMessages[108] == "") {
            return 1
        }
        return Int(responseMessages[108]!)!
    }
    
    @objc func toggleSmoking(_ gestureRecognizer: UITapGestureRecognizer) {
        let selectedTag = gestureRecognizer.view!.tag
        
        var clickedTag = ObesityQuestionsController.SMOKING_NO_TAG
        var otherTag = ObesityQuestionsController.SMOKING_YES_TAG
        if selectedTag == ObesityQuestionsController.SMOKING_YES_TAG {
            clickedTag = ObesityQuestionsController.SMOKING_YES_TAG
            otherTag = ObesityQuestionsController.SMOKING_NO_TAG
        }
        
        if !(gestureRecognizer.view as! UIMaterialRadioButton).isSelected {
            (sview.viewWithTag(clickedTag) as! UIMaterialRadioButton).isSelected = true
            (sview.viewWithTag(otherTag) as! UIMaterialRadioButton).isSelected = false
        }
    }
    
    @objc func toggleProfession(_ gestureRecognizer: UITapGestureRecognizer) {
        let selectedTag = getSelectedProfessionTag(tag: gestureRecognizer.view!.tag)
        
        for tag in ObesityQuestionsController.PROF_TAGS {
            if selectedTag == tag {
                (sview.viewWithTag(tag) as! UIMaterialRadioButton).isSelected = true
            } else {
                (sview.viewWithTag(tag) as! UIMaterialRadioButton).isSelected = false
            }
        }
    }
    
    func getSelectedProfessionTag(tag: Int) -> Int {
        if (tag == ObesityQuestionsController.UNSK_TAG) {
            return ObesityQuestionsController.UNSK_TAG
        } else if (tag == ObesityQuestionsController.SKMA_TAG) {
            return ObesityQuestionsController.SKMA_TAG
        } else if (tag == ObesityQuestionsController.SKNM_TAG) {
            return ObesityQuestionsController.SKNM_TAG
        } else {
            return ObesityQuestionsController.ENTR_TAG
        }
    }
    
    func tagFieldEmpty(tag: Int) -> Bool {
        if (sview.viewWithTag(tag) as! UIMaterialTextField).text == nil || (sview.viewWithTag(tag) as! UIMaterialTextField).text! == "" {
            return true
        }
        return false
    }
    
    func valueForTagField(tag: Int) -> String {
        return (sview.viewWithTag(tag) as! UIMaterialTextField).text!
    }
    
    func valueForTagRadios() -> String {
        if (sview.viewWithTag(ObesityQuestionsController.UNSK_TAG) as! UIMaterialRadioButton).isSelected {
            return "1"
        } else if (sview.viewWithTag(ObesityQuestionsController.SKMA_TAG) as! UIMaterialRadioButton).isSelected {
            return "2"
        } else if (sview.viewWithTag(ObesityQuestionsController.SKMA_TAG) as! UIMaterialRadioButton).isSelected {
            return "3"
        } else {
            return "4"
        }
    }
    
    func valueForSmokingRadios() -> String {
        if (sview.viewWithTag(ObesityQuestionsController.SMOKING_NO_TAG) as! UIMaterialRadioButton).isSelected {
            return "1"
        } else {
            return "2"
        }
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: (self.view.frame.size.height/2)-35, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @objc func getResults() {
        if tagFieldEmpty(tag: 100) || tagFieldEmpty(tag: 101) || tagFieldEmpty(tag: 102) || tagFieldEmpty(tag: 103) ||
            tagFieldEmpty(tag: 104) || tagFieldEmpty(tag: 105) || tagFieldEmpty(tag: 106) || tagFieldEmpty(tag: 109) || tagFieldEmpty(tag: 110) {
            showToast(message: "Missing required fields", font: UIFont(name: "AvenirNext-Bold", size: 14)!)
            return
        }
        
        let obesityAnswers =
            valueForTagField(tag: 100) + "," +
            valueForTagField(tag: 101) + "," +
            valueForTagField(tag: 102) + "," +
            valueForTagField(tag: 103) + "," +
            valueForTagField(tag: 104) + "," +
            valueForTagField(tag: 105) + "," +
            valueForTagField(tag: 106) + "," +
            valueForTagRadios() + "," +
            valueForSmokingRadios() + "," +
            valueForTagField(tag: 109) + "," +
            valueForTagField(tag: 110) + ","
            
        StorageUtil.updatePropStringFor(key: "obesity-answers", value: obesityAnswers)
        
        ObesityHomeController.LOAD_INTERSTITIAL = true
        
        dismiss(animated: true, completion: nil)
    }
}
