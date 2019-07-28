//
//  PredictorUtil.swift
//  temp.babywho
//
//  Created by Sid Bhat on 7/12/19.
//  Copyright © 2019 tbd. All rights reserved.
//

import Foundation

class PredictorUtil {
    let chineseChart = [["G", "B", "G", "B", "G", "B", "B", "G", "B", "G", "B", "G", "B", "B", "B", "G", "B", "B", "G", "B", "G", "B", "G", "B", "G", "B", "B", "G"], ["B", "G", "B", "G", "B", "B", "G", "B", "G", "B", "G", "B", "G", "G", "G", "B", "G", "B", "B", "G", "B", "G", "B", "G", "B", "G", "B", "B"], ["G", "B", "G", "G", "B", "G", "B", "B", "B", "G", "B", "G", "G", "B", "B", "B", "B", "G", "B", "B", "G", "B", "G", "B", "G", "B", "G", "B"], ["B", "G", "B", "G", "G", "B", "B", "G", "G", "B", "G", "G", "G", "G", "G", "B", "G", "B", "G", "B", "B", "B", "B", "G", "B", "G", "B", "G"], ["B", "G", "B", "G", "B", "B", "G", "G", "G", "G", "G", "B", "G", "G", "G", "G", "G", "G", "B", "G", "B", "B", "G", "B", "G", "B", "B", "G"], ["B", "B", "B", "G", "G", "G", "B", "B", "B", "G", "G", "B", "G", "G", "G", "G", "G", "G", "G", "B", "G", "G", "B", "G", "B", "G", "B", "G"], ["B", "B", "B", "G", "G", "B", "B", "G", "G", "B", "B", "B", "G", "G", "G", "G", "G", "G", "G", "G", "B", "G", "B", "B", "G", "B", "G", "B"], ["B", "B", "B", "G", "B", "G", "G", "B", "B", "B", "B", "B", "G", "G", "G", "B", "G", "B", "G", "B", "G", "B", "G", "B", "B", "G", "B", "G"], ["B", "B", "B", "G", "G", "B", "G", "B", "G", "B", "B", "B", "G", "G", "G", "G", "G", "G", "B", "G", "B", "G", "B", "G", "B", "B", "G", "B"], ["B", "B", "G", "G", "G", "B", "G", "B", "G", "B", "B", "G", "G", "G", "G", "G", "G", "G", "B", "B", "G", "B", "G", "B", "G", "B", "B", "G"], ["B", "G", "B", "G", "G", "B", "G", "B", "G", "G", "G", "G", "B", "G", "G", "G", "B", "B", "B", "G", "B", "G", "B", "G", "B", "B", "G", "B"], ["B", "G", "B", "G", "G", "G", "G", "B", "G", "B", "G", "G", "B", "B", "B", "B", "B", "B", "B", "B", "G", "G", "G", "B", "G", "B", "G", "B"]]
    
    func calculateChinese(conceptionDate: String, dueDate: String, birthDate: String) -> String {
        if (birthDate == "") || ((dueDate == "") && (conceptionDate == "")) {
            return "U"
        }
        
        var conceptionMonth = -1
        var conceptionYear = -1
        if (conceptionDate != "") {
            let lunarCalendar = LunarCalendar()
            lunarCalendar.load(with: formatShortDateFromString(datestr: conceptionDate))
            lunarCalendar.initializeValue()
            conceptionMonth = Int(lunarCalendar.getLunarMonth())
            conceptionYear = Int(lunarCalendar.getLunarYear())
        } else {
            let lunarCalendar = LunarCalendar()
            var tempDate = formatDateFromString(datestr: dueDate)
            tempDate = Calendar.current.date(byAdding: .month, value: -9, to: tempDate)!
            
            lunarCalendar.load(with: tempDate)
            lunarCalendar.initializeValue()
            conceptionMonth = Int(lunarCalendar.getLunarMonth()) - 1
            conceptionYear = Int(lunarCalendar.getLunarYear())
        }
        
        let lunarBirthCalendar = LunarCalendar()
        let tempDate = formatDateFromString(datestr: birthDate)
        lunarBirthCalendar.load(with: tempDate)
        lunarBirthCalendar.initializeValue()
        let bornYear = lunarBirthCalendar.getLunarYear()
        let age = calculateLunarAge(bornYear: Int(bornYear), conceptionYear: conceptionYear)
        let ageIndex = age - 18
        
        if (ageIndex < 0 || ageIndex > 27) || (conceptionMonth < 0 || conceptionMonth > 11) {
            return "U"
        }
        
        return chineseChart[conceptionMonth][ageIndex]
    }
    
    func calculateLunarAge(bornYear: Int, conceptionYear: Int) -> Int {
        return conceptionYear - bornYear + 1;
    }
    
    func formatShortDateFromString(datestr: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US_en")
        formatter.dateStyle = .short
        return formatter.date(from: datestr)!
    }
    
    func formatDateFromString(datestr: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US_en")
        formatter.dateStyle = .short
        return formatter.date(from: datestr)!
    }
}

