//
//  StorageUtil.swift
//  temp.babywho
//
//  Created by Sid Bhat on 7/10/19.
//  Copyright © 2019 tbd. All rights reserved.
//

import Foundation
import UIKit

class StorageUtil {
    static var deviceToken = ""
    static let PROPERTY_FILE = "opprops"
    
    static let PROP_SEPARATOR_VALUE: Character = "|"
    static let KEY_SEPARATOR_VALUE: Character = ":"
    static let FILTER_PROP_SEPARATOR_VALUE: Character = ","
    static let FILTER_KEY_SEPARATOR_VALUEL: Character = "#"
    
    static let DocumentDirURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let propsFileURL = DocumentDirURL.appendingPathComponent(PROPERTY_FILE)
    
    class func writeFile(_ propString: String?) {
        let writeString = propString!
        do {
            try writeString.write(to: propsFileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(propsFileURL), Error: " + error.localizedDescription)
        }
    }
    
    class func readFile() -> String? {
        var readString = ""
        do {
            readString = try String(contentsOfFile: propsFileURL.path, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error.localizedDescription)
            return ""
        }
        return readString
    }
    
    class func getPropFor(key: String) -> String {
        let str = readFile()
        let props = str!.split(separator: PROP_SEPARATOR_VALUE).map(String.init)
        
        for prop in props {
            let keyValue = prop.split(separator: KEY_SEPARATOR_VALUE).map(String.init)
            
            if keyValue[0] == key {
                if keyValue.count == 1 {
                    return ""
                } else {
                    return keyValue[1]
                }
            }
        }
        
        return ""
    }
    
    class func updatePropStringFor(key: String, value: String) {
        let str = readFile()
        var newprops = "";
        let props = str!.split(separator: PROP_SEPARATOR_VALUE).map(String.init)
        
        var propFound = false
        for prop in props {
            let keyValue = prop.split(separator: KEY_SEPARATOR_VALUE).map(String.init)
            if keyValue[0] == key {
                newprops += (key + String(KEY_SEPARATOR_VALUE) + value + String(PROP_SEPARATOR_VALUE))
                
                propFound = true
            } else {
                newprops += (prop + String(PROP_SEPARATOR_VALUE))
            }
        }
        
        if propFound == false {
            newprops += (key + String(KEY_SEPARATOR_VALUE) + value + String(PROP_SEPARATOR_VALUE))
        }
        
        writeFile(newprops)
    }
    
    class func clearPropertyFor(key: String) {
        let str = readFile()
        var newprops = "";
        let props = str!.split(separator: PROP_SEPARATOR_VALUE).map(String.init)
        
        for prop in props {
            let keyValue = prop.split(separator: KEY_SEPARATOR_VALUE).map(String.init)
            if keyValue[0] == key {
                newprops += (key + String(KEY_SEPARATOR_VALUE) + "" + String(PROP_SEPARATOR_VALUE))
            } else {
                newprops += (prop + String(PROP_SEPARATOR_VALUE))
            }
        }
        
        writeFile(newprops)
    }
}

