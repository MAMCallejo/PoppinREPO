//
//  NewCreateEventCardViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 6/6/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewCreateEventCardViewController : UIViewController {
    
    lazy private var nameCard: UIView = {
        var nc = UIView()
        nc.backgroundColor = .white
        nc.layer.masksToBounds = false
        nc.layer.cornerRadius = 16
        nc.layer.shadowColor = UIColor.black.cgColor
        nc.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        nc.layer.shadowOpacity = 0.3
        nc.layer.shadowRadius = 2
        return nc
    }()
    
    lazy private var dateCard: UIView = {
        var nc = UIView()
        nc.backgroundColor = .white
        nc.layer.masksToBounds = false
        nc.layer.cornerRadius = 16
        nc.layer.shadowColor = UIColor.black.cgColor
        nc.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        nc.layer.shadowOpacity = 0.3
        nc.layer.shadowRadius = 2
        return nc
    }()
    
    lazy private var durationCard: UIView = {
        var nc = UIView()
        nc.backgroundColor = .white
        nc.layer.masksToBounds = false
        nc.layer.cornerRadius = 16
        nc.layer.shadowColor = UIColor.black.cgColor
        nc.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        nc.layer.shadowOpacity = 0.3
        nc.layer.shadowRadius = 2
        return nc
    }()
    
    lazy private var infoCard: UIView = {
        var nc = UIView()
        nc.backgroundColor = .white
        nc.layer.masksToBounds = false
        nc.layer.cornerRadius = 16
        nc.layer.shadowColor = UIColor.black.cgColor
        nc.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        nc.layer.shadowOpacity = 0.3
        nc.layer.shadowRadius = 2
        return nc
    }()
    
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
    
    lazy private var createButton: UIButton = {
        var cb = UIButton()
        cb.backgroundColor = .white
        cb.setTitle("Create", for: .normal)
        cb.setTitleColor(.mainNAVYBLUE, for: .normal)
        cb.titleLabel?.font = UIFont(name: "Octarine-Bold", size: 16)
        cb.contentEdgeInsets = UIEdgeInsets(top: .getPercentageWidth(percentage: 2), left: .getPercentageWidth(percentage: 2), bottom: .getPercentageWidth(percentage: 2), right: .getPercentageWidth(percentage: 2))
        cb.addShadowAndRoundCorners(cornerRadius: 16)
        cb.addTarget(self, action: #selector(createCard), for: .touchUpInside)
        return cb
    }()
    
    @objc func createCard() {
        //
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
        
        view.addSubview(nameCard)
        nameCard.translatesAutoresizingMaskIntoConstraints = false
        nameCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        nameCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 8)).isActive = true
        nameCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 15)).isActive = true
        nameCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(dateCard)
        dateCard.translatesAutoresizingMaskIntoConstraints = false
        dateCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        dateCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 8)).isActive = true
        dateCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 25)).isActive = true
        dateCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(durationCard)
        durationCard.translatesAutoresizingMaskIntoConstraints = false
        durationCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        durationCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 8)).isActive = true
        durationCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 35)).isActive = true
        durationCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(infoCard)
        infoCard.translatesAutoresizingMaskIntoConstraints = false
        infoCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        infoCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 8)).isActive = true
        infoCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 45)).isActive = true
        infoCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 24)).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 4)).isActive = true
        createButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 85)).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
    
}
