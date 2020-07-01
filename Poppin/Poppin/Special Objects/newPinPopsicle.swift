//
//  newPinPopsicle.swift
//  Poppin
//
//  Created by Abdulrahman Ayad on 6/29/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//


import UIKit
import MapKit

struct newPinData {
    
    var eventName: String
    
    var eventInfo: String
    
    var eventStartDate: String
    
    var eventEndDate: String
        
    var eventCategory: String
    
    var eventHashtags: String
    
    var eventLocation: CLLocationCoordinate2D
    
    var eventPopsicle: UIImage
    
    // MARK: change
    // new features
    var whosGoing: [String]
    
}

class newPinPopsicle: MKPointAnnotation {
    
    var popsicleData: newPinData!
    
}
