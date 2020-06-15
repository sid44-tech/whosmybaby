
import UIKit
import GoogleMobileAds

class ObesityHomeController : BaseViewController, GADInterstitialDelegate {
    static var LOAD_INTERSTITIAL = false
    
    var responseMessages = [100: "", //mothers height feet
    101: "", //mothers height inches
    102: "", //mothers weight
    103: "", //fathers height feet
    104: "", //fathers height inches
    105: "", //fathers weight lbs
    106: "", //number of people in house
    107: "", //mothers profession
    108: "", //smoke during pregnancy?
    109: "", //baby birth weight pounds
    110: ""] //baby birth weight ounces
    
    var interstitial: GADInterstitial!
    
    var percent = ""
    var titleView: UIImageView!
    var riskLabel: UILabel!
    var imageButton: UIImageView!
    var percentLabel: UILabel!
    var infoButton: UIImageView!
 
    override func viewDidLoad() {
        interstitial = createAndLoadInterstitial()
        
        super.viewDidLoad()
        
        setBackgroundQuestions()
        buildHeaderSection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (ObesityHomeController.LOAD_INTERSTITIAL) {
            ObesityHomeController.LOAD_INTERSTITIAL = false

            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
        
        if titleView != nil {
            titleView.removeFromSuperview()
        }
        if riskLabel != nil {
            riskLabel.removeFromSuperview()
        }
        if imageButton != nil {
            imageButton.removeFromSuperview()
        }
        if percentLabel != nil {
            percentLabel.removeFromSuperview()
        }
        if infoButton != nil {
            infoButton.removeFromSuperview()
        }
        
        let rawValues = StorageUtil.getPropFor(key: "obesity-answers")
        if (rawValues != "") {
            parseAnswers(rawValues: rawValues)
            percent = calculatePercent()
        }
        buildContent()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitialInner = GADInterstitial(adUnitID: WidgetUtil.INTERSTITIAL_AD_ID)
        interstitialInner.delegate = self
        interstitialInner.load(GADRequest())
        return interstitialInner
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
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
    
    func calculatePercent() -> String {
        return ObesityCalculator.calculateObesityPercentage("0", maternalHeight1: responseMessages[100], maternalHeight2: responseMessages[101], maternalWeight: responseMessages[102], paternalHeight1: responseMessages[103], paternalHeight2: responseMessages[104], paternalWeight: responseMessages[105], householdMembersIn: responseMessages[106], maternalOccupationIn: responseMessages[107], gestationalSmokingIn: responseMessages[108], birthWeight1In: responseMessages[109], birthWeight2In: responseMessages[110])
    }
    
    func buildContent() {
        var y = WidgetUtil.statusBarHeight + 78
        let imageSize = CGFloat(250)
        let x = self.view.frame.width/2 - 150
        let imageX = self.view.frame.width/2 - imageSize/2
        
        titleView = WidgetUtil.createImage(x, y: y, width: 300, height: 75, imageName: "obesity_home_title.png")
        self.view.addSubview(titleView)
        y += 125
        
        if (percent != "") {
            riskLabel = UILabel(frame: CGRect(x: imageX, y: y, width: imageSize, height: 30))
            riskLabel.text = "My Baby's Obesity Risk"
            riskLabel.textColor = UIColor.white
            riskLabel.backgroundColor = UIColor.clear
            riskLabel.textAlignment = .center
            riskLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
            self.view.addSubview(riskLabel)
        }
        
        y += 42

        var imageName = "scale_image_touch.png"
        if (percent != "") {
            imageName = "scale_image_base.png"
        }
        imageButton = WidgetUtil.createImage(imageX, y: y, width: imageSize, height: imageSize, imageName: imageName)
        imageButton.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openQuestions(_:)))
        imageButton.addGestureRecognizer(gesture)
        self.view.addSubview(imageButton)
        
        if (percent != "") {
            percentLabel = UILabel(frame: CGRect(x: imageX, y: y+114, width: imageSize, height: 50))
            percentLabel.text = percent
            percentLabel.textColor = UIColor.white
            percentLabel.backgroundColor = UIColor.clear
            percentLabel.textAlignment = .center
            percentLabel.font = UIFont(name: "AvenirNext-Bold", size: 28)
            self.view.addSubview(percentLabel)
            
            y += 275
            
            infoButton = WidgetUtil.createImage(imageX, y: y, width: 250, height: 25, imageName: "obesity_home_info.png")
            infoButton.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openInfo(_:)))
            infoButton.addGestureRecognizer(gesture)
            self.view.addSubview(infoButton)
        }
    }
    
    @objc func openQuestions(_ gestureRecognizer: UITapGestureRecognizer) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ObesityQuestionsController") as! ObesityQuestionsController
        view.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
    
    @objc func openInfo(_ gestureRecognizer: UITapGestureRecognizer) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ObesityInfoController") as! ObesityInfoController
        view.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
}
