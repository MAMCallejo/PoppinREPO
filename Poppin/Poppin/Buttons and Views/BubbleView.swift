//
//  BubbleView.swift - Circle view.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 4/28/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class BubbleView: UIView {
    
    override func layoutSubviews() {
        
        addShadowAndRoundCorners(cornerRadius: min(bounds.width, bounds.height) / 2)
        
        layer.cornerCurve = .continuous
        
    }
    
}
