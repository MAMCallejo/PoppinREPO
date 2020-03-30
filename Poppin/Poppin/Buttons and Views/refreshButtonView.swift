//
//  refreshButtonView.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 1/30/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class refreshButtonView: UIView {
    
    var refreshButton: UIButton?
    
    var refreshButtonIcon: UIImageView?
    
    var refreshCountBubble: UIImageView?
    
    var refreshCountLabel: UILabel?
    
    // initWithFrame to init view from code.
    
    override init(frame: CGRect) {
        
      super.init(frame: frame)
        
    }
    
    // initWithCode to init view from xib or storyboard.
    
    required init?(coder aDecoder: NSCoder) {
        
      super.init(coder: aDecoder)

    }
    
    // Private object helper method that animates the button when it has been pressed.
    //  - It calls the private helper method animate to take care of the animation.
    
    @objc private func animateDown(sender: UIButton) {
        
        animate(down: true, transform: CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9))
        
    }
    
    // Private object helper method that animates the button when it has been released.
    //  - It calls the private helper method animate to take care of the animation.
    
    @objc private func animateUp(sender: UIButton) {
        
        animate(down: false, transform: .identity)
        
    }
    
    // Private helper method that animates the button animation.
    
    private func animate(down: Bool, transform: CGAffineTransform) {
        
        if (down) {
            
            UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        
                        self.refreshButtonIcon!.transform = transform
                        
                        self.refreshButtonIcon!.layer.opacity = 0.5
                        
                        self.refreshCountBubble!.transform = transform
                        
                        self.refreshCountBubble!.layer.opacity = 0.5
                        
                        self.refreshCountLabel!.transform = transform
                        
                        self.refreshCountLabel!.layer.opacity = 0.5
                        
            }, completion: nil)
            
        } else {
            
            UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        
                        self.refreshButtonIcon!.transform = transform
                        
                        self.refreshButtonIcon!.layer.opacity = 1.0
                        
                        self.refreshCountBubble!.transform = transform
                        
                        self.refreshCountBubble!.layer.opacity = 1.0
                        
                        self.refreshCountLabel!.transform = transform
                        
                        self.refreshCountLabel!.layer.opacity = 1.0
                        
            }, completion: nil)
            
        }
        
    }
    
    /*
     This function is called by the external view controller in order to set the parameters
     of the view.
     */
    
    public func setParameters (rb: UIButton, rbi: UIImageView, rcb: UIImageView, rcl: UILabel) {
        
        refreshButton = rb
        
        refreshButtonIcon = rbi
        
        refreshCountBubble = rcb
        
        refreshCountLabel = rcl
        
        // Creates notification targets that check if the user is pressing down the button or not in order to animate it.
        //  - They call two private object helper methods called animateDown and animateUp which take care of the animation.
        
        refreshButton!.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        
        refreshButton!.addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        
    }
    
    public func hideCounter() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                       options: .curveEaseOut, animations: {
                        
                        self.refreshCountBubble!.alpha = 0
                        
                        self.refreshCountBubble!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        
                        self.refreshCountBubble!.isHidden = true
                        
                        self.refreshCountLabel!.alpha = 0
                        
                        self.refreshCountLabel!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        
                        self.refreshCountLabel!.isHidden = true
                        
        }, completion: nil)
        
    }
    
    public func showCounter(count: Int) {
        
        if (self.refreshCountBubble!.isHidden) {
            
            self.refreshCountBubble!.alpha = 0
            
            self.refreshCountBubble!.isHidden = false
            
            self.refreshCountBubble!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            self.refreshCountLabel!.alpha = 0
            
            self.refreshCountLabel!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            self.refreshCountLabel!.isHidden = false
            
            self.refreshCountLabel!.text = String(count)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                           options: .curveEaseOut, animations: {
                            
                            self.refreshCountBubble!.transform = .identity
                            
                            self.refreshCountBubble!.alpha = 1
                            
                            self.refreshCountLabel!.transform = .identity
                            
                            self.refreshCountLabel!.alpha = 1
                            
            }, completion: nil)
            
        } else {
            
            self.refreshCountBubble!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            self.refreshCountLabel!.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                           options: .curveEaseOut, animations: {
                            
                            self.refreshCountBubble!.transform = .identity
                            
                            self.refreshCountLabel!.transform = .identity
                            
                            self.refreshCountLabel!.text = String(count)
                            
            }, completion: nil)
            
        }
        
    }
    
}
