//
//  BouncyButton.swift - UIButton with a bouncy animation when pressed.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 4/26/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class BouncyButton: UIButton {
    
    private var bouncyButtonImage: UIImage?
    
    init(bouncyButtonImage: UIImage?) {
        
        super.init(frame: .zero)
        
        self.bouncyButtonImage = bouncyButtonImage
        
        setupButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupButton()
        
    }
    
    private func setupButton() {
        
        setImage(bouncyButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])

    }
    
    @objc private func animateDown(sender: UIButton) {
        
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
        
    }
    
    @objc private func animateUp(sender: UIButton) {
        
        animate(sender, transform: .identity)
        
    }
    
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
