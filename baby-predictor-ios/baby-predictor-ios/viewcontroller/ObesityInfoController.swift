
import UIKit

class ObesityInfoController : BaseViewController {

    let INFO_TEXT = "The Obesity Predictor is based on specific risk factors that correlate to a child’s obesity risk.  It is important to remember that even though this predictor may or may not show a high risk of obesity for your child, it is not a definite outcome.  You can greatly decrease the chances of your child being obese by promoting a lifestyle which includes a healthy diet and daily exercise. This predictor is based on a study conducted by researchers over a twenty-five year period.  The study indicated that genetics played a very small role in the potential for a child being obese; moreover, it showed that environmental factors played a much larger role.  More information about the study on which this predictor is based on can be found at the link below:"
    
    let LINK_TEXT = "PLOS ONE, 2012"
    
    let LINK = "http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0049919"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundPlain()
        buildHeaderSection()
        buildContent()
    }
    
    func buildContent() {
        var y = CGFloat(WidgetUtil.statusBarHeight + 16)
        
        let infoText = UILabel(frame: CGRect(x: 16, y: y, width: self.view.frame.width-32, height: 30))
        infoText.text = INFO_TEXT
        infoText.textColor = UIColor.white
        infoText.backgroundColor = UIColor.clear
        infoText.font = UIFont(name: "AvenirLight", size: 12)
        infoText.lineBreakMode = .byWordWrapping
        self.view.addSubview(infoText)
        
        let size = infoText.text!.size(withAttributes: [
            NSAttributedString.Key.font: infoText.font!
            ])
        if (size.width > infoText.bounds.size.width) {
            let labelWidth = size.width
            let lines = Int(ceil(labelWidth/(self.view.frame.width-32))) + 1
            infoText.numberOfLines = lines
            infoText.frame.size.height = CGFloat(lines) * infoText.frame.size.height
            y += infoText.frame.size.height - 30
        }
        
        y -= 16
        
        let link = UILabel(frame: CGRect(x: 1, y: y, width: 250, height: 30))
        link.text = "Original " + LINK_TEXT + " Paper"
        link.textColor = UIColor.blue
        link.backgroundColor = UIColor.clear
        link.textAlignment = .center
        link.font = UIFont(name: "AvenirNext-Bold", size: 14)
        link.isUserInteractionEnabled = true
        self.view.addSubview(link)
        
        let linkImageView = UIImageView(frame: CGRect(x: 240, y: y+3, width: 21, height: 21))
        linkImageView.image = UIImage(named: "open_link.png")
        linkImageView.isUserInteractionEnabled = true
        self.view.addSubview(linkImageView);

        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(self.openLink))
        link.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.openLink))
        linkImageView.addGestureRecognizer(gesture2)
    }
    
    @objc func openLink() {
        UIApplication.shared.open(URL(string: LINK)!)
    }
}
