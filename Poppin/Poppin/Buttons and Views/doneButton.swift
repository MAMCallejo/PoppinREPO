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
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Creates notification targets that check if the user is pressing down the button or not in order to animate it.
        //  - They call two private object helper methods called animateDown and animateUp which take care of the animation.
        
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        
    }
    
    private func setupButton() {
        
        // *** STYLES THE DONE BUTTON ***
        
        setImage(buttonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        clipsToBounds = true
 
        layer.masksToBounds = true
        
    }
    
    // Private object helper method that animates the button when it has been pressed.
    //  - It calls the private helper method animate to take care of the animation.
    
    @objc private func animateDown(sender: UIButton) {
        
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
        
    }
    
    // Private object helper method that animates the button when it has been released.
    //  - It calls the private helper method animate to take care of the animation.
    
    @objc private func animateUp(sender: UIButton) {
        
        animate(sender, transform: .identity)
        
    }
    
    // Private helper method that animates the button animation.
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
        
    }
    
}
