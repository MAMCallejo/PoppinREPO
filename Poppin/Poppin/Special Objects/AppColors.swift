//
//  AppColors.swift - extension of the UIColor class that implements the main app colors as well as the UIGetColorFromHEX
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 1/14/20.
//  Copyright © 2020 PoppinREPO. All rights reserved.
//∫

import UIKit

extension UIColor {
    
    static let menuCREAM = UIColor(named: "menuCREAM")
    
    static let createEventPINK = UIColor(named: "createEventPINK")
    
    static let mainNAVYBLUE = UIColor(named: "mainNAVYBLUE")
    
    static let educationRED = UIColor(named: "educationRED")
    
    static let foodORANGE = UIColor(named: "foodORANGE")
    
    static let socialYELLOW = UIColor(named: "socialYELLOW")
    
    static let sportsGREEN = UIColor(named: "sportsGREEN")
    
    static let showsPURPLE = UIColor(named: "showsPURPLE")
    
    static func UIColorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
        
    }
    
}

