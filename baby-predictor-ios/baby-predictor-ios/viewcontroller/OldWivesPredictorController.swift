
import UIKit

class OldWivesPredictorController : BaseViewController {
    var questionTitleLabelWidth = CGFloat(300)
    var sview: UIScrollView!
    var resultsButton: UIMaterialButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundPlain()
        buildHeaderSection()
        buildContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !checkAllSelected() {
            resultsButton.disable()
        }
    }
    
    func buildSelectionMap(str: String) -> [[Bool]] {
        if str == "" {
            return [[Bool]]()
        }
        var selections = [[Bool]]()
        let rowsArr = str.split(separator: "$")
        
        for row in rowsArr {
            var boolRow = [Bool]()
            let cols = row.split(separator: ",")
            for col in cols {
                if col == "T" {
                    boolRow.append(true)
                } else {
                    boolRow.append(false)
                }
            }
            selections.append(boolRow)
        }
        
        return selections
    }
    
    func buildContent() {
        var selections = buildSelectionMap(str: StorageUtil.getPropFor(key: "oldwives-selections"))
        
        sview = UIScrollView(frame: CGRect(x: 0, y: WidgetUtil.statusBarHeight+44, width: self.view.frame.width, height: self.view.frame.height-WidgetUtil.statusBarHeight+44))
        
        var y = WidgetUtil.statusBarHeight
        let x = self.view.frame.width/2 - 150
        
        let title = WidgetUtil.createImage(x, y: y, width: 300, height: 75, imageName: "oldwivestales_title_center.png")
        
        sview.addSubview(title)
        
        y += 100
        
        for i in 0..<questions.count {
            let questionTitle = UILabel(frame: CGRect(x: 16, y: y, width: questionTitleLabelWidth, height: 30))
            questionTitle.text = questions[i]
            questionTitle.textColor = UIColor.white
            questionTitle.backgroundColor = UIColor.clear
            questionTitle.font = UIFont(name: "AvenirNext-Bold", size: 16)
            questionTitle.lineBreakMode = .byWordWrapping
            sview.addSubview(questionTitle)
            
            let size = questionTitle.text!.size(withAttributes: [
                NSAttributedString.Key.font: questionTitle.font
                ])
            if (size.width > questionTitle.bounds.size.width) {
                let labelWidth = size.width
                let lines = Int(ceil(labelWidth/questionTitleLabelWidth))
                questionTitle.numberOfLines = lines
                questionTitle.frame.size.height = CGFloat(lines) * questionTitle.frame.size.height
                y += questionTitle.frame.size.height - 30
            }
            
            for k in 0..<answers[i].count {
                if k == 0 {
                    y = y + 42
                } else {
                    y = y + 36
                }
                let button = UIButton(type: .custom)
                button.frame = CGRect(x: 0, y: y, width: 300, height: 23)
                button.titleLabel?.lineBreakMode = NSLineBreakMode(rawValue: 0)!
                button.setTitle(answers[i][k], for: .normal)
                button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 14)
                button.setImage(UIImage(named: "radio.png"), for: .normal)
                button.setImage(UIImage(named: "radio.png"), for: .highlighted)
                button.setImage(UIImage(named: "radio_selected.png"), for: .selected)
                button.imageView?.contentMode = .scaleAspectFit
                button.contentHorizontalAlignment = .left
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -52, bottom: 0, right: 0)
                button.adjustsImageWhenHighlighted = false
                if i == 0 {
                    button.tag = k + 1
                } else {
                    button.tag = (i * 10) + k
                }
                if selections.count > 0 && selections[i][k] == true {
                    button.isSelected = true
                }
                button.isUserInteractionEnabled = true
                let buttonsGesture = UITapGestureRecognizer(target: self, action: #selector(selectButton(_:)))
                button.addGestureRecognizer(buttonsGesture)
                sview.addSubview(button)
            }
            
            y = y + 45
        }
        
        y += 21
        resultsButton = UIMaterialButton(frame: CGRect(x: x+25, y: y, width: 250, height: 41), text: "Get Results!", color: ColorsUtil.RGBToUIColor(red: 144, green: 202, blue: 249), target: self, action: #selector(getResults))
        
        sview.addSubview(resultsButton)
        y += 190
        
        sview.contentSize = CGSize(width: self.view.frame.width, height: y)
        self.view.addSubview(sview)
    }
    
    func calculateLineSplitIndex(label: UILabel, maxWidth: CGFloat) -> Int {
        let size = label.text!.size(withAttributes: [
            NSAttributedString.Key.font: label.font
            ])
        
        while size.width < label.bounds.size.width {
            
        }
        
        return 1
    }
    
    func buttonClick(_ sender: Any?) {
        //        let tag = (sender as? UIButton)!.tag
        //
        //        let index = findQuestion(tag)
        //        var selectedValue: String? = nil
        //
        //        if index != -1 {
        //            for i in 0..<questionTags[index].count {
        //                if (questionTags[index][i] != tag) {
        //                    let updateButton = view.viewWithTag(questionTags[index][i]) as? UIButton
        //                    updateButton?.isSelected = false
        //                    updateButton?.setImage(UIImage(named: "radio_button_normal.png"), for: .normal)
        //                    updateButton?.setImage(UIImage(named: "radio_button_highlight.png"), for: .highlighted)
        //                } else {
        //                    selectedValue = answersCodes[index][i] as? String
        //                }
        //            }
        //        }
        //
        //        (sender as? UIButton)?.isSelected = true
        //        (sender as? UIButton)?.setImage(UIImage(named: "radio_button_highlight_selected.png"), for: .normal)
        
        //        deleteValue(inDB: index)
        //        setValueInDB(index, answer: selectedValue)
    }
    
    func findQuestion(_ tag: Int) -> Int {
        for i in 0..<questionTags.count {
            for k in 0..<questionTags[i].count {
                if (questionTags[i][k] == tag) {
                    return i
                }
            }
        }
        
        return -1
    }
    
    func selectRadioButton(_ questionId: Int, answer: String?) {
        let index = getItemIndex(questionId, answer: answer)
        
        let button = view.viewWithTag(questionTags[questionId][index]) as? UIButton
        button?.isSelected = true
        button?.setImage(UIImage(named: "radio_button_highlight_selected.png"), for: .normal)
    }
    
    func getItemIndex(_ questionId: Int, answer: String?) -> Int {
        for i in 0..<answersCodes[questionId].count {
            if (answersCodes[questionId][i] == answer) {
                return i
            }
        }
        
        return -1
    }
    
    func checkAllSelected() -> Bool {
        for rows in questionTags {
            var optionSelected = false
            for col in rows {
                if (view.viewWithTag(col) as! UIButton).isSelected == true {
                    optionSelected = true
                }
            }
            if !optionSelected {
                return false
            }
        }
        
        return true
    }
    
    @objc func selectButton(_ gestureRecognizer: UITapGestureRecognizer) {
        (gestureRecognizer.view as! UIButton).isSelected = !(gestureRecognizer.view as! UIButton).isSelected
        let arrayIndex = findQuestion(gestureRecognizer.view!.tag)
        for i in 0...questionTags[arrayIndex].count-1 {
            if questionTags[arrayIndex][i] != gestureRecognizer.view!.tag {
                (view.viewWithTag(questionTags[arrayIndex][i]) as! UIButton).isSelected = false
            }
        }
        if !checkAllSelected() {
            resultsButton.disable()
        } else {
            resultsButton.enable()
        }
    }
    
    @objc func getResults() {
        var answers = ""
        var selections = ""
        for i in 0...questionTags.count-1 {
            var selectedAnswer = "X"
            for j in 0...questionTags[i].count-1 {
                if (view.viewWithTag(questionTags[i][j]) as! UIButton).isSelected == true {
                    selectedAnswer = answersCodes[i][j]
                    selections += "T,"
                } else {
                    selections += "F,"
                }
            }
            selections += "$"
            answers += selectedAnswer + " "
        }
        StorageUtil.updatePropStringFor(key: "oldwives-answers", value: answers)
        StorageUtil.updatePropStringFor(key: "oldwives-selections", value: selections)
        
        GenderSelectController.LOAD_INTERSTITIAL = true
        
        dismiss(animated: true, completion: nil)
    }
    
    //Array declarations for questions
    
    let questions = ["What type of cravings have you experienced during pregnancy?",
                     "How are you carrying?",
                     "Have you experienced morning sickness early in pregnancy?",
                     "What is the baby\'s heart rate?",
                     "If you hang a ring over your belly (Ring test), does it:",
                     "Where are you carrying extra weight?",
                     "If a key is placed in front of you (Key test), do you pick it up by:",
                     "When you sleep, does your pillow face:",
                     "Has the baby\'s father gained weight during your pregnancy?",
                     "Has the hair on your legs grown faster since you became pregnant?",
                     "Are your feet colder than before you became pregnant?",
                     "Has the acne on your face increased since becoming pregnant?",
                     "Has your hair developed red highlights since becoming pregnant?"]
    
    let answers = [
        ["Sweet","Salty","No specific cravings"],
        ["High","Low"],
        ["Yes","No"],
        ["Above 140","Below 140","Don't know"],
        ["Move in a circle","Move in a straight line","Don't know"],
        ["In front","In hips and thighs","Don't know"],
        ["The narrow end","The thick end","Don't know"],
        ["North","South","Don't know"],
        ["Yes","No","Don't know"],
        ["Yes", "No"],
        ["Yes", "No"],
        ["Yes", "No"],
        ["Yes", "No"]]
    
    let answersCodes = [
        ["G", "B", "U"],
        ["G", "B"],
        ["G", "B"],
        ["G", "B", "U"],
        ["G", "B", "U"],
        ["B", "G", "U"],
        ["G", "B", "U"],
        ["B", "G", "U"],
        ["B", "U1", "U2"],
        ["B", "U"],
        ["B", "U"],
        ["G", "U"],
        ["G", "U"]]
    
    let questionTags = [
        [1,2,3],
        [10,11],
        [20,21],
        [30,31,32],
        [40,41,42],
        [50,51,52],
        [60,61,62],
        [70,71,72],
        [80,81,82],
        [90,91],
        [100,101],
        [110,111],
        [120,121]]
}

