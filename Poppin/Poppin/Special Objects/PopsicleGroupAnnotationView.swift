//
//  PopsicleGroupAnnotationView.swift - annotation view that represents a group of popsicles that are close together.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 12/24/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import MapKit

/// - Tag: PopsicleGroupAnnotationView

class PopsicleGroupAnnotationView: MKAnnotationView {
    
    var popsicleGroupAnnotationSubview: PopsicleGroupIcon!
    
    var popsicleCount: Int!
    
    // 0: Base group, -1: undetermined, >0: Contains subgroups.
    
    var popsicleGroupLevel = -1
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    /*
        prepareForDisplay: function called to customize the view before presenting it on the screen. It is overwritten to customize the group view.
            - ...
     */
    
    override func prepareForDisplay() {
        
        super.prepareForDisplay()
        
        canShowCallout = false
        
        collisionMode = .circle
        
        centerOffset = CGPoint(x: 0, y: -10)
        
        if let cluster = annotation as? MKClusterAnnotation {
            
            let totalPopsicles = String(cluster.memberAnnotations.count)
            
            popsicleGroupAnnotationSubview = PopsicleGroupIcon(frame: CGRect(x: 0, y: 0, width: popsicleSize?.width ?? 58, height: popsicleSize?.height ?? 58))
            
            popsicleGroupAnnotationSubview.setCountLabel(count: totalPopsicles)
            
            frame.size = popsicleSize ?? CGSize(width: 58, height: 58)
            
            popsicleGroupAnnotationSubview.frame.size = frame.size
            
            addSubview(popsicleGroupAnnotationSubview)
            
            displayPriority = .defaultHigh
            
        }
        
    }
    
}


