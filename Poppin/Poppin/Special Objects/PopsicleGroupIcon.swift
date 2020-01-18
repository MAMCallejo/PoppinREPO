//
//  PopsicleGroupIcon.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 12/27/19.
//  Copyright © 2019 whatspoppinREPO. All rights reserved.
//

import UIKit

class PopsicleGroupIcon: UIView {
    
    @IBOutlet weak var view: UIView!

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var popsicleIconImageView: UIImageView!
    
    @IBOutlet weak var popsicleBubbleCountImageView: UIImageView!
    
    @IBOutlet weak var popsicleCountLabel: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        nibSetup()
        
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        nibSetup()
        
    }

    private func nibSetup() {
        
        backgroundColor = .clear

        view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.translatesAutoresizingMaskIntoConstraints = true

        addSubview(view)
        
    }

    private func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
        
    }
    
    public func setCountLabel(count: String) {
        
        popsicleCountLabel.text = count
        
        popsicleCountLabel.adjustsFontSizeToFitWidth = true
        
    }
    
}
