//
//  Extensions.swift - extensions of several UIKit classes for easier access later in other parts of the project.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 1/14/20.
//  Copyright © 2020 PoppinREPO. All rights reserved.
//∫

import UIKit
import SFSafeSymbols // Allows for easy access of Apple Symbols

extension UIColor {
    
    static let menuCREAM = UIColor(named: "menuCREAM")!
    static let createEventPINK = UIColor(named: "createEventPINK")!
    static let mainNAVYBLUE = UIColor(named: "mainNAVYBLUE")!
    static let educationRED = UIColor(named: "educationRED")!
    static let foodORANGE = UIColor(named: "foodORANGE")!
    static let socialYELLOW = UIColor(named: "socialYELLOW")!
    static let sportsGREEN = UIColor(named: "sportsGREEN")!
    static let showsPURPLE = UIColor(named: "showsPURPLE")!
    
    static func UIColorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
        
    }
    
}

extension UIImage {
    
    static let defaultPopsicleIcon = UIImage(named: "defaultCategoryButton")!
    static let educationPopsicleIcon = UIImage(named: "educationButton")!
    static let foodPopsicleIcon = UIImage(named: "foodButton")!
    static let socialPopsicleIcon = UIImage(named: "socialButton")!
    static let sportsPopsicleIcon = UIImage(named: "sportsButton")!
    static let showsPopsicleIcon = UIImage(named: "showsButton")!
    static let goldPopsicleIcon = UIImage(named: "goldButton")!
    static let rainbowPopsicleIcon = UIImage(named: "popsicleGroupButton")!
    
}

extension UIView {
    
    public func addShadowAndRoundCorners(cornerRadius: CGFloat? = nil, shadowColor: UIColor? = nil, shadowOffset: CGSize? = nil, shadowOpacity: Float? = nil, shadowRadius: CGFloat? = nil, topRightMask: Bool = true, topLeftMask: Bool = true, bottomRightMask: Bool = true, bottomLeftMask: Bool = true) {
            
        layer.masksToBounds = false
        layer.cornerRadius = 8.0
        layer.cornerCurve = .continuous
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0) // Shifts shadow
        layer.shadowOpacity = 0.2 // Higher value means more opaque
        layer.shadowRadius = 2 // Higher value means more blurry
        var maskedCorners = CACornerMask()
        
        if let cr = cornerRadius { layer.cornerRadius = cr }
        if let sc = shadowColor { layer.shadowColor = sc.cgColor }
        if let sof = shadowOffset { layer.shadowOffset = sof }
        if let sop = shadowOpacity { layer.shadowOpacity = sop }
        if let sr = shadowRadius { layer.shadowRadius = sr }
        
        if topRightMask { maskedCorners.insert(.layerMaxXMinYCorner) }
        if topLeftMask { maskedCorners.insert(.layerMinXMinYCorner) }
        if bottomRightMask { maskedCorners.insert(.layerMaxXMaxYCorner) }
        if bottomLeftMask { maskedCorners.insert(.layerMinXMaxYCorner) }
        if !maskedCorners.isEmpty { layer.maskedCorners = maskedCorners }
        
    }
    
    public func getCornerRadiusFit(percentage: CGFloat) -> CGFloat {
        
        return (CGFloat(abs(percentage))/100)*0.5*min(frame.height, frame.width)
        
    }
    
}

extension CGFloat {
    
    public static func getWidthFitSize (minSize: CGFloat, maxSize: CGFloat) -> CGFloat {
        
        return CGSize.currentIphoneSize.width*(((minSize/CGSize.smallestIphoneSize.width) + (maxSize/CGSize.largestIphoneSize.width))/2)
        
    }
    
    public static func getHeightFitSize (minSize: CGFloat, maxSize: CGFloat) -> CGFloat {
        
        return CGSize.currentIphoneSize.height*(((minSize/CGSize.smallestIphoneSize.height) + (maxSize/CGSize.largestIphoneSize.height))/2)
        
    }
    
    public static func getPercentageWidth(percentage: CGFloat) -> CGFloat {
        
        return (CGFloat(abs(percentage))/100)*CGSize.currentIphoneSize.width
        
    }
    
    public static func getPercentageHeight(percentage: CGFloat) -> CGFloat {
        
        return (CGFloat(abs(percentage))/100)*CGSize.currentIphoneSize.height
        
    }
    
    public static func getPercentageWidthFit(minPercentage: CGFloat, maxPercentage: CGFloat) -> CGFloat {
        
        return (getPercentageWidth(percentage: minPercentage) + getPercentageWidth(percentage: maxPercentage))/2
        
    }
    
    public static func getPercentageHeightFit(minPercentage: CGFloat, maxPercentage: CGFloat) -> CGFloat {
        
        return (getPercentageHeight(percentage: minPercentage) + getPercentageHeight(percentage: maxPercentage))/2
        
    }
    
}

extension CGSize {
    
    static let currentIphoneSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    static let smallestIphoneSize = CGSize(width: 320.0, height: 568.0) // Iphone SE
    static let largestIphoneSize = CGSize(width: 414.0, height: 896.0) // Iphone 11 Pro Max
    
    public static func getBestFitSize (minSize: CGSize, maxSize: CGSize) -> CGSize {
        
        let widthFit = CGFloat.getWidthFitSize(minSize: minSize.width, maxSize: maxSize.width)
        let heightFit = CGFloat.getHeightFitSize(minSize: minSize.height, maxSize: maxSize.height)
        
        return CGSize(width: widthFit, height: heightFit)
        
    }
    
    public static func getPercentageSize(percentage: CGFloat) -> CGSize {
        
        return CGSize(width: CGFloat.getPercentageWidth(percentage: percentage), height: CGFloat.getPercentageHeight(percentage: percentage))
        
    }
    
    public static func getPercentageBestFit(minPercentage: CGFloat, maxPercentage: CGFloat) -> CGSize {
        
        return CGSize(width: CGFloat.getPercentageWidthFit(minPercentage: minPercentage, maxPercentage: maxPercentage), height: CGFloat.getPercentageHeightFit(minPercentage: minPercentage, maxPercentage: maxPercentage))
        
    }
    
}

