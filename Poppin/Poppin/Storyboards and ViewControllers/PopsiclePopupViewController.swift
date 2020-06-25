//
//  PopsiclePopupViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 6/24/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class PopsiclePopupViewController : UIViewController {
    
    lazy var catOfEvent : UIImageView = {
        
        var i = UIImageView(image: UIImage(named: "foodPopsicleIcon256"))
        i.contentMode = .scaleAspectFit
//            .imageWithInsets(insets: UIEdgeInsets(top: .getPercentageWidth(percentage: 1.5), left: .getPercentageWidth(percentage: 3), bottom: .getPercentageWidth(percentage: 1.5), right: .getPercentageWidth(percentage: 3))))
        
        return i
        
    }()
    
    lazy var nameOfEvent : UITextView = {
        
        var t = UITextView()
        
        t.font = UIFont(name: "Octarine-Bold", size: 20)
        t.textColor = .mainDARKPURPLE
        
        t.text = "Yosi's Forehead Gathering"
        
        return t
        
    }()
    
    lazy var pCard : UIView = {
        
        var card = UIView()
        
        card.backgroundColor = .white
        
        card.layer.masksToBounds = false
        card.layer.cornerRadius = 16
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
        card.layer.shadowOpacity = 0.2
        card.layer.shadowRadius = 2
        
        card.addSubview(nameOfEvent)
        nameOfEvent.translatesAutoresizingMaskIntoConstraints = false
        nameOfEvent.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 75)).isActive = true
        nameOfEvent.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        nameOfEvent.topAnchor.constraint(equalTo: card.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 3)).isActive = true
        nameOfEvent.leadingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 20)).isActive = true
        
        card.addSubview(catOfEvent)
        catOfEvent.translatesAutoresizingMaskIntoConstraints = false
        catOfEvent.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 25)).isActive = true
        catOfEvent.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        catOfEvent.topAnchor.constraint(equalTo: card.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 3)).isActive = true
        catOfEvent.leadingAnchor.constraint(equalTo: card.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 0)).isActive = true
        
        return card
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        modalPresentationStyle = .overCurrentContext
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        view.addSubview(pCard)
        pCard.translatesAutoresizingMaskIntoConstraints = false
        pCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 100)).isActive = true
        pCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 25)).isActive = true
        pCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 70)).isActive = true
        pCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
