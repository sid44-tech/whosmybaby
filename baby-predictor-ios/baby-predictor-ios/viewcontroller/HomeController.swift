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
        
        buildTopic(x: leftColumnX, y: y, title: "gender_title.png", image: "gender_image.png", enabled: true)
        buildTopic(x: rightColumnX, y: y, title: "appearance_title.png", image: "appearance_image.png", enabled: false)
        
        y = (self.view.frame.height / 2) + 48
        
        buildTopic(x: leftColumnX, y: y, title: "obesity_title.png", image: "obesity_image.png", enabled: false)
        buildTopic(x: rightColumnX, y: y, title: "mate_title.png", image: "mate_image.png", enabled: false)
    }
    
    func buildTopic(x: CGFloat, y: CGFloat, title: String, image: String, enabled: Bool) {
        let appearanceTitle = WidgetUtil.createImage(x, y: y, width: imageSize, height: 30, imageName: title)
        self.view.addSubview(appearanceTitle)
        
        let appearanceImage = WidgetUtil.createImage(x, y: y + 40, width: imageSize, height: imageSize, imageName: image)
        appearanceImage.layer.cornerRadius = 3.0
        appearanceImage.layer.borderWidth = 1
        
        appearanceImage.layer.masksToBounds = false
        appearanceImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        appearanceImage.layer.shadowOpacity = 0.99
        appearanceImage.layer.shadowRadius = CGFloat(8)
        
        appearanceImage.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        appearanceImage.layer.shadowColor = UIColor.black.cgColor
        
        self.view.addSubview(appearanceImage)
        
        if enabled {
            appearanceImage.isUserInteractionEnabled = true
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openGender(_:)))
            appearanceImage.addGestureRecognizer(gesture)
        } else {
            let comingSoonImage = WidgetUtil.createImage(x, y: y + 40, width: imageSize, height: imageSize, imageName: "coming_soon.png")
            self.view.addSubview(comingSoonImage)
        }
    }
    
    @objc func openGender(_ gestureRecognizer: UITapGestureRecognizer) {
        //        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //        let mapViewControllerObj = storyBoard.instantiateViewController(withIdentifier: "GenderSelectController") as! GenderSelectController
        //        self.navigationController?.pushViewController(mapViewControllerObj, animated: true)
        //
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "GenderSelectController") as! GenderSelectController
        homeView.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        present(homeView, animated: true, completion: nil)
    }
}

