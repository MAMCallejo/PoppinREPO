//
//  NewCreateEventCardViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 6/6/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewCreateEventCardViewController : UIViewController, UITextFieldDelegate {
    
    lazy private var nameCard: UITextField = {
        
        var t = UITextField()
        t.backgroundColor = .white
        
        let sideIcon = UIImageView(image: UIImage(systemSymbol: .pencil).withTintColor(.mainNAVYBLUE).imageWithInsets(insets: UIEdgeInsets(top: .getPercentageWidth(percentage: 1.5), left: .getPercentageWidth(percentage: 1.5), bottom: .getPercentageWidth(percentage: 1.5), right: .getPercentageWidth(percentage: 1.5))))
        sideIcon.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        sideIcon.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        t.leftView = sideIcon
        t.leftViewMode = .always
        
        t.layer.masksToBounds = false
        t.layer.cornerRadius = 16
        t.layer.shadowColor = UIColor.black.cgColor
        t.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        t.layer.shadowOpacity = 0.3
        t.layer.shadowRadius = 2
        
        t.font = UIFont(name: "Octarine", size: 20)
        t.textColor = .mainNAVYBLUE
        t.placeholder = "Name"
        
        t.autocorrectionType = .no
        t.keyboardType = .default
        t.returnKeyType = .done
        t.clearButtonMode = .whileEditing
        t.contentVerticalAlignment = .center
        t.delegate = self
        
        return t
        
    }()
    
    lazy private var dateCard: UIView = {
        
        var v = UIView()
        v.backgroundColor = .white
        
        let sideIcon = UIImageView(image: UIImage(systemSymbol: .calendar).withTintColor(.mainNAVYBLUE))
        sideIcon.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        sideIcon.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        v.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        v.addSubview(sideIcon)
        
        v.layer.masksToBounds = false
        v.layer.cornerRadius = 16
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 2
        
//        t.font = UIFont(name: "Octarine", size: 20)
//        t.textColor = .mainNAVYBLUE
//        t.placeholder = "Date"
//
//        t.autocorrectionType = .no
//        t.keyboardType = .default
//        t.returnKeyType = .done
//        t.clearButtonMode = .whileEditing
//        t.contentVerticalAlignment = .center
//        t.delegate = self
        
        return v
        
    }()
    
    lazy private var durationCard: UIView = {
        var dc = UIView()
        dc.backgroundColor = .white
        dc.layer.masksToBounds = false
        dc.layer.cornerRadius = 16
        dc.layer.shadowColor = UIColor.black.cgColor
        dc.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        dc.layer.shadowOpacity = 0.3
        dc.layer.shadowRadius = 2
        return dc
    }()
    
    lazy private var infoCard: UIView = {
        var ic = UIView()
        ic.backgroundColor = .white
        ic.layer.masksToBounds = false
        ic.layer.cornerRadius = 16
        ic.layer.shadowColor = UIColor.black.cgColor
        ic.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        ic.layer.shadowOpacity = 0.3
        ic.layer.shadowRadius = 2
        return ic
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
        nameCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 6)).isActive = true
        nameCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 20)).isActive = true
        nameCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(dateCard)
        dateCard.translatesAutoresizingMaskIntoConstraints = false
        dateCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        dateCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 6)).isActive = true
        dateCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 30)).isActive = true
        dateCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(durationCard)
        durationCard.translatesAutoresizingMaskIntoConstraints = false
        durationCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        durationCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 8)).isActive = true
        durationCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 44)).isActive = true
        durationCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(infoCard)
        infoCard.translatesAutoresizingMaskIntoConstraints = false
        infoCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        infoCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 8)).isActive = true
        infoCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 56)).isActive = true
        infoCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 24)).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 4)).isActive = true
        createButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 85)).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
    
    //MARK: Textfield Delegate
    // When user press the return key in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }

    // It is called before text field become active
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = UIColor.lightGray
        return true
    }

    // It is called when text field activated
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }

    // It is called when text field going to inactive
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = UIColor.white
        return true
    }

    // It is called when text field is inactive
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }

    // It is called each time user type a character by keyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        return true
    }
    
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
