//
//  doneButton.swift - Subclass of UIButton which styles the button that closes the create event view once the information has been filled correctly.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 10/25/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit

class doneButton: UIButton {
    
    let buttonImage = UIImage(named: "doneButton")
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupButton()
        
    }
    
    private func setupButton() {
        
        // *** STYLES THE DONE BUTTON ***
        
        setImage(buttonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        clipsToBounds = true
 
        layer.masksToBounds = true
        
    }
    
}
