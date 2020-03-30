//
//  categoryButtonView.swift - Abstraction of the category pickers. They simply represent when a category has been picked or not.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 12/1/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit

class categoryButtonView: UIView {
    
    var categoryIcon: UIImageView?
    
    var categoryLegendLabel: UILabel?
    
    var categoryButton: UIButton?
    
    var isSelected: Bool = false {
        didSet {
            
            // Swaps the colors between the label and the background of the view when the view is selected or not...
            // ...and adds a shadow when it is selected.
            
            let categoryLegendLabelTextColor = categoryLegendLabel?.textColor
            
            categoryLegendLabel?.textColor = self.backgroundColor
            
            self.backgroundColor = categoryLegendLabelTextColor
            
            if (self.isSelected) {
                
                self.layer.shadowColor = UIColor.black.cgColor
                
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                
                self.layer.shadowOpacity = 0.3
                
                self.layer.shadowRadius = 2
                
            } else {
                
                self.layer.shadowOpacity = 0
                
            }
            
        }
    }
    
    // initWithFrame to init view from code.
    
    override init(frame: CGRect) {
        
      super.init(frame: frame)
        
      setupView()
        
    }
    
    // initWithCode to init view from xib or storyboard.
    
    required init?(coder aDecoder: NSCoder) {
        
      super.init(coder: aDecoder)
        
      setupView()
        
    }
    
    private func setupView () {
        
        // *** STYLES THE CATEGORY BUTTON VIEW ***
        
        layer.masksToBounds = false
        
        layer.cornerRadius = 15
        
    }
    
    /*
     This function is called by the external view controller in order to set the parameters
     of the view.
     */
    
    func setParameters (ci: UIImageView, cll: UILabel, cb: UIButton) {
        
        categoryIcon = ci
        
        categoryLegendLabel = cll
        
        categoryButton = cb
        
    }
    
}

