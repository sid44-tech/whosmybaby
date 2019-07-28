//
//  GenderSelectController.swift
//  temp.babywho
//
//  Created by Sid Bhat on 11/25/18.
//  Copyright © 2018 tbd. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GenderSelectController : BaseViewController, GADInterstitialDelegate {
    static var LOAD_INTERSTITIAL = false
    
    var interstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = createAndLoadInterstitial()
        
        setBackgroundQuestions()
        buildHeaderSection()
        buildContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (GenderSelectController.LOAD_INTERSTITIAL) {
            GenderSelectController.LOAD_INTERSTITIAL = false

            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
        
        updateGenderPredictors()
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
    
    func buildContent() {
        var y = (self.view.frame.height / 2) - (345/2)
        buildButtonRow(y: y, labelImage: "chinese_title.png", revealImage: "icon_small.png", tag: 10, action: #selector(self.openChinese(_:)))
        y += 90
        buildButtonRow(y: y, labelImage: "mayan_title.png", revealImage: "icon_small.png", tag: 20, action: #selector(self.openMayan(_:)))
        y += 90
        buildButtonRow(y: y, labelImage: "statistical_title.png", revealImage: "icon_small.png", tag: 30, action: #selector(self.openStatistical(_:)))
        y += 90
        buildButtonRow(y: y, labelImage: "oldwivestales_title.png", revealImage: "icon_small.png", tag: 40, action: #selector(self.openOldwives(_:)))
    }
    
    func buildButtonRow(y: CGFloat, labelImage: String, revealImage: String, tag: Int, action: Selector?) {
        let width = (self.view.frame.width/2)
        let shift = CGFloat(40)
        let title = WidgetUtil.createImage(0 + shift, y: y, width: width, height: 75, imageName: labelImage)
        self.view.addSubview(title)
        let image = WidgetUtil.createImage(self.view.frame.width/2 + shift + 16, y: y, width: 75, height: 75, imageName: revealImage)
        image.tag = tag
        self.view.addSubview(image)
        
        title.isUserInteractionEnabled = true
        image.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: action)
        title.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action: action)
        image.addGestureRecognizer(gesture2)
    }
    
    func updateGenderPredictors() {
        let ageStr = StorageUtil.getPropFor(key: "mayan-age")
        let yearStr = StorageUtil.getPropFor(key: "mayan-year")
        
        var age = 0
        var year = 0
        if (ageStr != "") {
            age = Int(ageStr)!
        }
        if (yearStr != "") {
            year = Int(yearStr)!
        }
        
        let mayanPredictor = calculateMayan(conceptionAge: age, conceptionYear: year)
        if mayanPredictor == "U" {
            (self.view.viewWithTag(20) as! UIImageView).image = UIImage(named: "icon_small.png")
        } else if mayanPredictor == "G" {
            (self.view.viewWithTag(20) as! UIImageView).image = UIImage(named: "icon_small_girl.png")
        } else if mayanPredictor == "B" {
            (self.view.viewWithTag(20) as! UIImageView).image = UIImage(named: "icon_small_boy.png")
        }
        
        let chinesePredictor = calculateChinese()
        if chinesePredictor == "U" {
            (self.view.viewWithTag(10) as! UIImageView).image = UIImage(named: "icon_small.png")
        } else if chinesePredictor == "G" {
            (self.view.viewWithTag(10) as! UIImageView).image = UIImage(named: "icon_small_girl.png")
        } else if chinesePredictor == "B" {
            (self.view.viewWithTag(10) as! UIImageView).image = UIImage(named: "icon_small_boy.png")
        }
        
        let statisticalPredictor = calculateStatistical()
        if statisticalPredictor == "U" {
            (self.view.viewWithTag(30) as! UIImageView).image = UIImage(named: "icon_small.png")
        } else if statisticalPredictor == "G" {
            (self.view.viewWithTag(30) as! UIImageView).image = UIImage(named: "icon_small_girl.png")
        } else if statisticalPredictor == "B" {
            (self.view.viewWithTag(30) as! UIImageView).image = UIImage(named: "icon_small_boy.png")
        } else if statisticalPredictor == "C" {
            (self.view.viewWithTag(30) as! UIImageView).image = UIImage(named: "icon_small_too_close.png")
        }
        
        let oldwivesPredictor = calculateOldwives()
        if oldwivesPredictor == "U" {
            (self.view.viewWithTag(40) as! UIImageView).image = UIImage(named: "icon_small.png")
        } else if oldwivesPredictor == "G" {
            (self.view.viewWithTag(40) as! UIImageView).image = UIImage(named: "icon_small_girl.png")
        } else if oldwivesPredictor == "B" {
            (self.view.viewWithTag(40) as! UIImageView).image = UIImage(named: "icon_small_boy.png")
        } else if oldwivesPredictor == "C" {
            (self.view.viewWithTag(40) as! UIImageView).image = UIImage(named: "icon_small_too_close.png")
        }
    }
    
    @objc func openMayan(_ gestureRecognizer: UITapGestureRecognizer) {
        let mayanViewController = self.storyboard?.instantiateViewController(withIdentifier: "MayanPredictorController") as! MayanPredictorController
        mayanViewController.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        present(mayanViewController, animated: true, completion: nil)
    }
    
    @objc func openChinese(_ gestureRecognizer: UITapGestureRecognizer) {
        let chineseViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChinesePredictorController") as! ChinesePredictorController
        chineseViewController.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        present(chineseViewController, animated: true, completion: nil)
    }
    
    @objc func openStatistical(_ gestureRecognizer: UITapGestureRecognizer) {
        let statisticalViewController = self.storyboard?.instantiateViewController(withIdentifier: "StatisticalPredictorController") as! StatisticalPredictorController
        statisticalViewController.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        present(statisticalViewController, animated: true, completion: nil)
    }
    
    @objc func openOldwives(_ gestureRecognizer: UITapGestureRecognizer) {
        let oldwivesViewController = self.storyboard?.instantiateViewController(withIdentifier: "OldWivesPredictorController") as! OldWivesPredictorController
        oldwivesViewController.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve;
        present(oldwivesViewController, animated: true, completion: nil)
    }
    
    func calculateMayan(conceptionAge: Int, conceptionYear: Int) -> String! {
        if conceptionAge == 0 || conceptionYear == 0 {
            return "U"
        } else {
            var ageEven = false
            var yearEven = false
            if conceptionAge % 2 == 0 {
                ageEven = true
            }
            if conceptionYear % 2 == 0 {
                yearEven = true
            }
            
            if (ageEven && yearEven) || (!ageEven && !yearEven) {
                return "G"
            } else {
                return "B"
            }
        }
    }
    
    func calculateChinese() -> String {
        let conceptionDate = StorageUtil.getPropFor(key: "chinese-conception-date")
        let birthDate = StorageUtil.getPropFor(key: "chinese-birth-date")
        let selection = StorageUtil.getPropFor(key: "chinese-date-selection")
        
        if selection == "" {
            return "U"
        } else if selection == "0" {
            return PredictorUtil().calculateChinese(conceptionDate: conceptionDate, dueDate: "", birthDate: birthDate)
        } else {
            return PredictorUtil().calculateChinese(conceptionDate: "", dueDate: conceptionDate, birthDate: birthDate)
        }
    }
    
    func calculateStatistical() -> String {
        let str = StorageUtil.getPropFor(key: "statistical-answers")
        let answers = str.trimmingCharacters(in: [" "]).split(separator: " ")
        var boyCount = 0
        var girlCount = 0
        var totalCount = 0
        
        for answer in answers {
            totalCount += 1
            if answer == "B" {
                boyCount += 1
            } else if answer == "G" {
                girlCount += 1
            }
        }
        
        if (totalCount < 12) {
            return "U"
        } else if (boyCount > girlCount) {
            return "B"
        } else if (girlCount > boyCount) {
            return "G"
        } else if (girlCount == boyCount) {
            return "C"
        }
        
        return "U"
    }
    
    func calculateOldwives() -> String {
        let str = StorageUtil.getPropFor(key: "oldwives-answers")
        let answers = str.trimmingCharacters(in: [" "]).split(separator: " ")
        var boyCount = 0
        var girlCount = 0
        var totalCount = 0
        
        for answer in answers {
            totalCount += 1
            if answer == "B" {
                boyCount += 1
            } else if answer == "G" {
                girlCount += 1
            }
        }
        
        if (totalCount < 12) {
            return "U"
        } else if (boyCount > girlCount) {
            return "B"
        } else if (girlCount > boyCount) {
            return "G"
        } else if (girlCount == boyCount) {
            return "C"
        }
        
        return "U"
    }
}

