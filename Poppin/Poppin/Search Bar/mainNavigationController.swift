//
//  mainNavigationController.swift - This view controller facilitates showing the search bar at the top of map view.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 11/12/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit

class mainNavigationController: UINavigationController {
    
    // Set the shouldAutorotate to False
    
    override open var shouldAutorotate: Bool {
        
        return false
        
    }
       
    // Specify the orientation.
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .portrait
        
    }
    
}
