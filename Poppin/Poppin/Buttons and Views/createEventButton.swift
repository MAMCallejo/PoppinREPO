//
//  createEventButton.swift - Subclass of UIButton which styles the button that opens the create event view.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 9/29/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit

class createEventButton: UIButton {
    
    let buttonImage = UIImage(named: "createEventButton")
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupButton()
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupButton()

    }
    
    private func setupButton() {
        
        setImage(buttonImage?.withRenderingMode(.alwaysOriginal), for: .normal)

    }
    
}
