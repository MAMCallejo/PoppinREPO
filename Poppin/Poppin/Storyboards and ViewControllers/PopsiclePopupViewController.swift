//
//  PopsiclePopupViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 6/24/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class PopsiclePopupViewController : UIViewController {
    
    lazy var tabBar : UIView = {
        var t = UIView()
        t.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        t.layer.cornerRadius = 4
        return t
    }()
    
    lazy var catOfEvent : UIImageView = {
        var i = UIImageView(image: UIImage(named: "foodPopsicleIcon256"))
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    lazy var nameOfEvent : UITextView = {
        var t = UITextView()
        t.backgroundColor = UIColor.white.withAlphaComponent(0)
        t.font = UIFont(name: "Octarine-Bold", size: 20)
        t.textColor = .white
        t.text = "Yosi's forehead Gathering"
        return t
    }()
    
    lazy var startOfEvent : UITextView = {
        var t = UITextView()
        t.backgroundColor = UIColor.white.withAlphaComponent(0)
        t.font = UIFont(name: "Octarine-LightOblique", size: 18)
        t.textColor = .white
        t.text = "Starts at: 2:00 pm"
        return t
    }()
    
    lazy var userThatCreatedEventImage : ImageBubbleButton = {
        var i = ImageBubbleButton(bouncyButtonImage: .defaultUserPicture256)
        return i
    }()
    
    lazy var userThatCreatedEventName : UITextView = {
        var t = UITextView()
        t.backgroundColor = UIColor.white.withAlphaComponent(0)
        t.font = UIFont(name: "Octarine-Light", size: 18)
        t.textColor = .mainDARKPURPLE
        t.text = "Created by:\n@mrchoperini"
        return t
    }()
    
    lazy var userChat : BouncyButton = {
        var i = BouncyButton(bouncyButtonImage: UIImage(systemSymbol: .envelopeBadge).withTintColor(.mainDARKPURPLE))
        //i.contentMode = .scaleAspectFit
        return i
    }()
    
    lazy var createdBy : UIView = {
        var c = UIView()
        c.backgroundColor = .white
        c.layer.cornerRadius = 16
        
        c.addSubview(userThatCreatedEventImage)
        userThatCreatedEventImage.translatesAutoresizingMaskIntoConstraints = false
        userThatCreatedEventImage.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 25)).isActive = true
        userThatCreatedEventImage.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        userThatCreatedEventImage.topAnchor.constraint(equalTo: c.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 1.5)).isActive = true
        userThatCreatedEventImage.leadingAnchor.constraint(equalTo: c.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 0)).isActive = true
        
        c.addSubview(userThatCreatedEventName)
        userThatCreatedEventName.translatesAutoresizingMaskIntoConstraints = false
        userThatCreatedEventName.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 45)).isActive = true
        userThatCreatedEventName.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        userThatCreatedEventName.topAnchor.constraint(equalTo: c.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 1)).isActive = true
        userThatCreatedEventName.leadingAnchor.constraint(equalTo: c.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 22)).isActive = true
        
        c.addSubview(userChat)
        userChat.translatesAutoresizingMaskIntoConstraints = false
        userChat.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 12)).isActive = true
        userChat.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        userChat.topAnchor.constraint(equalTo: c.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 1.5)).isActive = true
        userChat.leadingAnchor.constraint(equalTo: c.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 68)).isActive = true
        
        return c
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .foodORANGE
        
        view.addSubview(tabBar)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 20)).isActive = true
        tabBar.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 0.75)).isActive = true
        tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(.getPercentageHeight(percentage: 3.5))).isActive = true
        tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(catOfEvent)
        catOfEvent.translatesAutoresizingMaskIntoConstraints = false
        catOfEvent.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 25)).isActive = true
        catOfEvent.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        catOfEvent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(.getPercentageHeight(percentage: 0.25))).isActive = true
        catOfEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 0)).isActive = true
        
        view.addSubview(nameOfEvent)
        nameOfEvent.translatesAutoresizingMaskIntoConstraints = false
        nameOfEvent.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 75)).isActive = true
        nameOfEvent.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        nameOfEvent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(.getPercentageHeight(percentage: 1.25))).isActive = true
        nameOfEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 20)).isActive = true
        
        view.addSubview(startOfEvent)
        startOfEvent.translatesAutoresizingMaskIntoConstraints = false
        startOfEvent.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 75)).isActive = true
        startOfEvent.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 5)).isActive = true
        startOfEvent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 1.85)).isActive = true
        startOfEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 20)).isActive = true
        
        view.addSubview(createdBy)
        createdBy.translatesAutoresizingMaskIntoConstraints = false
        createdBy.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 85)).isActive = true
        createdBy.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 8)).isActive = true
        createdBy.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 7)).isActive = true
        createdBy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        
        roundViews()
    }
    
    /* controls the animation of the popup when it first appears */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.moveView(state: .partial)
        })
    }
    
    private func moveView(state: State) {
        let yPosition = state == .partial ? Constant.partialViewYPosition : Constant.fullViewYPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
    }

    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY
        
        if (minY + translation.y >= Constant.fullViewYPosition) && (minY + translation.y <= Constant.partialViewYPosition) {
            view.frame = CGRect(x: 0, y: minY + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.6, delay: 0.0, options: [.allowUserInteraction], animations: {
                let state: State = recognizer.velocity(in: self.view).y >= 0 ? .partial : .full
                self.moveView(state: state)
            }, completion: nil)
        }
    }
    
    func roundViews() {
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
    }
}

extension PopsiclePopupViewController {
    private enum State {
        case partial
        case full
    }
    
    private enum Constant {
        static let fullViewYPosition: CGFloat = .getPercentageHeight(percentage: 5)
        static let partialViewYPosition: CGFloat = .getPercentageHeight(percentage: 76)
    }
}
