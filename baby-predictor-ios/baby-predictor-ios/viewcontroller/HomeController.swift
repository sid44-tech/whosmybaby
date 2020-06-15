//
//  HomeController.swift
//  whosmybaby
//
//  Created by Sid Bhat on 9/16/18.
//  Copyright © 2018 AppGenomix. All rights reserved.
//

import UIKit

class HomeController : BaseViewController {
    @IBOutlet weak var appearanceButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var mateButton: UIButton!
    @IBOutlet weak var obesityButton: UIButton!
    
    var imageSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = ColorsUtil.RGBToUIColor(red: 144, green: 202, blue: 249)
        
        imageSize = (self.view.frame.width * CGFloat(2)) / CGFloat(5)
        let centerX = (self.view.frame.width / 2)
        let leftColumnX = centerX - (centerX / 2) - (imageSize / 2)
        let rightColumnX = centerX + ((centerX / 2) - (imageSize / 2))
        let titleX = centerX - 140
        let cardHeight = 30 + imageSize
        var y = (self.view.frame.height / 2) - cardHeight + 24
        let titleY = y - 100
        
        let titleImage = WidgetUtil.createImage(titleX, y: titleY, width: 280, height: 70, imageName: "whosmybaby_title.png")
        self.view.addSubview(titleImage)
        
        buildTopic(x: leftColumnX, y: y, title: "gender_title.png", image: "gender_image.png", enabled: true, action: #selector(self.openGender(_:)))
        buildTopic(x: rightColumnX, y: y, title: "appearance_title.png", image: "appearance_image.png", enabled: false, action: #selector(self.openAppearance(_:)))
        
        y = (self.view.frame.height / 2) + 48
        
        buildTopic(x: leftColumnX, y: y, title: "obesity_title.png", image: "obesity_image.png", enabled: true, action: #selector(self.openObesity(_:)))
        buildTopic(x: rightColumnX, y: y, title: "mate_title.png", image: "mate_image.png", enabled: false, action: #selector(self.openMate(_:)))
    }
    
    func buildTopic(x: CGFloat, y: CGFloat, title: String, image: String, enabled: Bool, action: Selector) {
        let appearanceTitle = WidgetUtil.createImage(x, y: y, width: imageSize, height: 30, imageName: title)
        self.view.addSubview(appearanceTitle)
        
        let predictorImage = WidgetUtil.createImage(x, y: y + 40, width: imageSize, height: imageSize, imageName: image)
        predictorImage.layer.cornerRadius = 3.0
        predictorImage.layer.borderWidth = 1
        
        predictorImage.layer.masksToBounds = false
        predictorImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        predictorImage.layer.shadowOpacity = 0.99
        predictorImage.layer.shadowRadius = CGFloat(8)
        
        predictorImage.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        predictorImage.layer.shadowColor = UIColor.black.cgColor
        
        self.view.addSubview(predictorImage)
        
        if enabled {
            predictorImage.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: action)
            predictorImage.addGestureRecognizer(gesture)
        } else {
            let comingSoonImage = WidgetUtil.createImage(x, y: y + 40, width: imageSize, height: imageSize, imageName: "coming_soon.png")
            self.view.addSubview(comingSoonImage)
        }
    }
    
    @objc func openGender(_ gestureRecognizer: UITapGestureRecognizer) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "GenderSelectController") as! GenderSelectController
        view.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
    
    @objc func openObesity(_ gestureRecognizer: UITapGestureRecognizer) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ObesityHomeController") as! ObesityHomeController
        view.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
    
    @objc func openAppearance(_ gestureRecognizer: UITapGestureRecognizer) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "AppearancePredictorController") as! AppearancePredictorController
        view.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
    
    @objc func openMate(_ gestureRecognizer: UITapGestureRecognizer) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "MatePredictorController") as! MatePredictorController
        view.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
}

