//
//  pinPopsicle.swift - Holds all the data a popsicle needs to have. It's simply a map annotation but with an extra structure holding all the information.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 11/14/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit
import MapKit

enum PopsicleCategory: String {
    
    case Education
    case Food
    case Social
    case Sports
    case Shows
    case Default
    
}

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
    
    var eventPopsicle: UIImage
    
    // MARK: change
    // new features
    var whosGoing: [String]
    
}

class pinPopsicle: MKPointAnnotation {
    
    var popsicleData: pinData!
    
}
