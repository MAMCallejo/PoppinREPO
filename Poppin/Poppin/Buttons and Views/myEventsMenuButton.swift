//
//  myEventsMenuButton.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 1/14/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class myEventsMenuButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Creates notification targets that check if the user is pressing down the button or not in order to animate it.
        //  - They call two private object helper methods called animateDown and animateUp which take care of the animation.
        
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        // Creates notification targets that check if the user is pressing down the button or not in order to animate it.
        //  - They call two private object helper methods called animateDown and animateUp which take care of the animation.
        
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Creates notification targets that check if the user is pressing down the button or not in order to animate it.
        //  - They call two private object helper methods called animateDown and animateUp which take care of the animation.
        
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])

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
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
        
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isHighlighted = true
        
        super.touchesBegan(touches, with: event)
        
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isHighlighted = false
        
        super.touchesEnded(touches, with: event)
        
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isHighlighted = false
        
        super.touchesCancelled(touches, with: event)
        
    }
    
}

