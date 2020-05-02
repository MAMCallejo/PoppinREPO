//
//  NewViewControllerTransitionAnimators.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 5/1/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class ViewControllerFadeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let presenting: Bool
    
    init(presenting: Bool) {
        
        self.presenting = presenting
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.2
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if presenting {
    
            guard let toView = transitionContext.view(forKey: .to) else { return }
            let containerView = transitionContext.containerView
            
            containerView.addSubview(toView)
            toView.alpha = 0.0
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                
                toView.alpha = 1.0
                
            }) { (finished) in
                
                if !finished { toView.removeFromSuperview() }
                
                transitionContext.completeTransition(finished)
                
            }
            
        } else {
            
            let containerView = transitionContext.containerView
            
            containerView.alpha = 1.0
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                
                containerView.alpha = 0.0
                
            }) { (finished) in
                
                containerView.removeFromSuperview()
                
                transitionContext.completeTransition(finished)
                
            }
            
        }
        
    }

}

