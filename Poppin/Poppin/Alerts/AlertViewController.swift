//
//  AlertViewController.swift - Contains necessary code to set up an alert.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 4/25/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

final class AlertViewController: UIViewController {
    
    public static let defaultWarningMessage = "If you proceed, some information might be lost."
    public static let defaultErrorMessage = "Unable to proceed, please try again."
    
    lazy private var alertMessage: String = AlertViewController.defaultErrorMessage
    lazy private var alertButtons: [AlertButton] = [AlertButton(alertTitle: nil, alertButtonAction: nil)]
    private let edgeInset: CGFloat = .getPercentageWidth(percentage: 3)
    
    lazy private var alertContainerView: UIView = {
        
        var alertContainerView = UIView()
        alertContainerView.backgroundColor = .white
        alertContainerView.addShadowAndRoundCorners()
        alertContainerView.clipsToBounds = true
        
        alertContainerView.addSubview(alertButtonsStackView)
        alertButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        alertButtonsStackView.heightAnchor.constraint(equalTo: alertContainerView.heightAnchor, multiplier: 0.25).isActive = true
        alertButtonsStackView.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor).isActive = true
        alertButtonsStackView.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor).isActive = true
        alertButtonsStackView.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor).isActive = true
        
        alertContainerView.addSubview(alertMessageLabel)
        alertMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        alertMessageLabel.topAnchor.constraint(equalTo: alertContainerView.topAnchor, constant: edgeInset).isActive = true
        alertMessageLabel.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: edgeInset).isActive = true
        alertMessageLabel.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -edgeInset).isActive = true
        alertMessageLabel.bottomAnchor.constraint(equalTo: alertButtonsStackView.topAnchor, constant: -edgeInset).isActive = true
        
        return alertContainerView
        
    }()
    
    lazy private var alertMessageLabel: UILabel = {
        
        var alertMessageLabel = UILabel()
        alertMessageLabel.textAlignment = .center
        alertMessageLabel.numberOfLines = 0
        alertMessageLabel.sizeToFit()
        alertMessageLabel.textColor = .mainNAVYBLUE
        alertMessageLabel.backgroundColor = .white
        alertMessageLabel.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 18.0, maxSize: 20.0))
        return alertMessageLabel
        
    }()
    
    lazy private var alertButtonsStackView: UIStackView = {
        
        var alertButtonsStackView = UIStackView()
        alertButtonsStackView.axis = .horizontal
        alertButtonsStackView.alignment = .fill
        alertButtonsStackView.distribution = .fillEqually
        alertButtonsStackView.spacing = 3.0
        alertButtonsStackView.backgroundColor = .white
        return alertButtonsStackView
        
    }()
    
    convenience init() {
        
        self.init(alertMessage: nil, alertButtons: nil)
        
    }
    
    init(alertMessage: String?, alertButtons: [AlertButton]?) {
        
        super.init(nibName: nil, bundle: nil)
        
        if let newAlertMessage = alertMessage { self.alertMessage = newAlertMessage }
        if let newAlertButtons = alertButtons { self.alertButtons = newAlertButtons }
        
        configureAlert()
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        configureAlert()
        
    }
    
    private func configureAlert() {
        
        alertMessageLabel.text = alertMessage
        
        for alertButton in alertButtons {
            
            alertButton.addTarget(self, action: #selector(executeAlertAction), for: .touchUpInside)
            alertButtonsStackView.addArrangedSubview(alertButton)
            
        }
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        view.addSubview(alertContainerView)
        alertContainerView.translatesAutoresizingMaskIntoConstraints = false
        alertContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertContainerView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 70)).isActive = true
        
    }
    
    @objc func executeAlertAction(sender: AlertButton) {
        
        self.dismiss(animated: true, completion: sender.alertButtonAction)
        
    }
    
}

class AlertButton: UIButton {
    
    public static let defaultTitle = "Ok"
        
    lazy fileprivate var alertButtonAction: (() -> Void) = {}
    
    convenience init() {
        
        self.init(alertTitle: nil, alertButtonAction: nil)
        
    }
    
    init(alertTitle: String?, alertButtonAction: (() -> Void)?) {
        
        super.init(frame: .zero)
        
        setTitle(alertTitle ?? AlertButton.defaultTitle, for: .normal)
        backgroundColor = .mainNAVYBLUE
        tintColor = .white
        titleLabel?.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 18.0, maxSize: 20.0))
        if let newAlertButtonAction = alertButtonAction { self.alertButtonAction = newAlertButtonAction }
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setTitle(AlertButton.defaultTitle, for: .normal)
        backgroundColor = .mainNAVYBLUE
        tintColor = .white
        titleLabel?.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 18.0, maxSize: 20.0))
        
    }
    
}

