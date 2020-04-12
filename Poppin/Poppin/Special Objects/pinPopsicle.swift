//
//  pinPopsicle.swift - Holds all the data a popsicle needs to have. It's simply a map annotation but with an extra structure holding all the information.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 11/14/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit
import MapKit

struct pinData {
    
    var eventName: String
    
    var eventInfo: String
    
    var eventDate: String
    
    var eventDuration: String
    
    var eventCategory: String
    
    var eventCategoryDetails: String
    
    var eventSubcategory1: String
    
    var eventSubcategory1Details: String
    
    var eventSubcategory2: String
    
    var eventSubcategory2Details: String
    
    var eventLocation: CLLocationCoordinate2D
    
}

class pinPopsicle: MKPointAnnotation {
    
    var popsicleData: pinData!
    
    public func getPopsicleImage() -> UIImage {
        
        switch popsicleData.eventCategory {
        case "Education":
            return UIImage(named: "educationButton")!
        case "Food":
            return UIImage(named: "foodButton")!
        case "Social":
            return UIImage(named: "socialButton")!
        case "Sports":
            return UIImage(named: "sportsButton")!
        case "Shows":
            return UIImage(named: "showsButton")!
        default:
            return UIImage(named: "categoryButtonNP")!
        }
        
    }
    
    static func == (lhs: pinPopsicle, rhs: pinPopsicle) -> Bool {
        
        return lhs.popsicleData.eventName == rhs.popsicleData.eventName && lhs.popsicleData.eventInfo == rhs.popsicleData.eventInfo
            && lhs.popsicleData.eventDate == rhs.popsicleData.eventDate && lhs.popsicleData.eventDuration == rhs.popsicleData.eventDuration
            && lhs.popsicleData.eventCategory == rhs.popsicleData.eventCategory && lhs.popsicleData.eventCategoryDetails == rhs.popsicleData.eventCategoryDetails
            && lhs.popsicleData.eventSubcategory1 == rhs.popsicleData.eventSubcategory1 && lhs.popsicleData.eventSubcategory1Details == rhs.popsicleData.eventSubcategory1Details
            && lhs.popsicleData.eventSubcategory2 == rhs.popsicleData.eventSubcategory2 && lhs.popsicleData.eventSubcategory2Details == rhs.popsicleData.eventSubcategory2Details
            && lhs.popsicleData.eventLocation.latitude == rhs.popsicleData.eventLocation.latitude && lhs.popsicleData.eventLocation.longitude == rhs.popsicleData.eventLocation.longitude
            && lhs.popsicleData.eventLocation.latitude.isEqual(to: rhs.popsicleData.eventLocation.latitude) && lhs.popsicleData.eventLocation.longitude.isEqual(to: rhs.popsicleData.eventLocation.longitude)
        
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let popsicle = object as? pinPopsicle {
            
            return self.popsicleData.eventName == popsicle.popsicleData.eventName && self.popsicleData.eventInfo == popsicle.popsicleData.eventInfo
            && self.popsicleData.eventDate == popsicle.popsicleData.eventDate && self.popsicleData.eventDuration == popsicle.popsicleData.eventDuration
            && self.popsicleData.eventCategory == popsicle.popsicleData.eventCategory && self.popsicleData.eventCategoryDetails == popsicle.popsicleData.eventCategoryDetails
            && self.popsicleData.eventSubcategory1 == popsicle.popsicleData.eventSubcategory1 && self.popsicleData.eventSubcategory1Details == popsicle.popsicleData.eventSubcategory1Details
            && self.popsicleData.eventSubcategory2 == popsicle.popsicleData.eventSubcategory2 && self.popsicleData.eventSubcategory2Details == popsicle.popsicleData.eventSubcategory2Details
            && self.popsicleData.eventLocation.latitude.isEqual(to: popsicle.popsicleData.eventLocation.latitude) && self.popsicleData.eventLocation.longitude.isEqual(to: popsicle.popsicleData.eventLocation.longitude)
            
        } else {
            
            return false
            
        }
        
    }
    
}
