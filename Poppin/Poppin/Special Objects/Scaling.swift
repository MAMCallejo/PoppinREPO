//
//  Scaling.swift - Helps scale fonts and view across all phone sizes.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 4/20/20.
//  Copyright © 2020 Poppin Software. All rights reserved.
//

import UIKit

class Scaling: NSObject {
    
    public static let currentIphoneSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    private static let smallestIphoneSize = CGSize(width: 320.0, height: 568.0) // Iphone SE
    private static let largestIphoneSize = CGSize(width: 414.0, height: 896.0) // Iphone 11 Pro Max
    
    public static func getWidthFitSize (minSize: CGFloat, maxSize: CGFloat) -> CGFloat {
        
        return currentIphoneSize.width*(((minSize/smallestIphoneSize.width) + (maxSize/largestIphoneSize.width))/2)
        
    }
    
    public static func getHeightFitSize (minSize: CGFloat, maxSize: CGFloat) -> CGFloat {
        
        return currentIphoneSize.height*(((minSize/smallestIphoneSize.height) + (maxSize/largestIphoneSize.height))/2)
        
    }
    
    public static func getBestFitSize (minSize: CGSize, maxSize: CGSize) -> CGSize {
        
        let widthFit = getWidthFitSize(minSize: minSize.width, maxSize: maxSize.width)
        let heightFit = getHeightFitSize(minSize: minSize.height, maxSize: maxSize.height)
        
        return CGSize(width: widthFit, height: heightFit)
        
    }
    
    public static func getPercentageWidth(percentage: CGFloat) -> CGFloat {
        
        return (CGFloat(abs(percentage))/100)*currentIphoneSize.width
        
    }
    
    public static func getPercentageHeight(percentage: CGFloat) -> CGFloat {
        
        return (CGFloat(abs(percentage))/100)*currentIphoneSize.height
        
    }
    
    public static func getPercentageSize(percentage: CGFloat) -> CGSize {
        
        return CGSize(width: getPercentageWidth(percentage: percentage), height: getPercentageHeight(percentage: percentage))
        
    }
    
    public static func getPercentageWidthFit(minPercentage: CGFloat, maxPercentage: CGFloat) -> CGFloat {
        
        return (getPercentageWidth(percentage: minPercentage) + getPercentageWidth(percentage: maxPercentage))/2
        
    }
    
    public static func getPercentageHeightFit(minPercentage: CGFloat, maxPercentage: CGFloat) -> CGFloat {
        
        return (getPercentageHeight(percentage: minPercentage) + getPercentageHeight(percentage: maxPercentage))/2
        
    }
    
    public static func getPercentageBestFit(minPercentage: CGFloat, maxPercentage: CGFloat) -> CGSize {
        
        return CGSize(width: getPercentageWidthFit(minPercentage: minPercentage, maxPercentage: maxPercentage), height: getPercentageHeightFit(minPercentage: minPercentage, maxPercentage: maxPercentage))
        
    }
    
}
