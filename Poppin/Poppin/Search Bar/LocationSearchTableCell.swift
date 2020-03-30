//
//  LocationSearchTableCell.swift - Represents a single cell or row of the location search table. It simply styles the cell.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 11/5/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit

class LocationSearchTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            
            // *** STYLES THE OUTSIDE OF THE CELL ***
            
            containerView.backgroundColor = UIColor.clear
            
            containerView.layer.shadowOpacity = 0.3
            
            containerView.layer.shadowRadius = 2
            
            containerView.layer.shadowColor = UIColor.black.cgColor
            
            containerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            
        }
    }
    
    @IBOutlet weak var clippingView: UIView! {
        didSet {
            
            // *** STYLES THE INSIDE OF THE CELL ***
            
            clippingView.layer.cornerRadius = 10
            
            clippingView.backgroundColor = UIColor.white
            
            clippingView.layer.masksToBounds = true
            
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    /*
     This function simply adds a "tapping" animation once a cell has been pressed since
     the default one sucks :)
     */
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if (highlighted) {
            
            clippingView.backgroundColor = UIColor.lightGray
            
        } else {
            
            clippingView.backgroundColor = UIColor.white
            
        }
        
    }
    
}
