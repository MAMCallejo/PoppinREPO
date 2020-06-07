//
//  NewCreateEventCardViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 6/6/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewCreateEventCardViewController : UIViewController {
    
    lazy private var cancelButton: BubbleButton = {
        var cb = BubbleButton(bouncyButtonImage: UIImage(systemSymbol: .multiply, withConfiguration: UIImage.SymbolConfiguration(pointSize: 0, weight: .medium)).withTintColor(.mainNAVYBLUE, renderingMode: .alwaysOriginal))
        cb.backgroundColor = .white
        cb.contentEdgeInsets = UIEdgeInsets(top: .getPercentageWidth(percentage: 2), left: .getPercentageWidth(percentage: 2), bottom: .getPercentageWidth(percentage: 2), right: .getPercentageWidth(percentage: 2))
        cb.addTarget(self, action: #selector(dismissCreateCard), for: .touchUpInside)
        return cb
    }()
    
    @objc func dismissCreateCard() {
        self.dismiss(animated: true, completion: nil)
    }
    
    var backgroundGradientColors = [CGColor]()
    
    lazy var gLayer : CAGradientLayer = {
        let g = CAGradientLayer()
        g.type = .radial
        g.colors = backgroundGradientColors
        g.locations = [ 0 , 1 ]
        g.startPoint = CGPoint(x: 0.5, y: 0.5)
        g.endPoint = CGPoint(x: 1.4, y: 1.15)
        g.frame = view.layer.bounds
        return g
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        /* FOR TRIAL PURPOSES */
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        /* FOR TRIAL PURPOSES */
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // gradient
        view.layer.insertSublayer(gLayer, at: 0)
        
        // cancel button
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 2)).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 5)).isActive = true
    }
    
}
