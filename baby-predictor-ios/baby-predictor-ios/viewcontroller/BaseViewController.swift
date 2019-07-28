

import UIKit
//import GoogleMobileAds

class BaseViewController: UIViewController {
    var back: UIImageView!
    var logo: UIImageView!
    //var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setBackgroundQuestions() {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        let startColor = ColorsUtil.RGBToUIColor(red: 122, green: 60, blue: 113).cgColor
        let endColor = ColorsUtil.RGBToUIColor(red: 188, green: 118, blue: 177).cgColor
        gradient.colors = [startColor, endColor]
        
        view.layer.insertSublayer(gradient, at: 0)
        
        let patternView = UIView(frame: self.view.frame)
        patternView.backgroundColor = UIColor(patternImage: UIImage(named: "question_bg.png")!)
        self.view.addSubview(patternView)
    }
    
    func setBackgroundPlain() {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        let startColor = ColorsUtil.RGBToUIColor(red: 122, green: 60, blue: 113).cgColor
        let endColor = ColorsUtil.RGBToUIColor(red: 188, green: 118, blue: 177).cgColor
        gradient.colors = [startColor, endColor]
        
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func buildHeaderSection() {
        let barHeight = WidgetUtil.statusBarHeight + 44
        let bar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: barHeight))
        bar.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.addSubview(bar)
        
        back = UIImageView(image: UIImage(named: "back_icon.png"))
        back.frame.origin.x = 16
        back.frame.origin.y = WidgetUtil.backY
        back.frame.size = CGSize(width: 34, height: 34)
        back.isUserInteractionEnabled = true
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.goBack))
        back.addGestureRecognizer(backGesture)
        bar.addSubview(back)
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil);
    }
    
    //    func goHome() {
    //        UIView.animate(withDuration: UINavigationDrawer.ANIMATION_DURATION, animations: {
    //            self.drawer!.frame.origin.x = 0 - self.parent!.view.frame.width
    //        }, completion: {(finished:Bool) in
    //            self.drawer?.removeFromSuperview()
    //            _ = self.navigationController?.popToRootViewController(animated: true)
    //        }
    //        )
    //    }
    
    
    //    func addBannerViewToView(_ bannerView: GADBannerView) {
    //        bannerView.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(bannerView)
    //        view.addConstraints(
    //            [NSLayoutConstraint(item: bannerView,
    //                                attribute: .bottom,
    //                                relatedBy: .equal,
    //                                toItem: bottomLayoutGuide,
    //                                attribute: .top,
    //                                multiplier: 1,
    //                                constant: 0),
    //             NSLayoutConstraint(item: bannerView,
    //                                attribute: .centerX,
    //                                relatedBy: .equal,
    //                                toItem: view,
    //                                attribute: .centerX,
    //                                multiplier: 1,
    //                                constant: 0)
    //            ])
    //    }
    
    //    func setupBannerAd(adUnitId: String) {
    //        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
    //        bannerView.adUnitID = adUnitId
    //        bannerView.rootViewController = self
    //    }
    //
    //    func displayBannerAd() {
    //        if bannerView != nil {
    //            addBannerViewToView(bannerView)
    //            bannerView.load(GADRequest())
    //        }
    //    }
}

