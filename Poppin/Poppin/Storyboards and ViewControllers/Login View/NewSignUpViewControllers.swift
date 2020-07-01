//
//  NewSignUpViewControllers.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 6/16/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

/*
 First Page
*/

class NewSignUpFirstPageViewController: UIViewController, UITextFieldDelegate {
    
    let loginInsetY: CGFloat = .getPercentageWidth(percentage: 5)
    let loginInsetX: CGFloat = .getPercentageWidth(percentage: 5)
    let loginInnerInset: CGFloat = .getPercentageWidth(percentage: 4)
    
    let containerInsetY: CGFloat = .getPercentageWidth(percentage: 9)
    let containerInsetX: CGFloat = .getPercentageWidth(percentage: 9)
    
    let innerElementsSpacing: CGFloat = .getPercentageWidth(percentage: 3)
    
    private let datePicker: UIDatePicker = {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(setDateFromPicker), for: .valueChanged)
        return datePicker
        
    }()
    
    lazy private var signUpContainerView: UIView = {
        
        let contentStackViewSpacing: CGFloat = .getPercentageWidth(percentage: 6.5)
        
        let contentStackView = UIStackView(arrangedSubviews: [fullNameTextField, dateOfBirthTextField, signUpNextButton])
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.spacing = contentStackViewSpacing
        
        var signUpContainerView = UIView(frame: .zero)
        signUpContainerView.backgroundColor = .white
        signUpContainerView.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 14.0, maxSize: 16.0), shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.3, shadowRadius: 8.0)
        
        signUpContainerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: (containerInsetY*1.1)+poppinTitleLabel.intrinsicContentSize.height+contentStackViewSpacing).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: containerInsetX).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor, constant: -containerInsetX).isActive = true
        
        signUpContainerView.addSubview(switchToLoginTab)
        switchToLoginTab.bottomAnchor.constraint(equalTo: signUpContainerView.bottomAnchor).isActive = true
        switchToLoginTab.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor).isActive = true
        switchToLoginTab.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor).isActive = true
        
        return signUpContainerView
        
    }()
    
    lazy private var fullNameTextField: UITextField = {
        
        var fullNameTextField = UITextField()
        fullNameTextField.backgroundColor = .clear
        fullNameTextField.textColor = .mainDARKPURPLE
        fullNameTextField.font = .dynamicFont(with: "Octarine-Bold", style: .subheadline)
        fullNameTextField.attributedPlaceholder = NSAttributedString(string: "Full name", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Light", style: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        fullNameTextField.delegate = self
        fullNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: fullNameTextField.intrinsicContentSize.height))
        fullNameTextField.leftViewMode = .always
        fullNameTextField.clearButtonMode = .whileEditing
        fullNameTextField.returnKeyType = .next
        fullNameTextField.autocapitalizationType = .none
        fullNameTextField.autocorrectionType = .no
        fullNameTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        fullNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        fullNameTextField.translatesAutoresizingMaskIntoConstraints = false
        fullNameTextField.heightAnchor.constraint(equalToConstant: fullNameTextField.intrinsicContentSize.height+(loginInnerInset*0.4)).isActive = true
        
        return fullNameTextField
        
    }()
    
    lazy private var dateOfBirthTextField: UITextField = {
        
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        let dateDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissDatePicker))
        let dateFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        dateToolbar.setItems([dateFlexSpace, dateDoneButton], animated: true)
        
        var dateOfBirthTextField = UITextField()
        dateOfBirthTextField.backgroundColor = .clear
        dateOfBirthTextField.textColor = .mainDARKPURPLE
        dateOfBirthTextField.font = .dynamicFont(with: "Octarine-Bold", style: .subheadline)
        dateOfBirthTextField.attributedPlaceholder = NSAttributedString(string: "Date of birth", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Light", style: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        dateOfBirthTextField.delegate = self
        dateOfBirthTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: dateOfBirthTextField.intrinsicContentSize.height))
        dateOfBirthTextField.leftViewMode = .always
        dateOfBirthTextField.clearButtonMode = .whileEditing
        dateOfBirthTextField.returnKeyType = .next
        dateOfBirthTextField.autocapitalizationType = .none
        dateOfBirthTextField.autocorrectionType = .no
        dateOfBirthTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        dateOfBirthTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        
        dateOfBirthTextField.inputView = datePicker
        dateOfBirthTextField.inputAccessoryView = dateToolbar
        
        dateOfBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthTextField.heightAnchor.constraint(equalToConstant: dateOfBirthTextField.intrinsicContentSize.height+(loginInnerInset*0.4)).isActive = true
        
        return dateOfBirthTextField
        
    }()
    
    lazy private var signUpNextButton: BouncyButton = {
        
        let innerEdgeInset: CGFloat = .getPercentageWidth(percentage: 2.5)
        
        var signUpNextButton = BouncyButton(bouncyButtonImage: nil)
        signUpNextButton.backgroundColor = .mainDARKPURPLE
        signUpNextButton.setTitle("Next", for: .normal)
        signUpNextButton.setTitleColor(.white, for: .normal)
        signUpNextButton.titleLabel?.font = .dynamicFont(with: "Octarine-Bold", style: .callout)
        signUpNextButton.titleLabel?.textAlignment = .center
        signUpNextButton.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 10.0, maxSize: 12.0), shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.2, shadowRadius: 8.0)
        signUpNextButton.isUserInteractionEnabled = false
        signUpNextButton.addTarget(self, action: #selector(transitionToNextPage(sender:)), for: .touchUpInside)
        signUpNextButton.alpha = 0.6
        
        signUpNextButton.translatesAutoresizingMaskIntoConstraints = false
        signUpNextButton.heightAnchor.constraint(equalToConstant: signUpNextButton.intrinsicContentSize.height+innerEdgeInset).isActive = true
        
        return signUpNextButton
        
    }()
    
    lazy private var switchToLoginTab: UIView = {
        
        let innerEdgeInset: CGFloat = .getPercentageWidth(percentage: 4)
        
        let switchToLoginButtonText = NSMutableAttributedString(string: "Already have an account? Log In", attributes: [.foregroundColor : UIColor.mainDARKPURPLE])
        let lightRange = switchToLoginButtonText.mutableString.range(of: "Already have an account?")
        let boldRange = switchToLoginButtonText.mutableString.range(of: "Log In")
        switchToLoginButtonText.addAttribute(.font, value: UIFont.dynamicFont(with: "Octarine-Light", style: .footnote), range: lightRange)
        switchToLoginButtonText.addAttribute(.font, value: UIFont.dynamicFont(with: "Octarine-Bold", style: .footnote), range: boldRange)
        
        let switchToLoginButton = BouncyButton(bouncyButtonImage: nil)
        switchToLoginButton.backgroundColor = .clear
        switchToLoginButton.setAttributedTitle(switchToLoginButtonText, for: .normal)
        switchToLoginButton.titleLabel?.textAlignment = .center
        switchToLoginButton.addTarget(self, action: #selector(switchToLogin(sender:)), for: .touchUpInside)
        
        let switchToLoginTabTopBorder = UIView()
        switchToLoginTabTopBorder.backgroundColor = .mainDARKPURPLE
        
        var switchToLoginTab = UIView()
        switchToLoginTab.backgroundColor = .white
        switchToLoginTab.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 14.0, maxSize: 16.0), shadowOpacity: 0.0, topRightMask: false, topLeftMask: false, bottomRightMask: true, bottomLeftMask: true)
        
        switchToLoginTab.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginTab.heightAnchor.constraint(equalToConstant: switchToLoginButton.intrinsicContentSize.height+innerEdgeInset+4.0).isActive = true
        
        switchToLoginTab.addSubview(switchToLoginTabTopBorder)
        switchToLoginTabTopBorder.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginTabTopBorder.topAnchor.constraint(equalTo: switchToLoginTab.topAnchor).isActive = true
        switchToLoginTabTopBorder.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        switchToLoginTabTopBorder.leadingAnchor.constraint(equalTo: switchToLoginTab.leadingAnchor).isActive = true
        switchToLoginTabTopBorder.trailingAnchor.constraint(equalTo: switchToLoginTab.trailingAnchor).isActive = true
        
        switchToLoginTab.addSubview(switchToLoginButton)
        switchToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginButton.topAnchor.constraint(equalTo: switchToLoginTabTopBorder.bottomAnchor).isActive = true
        switchToLoginButton.bottomAnchor.constraint(equalTo: switchToLoginTab.bottomAnchor, constant: -3.0).isActive = true
        switchToLoginButton.leadingAnchor.constraint(equalTo: switchToLoginTab.leadingAnchor).isActive = true
        switchToLoginButton.trailingAnchor.constraint(equalTo: switchToLoginTab.trailingAnchor).isActive = true
        
        return switchToLoginTab
        
    }()
    
    lazy private var backgroundImageView: UIImageView = {
        
        var backgroundImageView = UIImageView(image: UIImage.mainAppBackground)
        backgroundImageView.contentMode = .scaleAspectFill
        return backgroundImageView
        
    }()
    
    lazy private var poppinTitleLabel: UILabel = {
        
        var poppinTitleLabel = UILabel()
        poppinTitleLabel.font = .dynamicFont(with: "Octarine-Bold", style: .title1)
        poppinTitleLabel.textColor = .mainDARKPURPLE
        poppinTitleLabel.text = "poppin"
        poppinTitleLabel.textAlignment = .center
        
        poppinTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        poppinTitleLabel.heightAnchor.constraint(equalToConstant: poppinTitleLabel.intrinsicContentSize.height).isActive = true
        
        return poppinTitleLabel
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .poppinLIGHTGOLD
        
        let dismissKeyboardGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardGesture)
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(signUpContainerView)
        signUpContainerView.translatesAutoresizingMaskIntoConstraints = false
        signUpContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: loginInsetY).isActive = true
        signUpContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: loginInsetX).isActive = true
        signUpContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -loginInsetX).isActive = true
        signUpContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -loginInsetY).isActive = true
        
        view.addSubview(poppinTitleLabel)
        poppinTitleLabel.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: containerInsetY).isActive = true
        poppinTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    @objc private func dismissKeyboard() { view.endEditing(true) }
    
    @objc private func dismissDatePicker() {
        
        setDateFromPicker()
        dateOfBirthTextField.resignFirstResponder()
        
    }
    
    @objc private func setDateFromPicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
        
    }
    
    @objc private func textFieldDidChange() {
        
        if fullNameTextField.text != "" && dateOfBirthTextField.text != "" && !signUpNextButton.isUserInteractionEnabled {
            
            signUpNextButton.isUserInteractionEnabled = true
            signUpNextButton.alpha = 1.0
            
        } else if fullNameTextField.text == "" || dateOfBirthTextField.text == "" && signUpNextButton.isUserInteractionEnabled {
            
            signUpNextButton.isUserInteractionEnabled = false
            signUpNextButton.alpha = 0.6
            
        }
        
    }
    
    @objc private func transitionToNextPage(sender: BouncyButton) {
        
        let currentDate = Date()
        let dateOfBirth = datePicker.date
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: currentDate)
        let age = ageComponents.year
        
        var validSteps = 0
        
        if let fullName = fullNameTextField.text, fullName != "" {
            
            validSteps+=1
            
        } else {
            
            let button1 = AlertButton(alertTitle: "Try again", alertButtonAction: nil)
            let alertVC = NewAlertViewController(alertTitle: "Invalid name", alertMessage: "The entered name is invalid. Please try again.", alertButtons: [button1])
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
        if let age = age, age >= 13 {
            
            validSteps+=1
            
        } else {
            
            let button1 = AlertButton(alertTitle: "Ok", alertButtonAction: { [weak self] in
            
                guard let self = self else { return }
                
                self.navigationController?.popToRootViewController(animated: true)
            
            })
            
            let alertVC = NewAlertViewController(alertTitle: "Unable to proceed with the sign up", alertMessage: "It was not possible to proceed with the sign up. Thanks for checking out Poppin.", alertButtons: [button1])
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
        if validSteps == 2 {
            
            self.navigationController?.pushViewController(NewSignUpSecondPageViewController(fullName: fullNameTextField.text!, age: age!), animated: true)
            
        }
        
    }
    
    @objc private func switchToLogin(sender: BouncyButton) {
        
        if let firstAfterRootVC = navigationController?.viewControllers[1] as? NewLoginViewController {
            
            firstAfterRootVC.resetTextFields()
            navigationController?.popToViewController(firstAfterRootVC, animated: true)
            
        } else {
            
            navigationController?.pushViewController(NewLoginViewController(), animated: true)
            
        }
        
    }
    
    func resetTextFields() {
        
        fullNameTextField.text = ""
        dateOfBirthTextField.text = ""
        
        textFieldDidChange()
        
        datePicker.date = Date()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField == fullNameTextField {
            
            dateOfBirthTextField.becomeFirstResponder()
            
        }
        
        return true
        
    }
    
}

/*
 Second Page
 */

class NewSignUpSecondPageViewController: UIViewController, UITextFieldDelegate {
    
    let loginInsetY: CGFloat = .getPercentageWidth(percentage: 5)
    let loginInsetX: CGFloat = .getPercentageWidth(percentage: 5)
    let loginInnerInset: CGFloat = .getPercentageWidth(percentage: 4)
    
    let containerInsetY: CGFloat = .getPercentageWidth(percentage: 9)
    let containerInsetX: CGFloat = .getPercentageWidth(percentage: 9)
    
    let innerElementsSpacing: CGFloat = .getPercentageWidth(percentage: 3)
    
    private var fullName: String = ""
    private var age: Int = 0
    
    lazy private var signUpContainerView: UIView = {
        
        let contentStackViewSpacing: CGFloat = .getPercentageWidth(percentage: 6.5)
        
        let contentStackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, confirmPasswordStackView, signUpNextButton])
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.spacing = contentStackViewSpacing
        
        var signUpContainerView = UIView(frame: .zero)
        signUpContainerView.backgroundColor = .white
        signUpContainerView.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 14.0, maxSize: 16.0), shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.3, shadowRadius: 8.0)
        
        signUpContainerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: (containerInsetY*1.1)+poppinTitleLabel.intrinsicContentSize.height+contentStackViewSpacing).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: containerInsetX).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor, constant: -containerInsetX).isActive = true
        
        signUpContainerView.addSubview(poppinTitleLabel)
        poppinTitleLabel.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: containerInsetY).isActive = true
        poppinTitleLabel.centerXAnchor.constraint(equalTo: signUpContainerView.centerXAnchor).isActive = true
        
        signUpContainerView.addSubview(signUpBackButton)
        signUpBackButton.centerYAnchor.constraint(equalTo: poppinTitleLabel.centerYAnchor).isActive = true
        signUpBackButton.heightAnchor.constraint(equalTo: poppinTitleLabel.heightAnchor).isActive = true
        signUpBackButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor).isActive = true
        
        signUpContainerView.addSubview(switchToLoginTab)
        switchToLoginTab.bottomAnchor.constraint(equalTo: signUpContainerView.bottomAnchor).isActive = true
        switchToLoginTab.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor).isActive = true
        switchToLoginTab.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor).isActive = true
        
        return signUpContainerView
        
    }()
    
    lazy private var signUpBackButton: BouncyButton = {
        
        var signUpBackButton = BouncyButton(bouncyButtonImage: UIImage(systemSymbol: .arrowLeft).withTintColor(UIColor.mainDARKPURPLE))
        signUpBackButton.addTarget(self, action: #selector(transitionToPreviousPage(sender:)), for: .touchUpInside)
        
        signUpBackButton.translatesAutoresizingMaskIntoConstraints = false
        signUpBackButton.widthAnchor.constraint(equalTo: signUpBackButton.heightAnchor).isActive = true
        
        return signUpBackButton
        
    }()
    
    lazy private var emailStackView: UIStackView = {
        
        var emailStackView = UIStackView(arrangedSubviews: [emailTextField, invalidEmailLabel])
        emailStackView.axis = .vertical
        emailStackView.alignment = .fill
        emailStackView.distribution = .fill
        emailStackView.spacing = innerElementsSpacing
        return emailStackView
        
    }()
    
    lazy private var emailTextField: UITextField = {
        
        var emailTextField = UITextField()
        emailTextField.backgroundColor = .clear
        emailTextField.textColor = .mainDARKPURPLE
        emailTextField.font = .dynamicFont(with: "Octarine-Bold", style: .subheadline)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Light", style: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        emailTextField.delegate = self
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: emailTextField.intrinsicContentSize.height))
        emailTextField.leftViewMode = .always
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.returnKeyType = .next
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.heightAnchor.constraint(equalToConstant: emailTextField.intrinsicContentSize.height+(loginInnerInset*0.4)).isActive = true
        
        return emailTextField
        
    }()
    
    lazy private var invalidEmailLabel: UILabel = {
        
        var invalidEmailLabel = UILabel()
        invalidEmailLabel.backgroundColor = .clear
        invalidEmailLabel.sizeToFit()
        invalidEmailLabel.numberOfLines = 0
        invalidEmailLabel.textColor = .socialRED
        invalidEmailLabel.font = .dynamicFont(with: "Octarine-Bold", style: .caption2)
        invalidEmailLabel.text = "Please enter a valid email."
        invalidEmailLabel.isHidden = true
        
        return invalidEmailLabel
        
    }()
    
    lazy private var passwordStackView: UIStackView = {
        
        var passwordStackView = UIStackView(arrangedSubviews: [passwordTextField, invalidPasswordLabel])
        passwordStackView.axis = .vertical
        passwordStackView.alignment = .fill
        passwordStackView.distribution = .fill
        passwordStackView.spacing = innerElementsSpacing
        return passwordStackView
        
    }()
    
    lazy private var passwordTextField: UITextField = {
        
        var passwordTextField = UITextField()
        passwordTextField.backgroundColor = .clear
        passwordTextField.font = .dynamicFont(with: "Octarine-Bold", style: .subheadline)
        passwordTextField.textColor = .mainDARKPURPLE
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Light", style: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        passwordTextField.delegate = self
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: passwordTextField.intrinsicContentSize.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.returnKeyType = .next
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.heightAnchor.constraint(equalToConstant: passwordTextField.intrinsicContentSize.height+(loginInnerInset*0.4)).isActive = true
        
        return passwordTextField
        
    }()
    
    lazy private var invalidPasswordLabel: UILabel = {
        
        var invalidPasswordLabel = UILabel()
        invalidPasswordLabel.backgroundColor = .clear
        invalidPasswordLabel.sizeToFit()
        invalidPasswordLabel.numberOfLines = 0
        invalidPasswordLabel.textColor = .mainDARKPURPLE
        invalidPasswordLabel.font = .dynamicFont(with: "Octarine-Bold", style: .caption2)
        invalidPasswordLabel.text = "At least 8 characters, 1 upper case, and 1 digit."
        
        return invalidPasswordLabel
        
    }()
    
    lazy private var confirmPasswordStackView: UIStackView = {
        
        var confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordTextField, invalidConfirmPasswordLabel])
        confirmPasswordStackView.axis = .vertical
        confirmPasswordStackView.alignment = .fill
        confirmPasswordStackView.distribution = .fill
        confirmPasswordStackView.spacing = innerElementsSpacing
        return confirmPasswordStackView
        
    }()
    
    lazy private var confirmPasswordTextField: UITextField = {
        
        var confirmPasswordTextField = UITextField()
        confirmPasswordTextField.backgroundColor = .clear
        confirmPasswordTextField.font = .dynamicFont(with: "Octarine-Bold", style: .subheadline)
        confirmPasswordTextField.textColor = .mainDARKPURPLE
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Repeat password", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Light", style: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.textContentType = .oneTimeCode
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: confirmPasswordTextField.intrinsicContentSize.height))
        confirmPasswordTextField.leftViewMode = .always
        confirmPasswordTextField.clearButtonMode = .whileEditing
        confirmPasswordTextField.returnKeyType = .done
        confirmPasswordTextField.enablesReturnKeyAutomatically = true
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.autocorrectionType = .no
        confirmPasswordTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: confirmPasswordTextField.intrinsicContentSize.height+(loginInnerInset*0.4)).isActive = true
        
        return confirmPasswordTextField
        
    }()
    
    lazy private var invalidConfirmPasswordLabel: UILabel = {
        
        var invalidConfirmPasswordLabel = UILabel()
        invalidConfirmPasswordLabel.backgroundColor = .clear
        invalidConfirmPasswordLabel.sizeToFit()
        invalidConfirmPasswordLabel.numberOfLines = 0
        invalidConfirmPasswordLabel.textColor = .socialRED
        invalidConfirmPasswordLabel.font = .dynamicFont(with: "Octarine-Bold", style: .caption2)
        invalidConfirmPasswordLabel.text = "Password mismatch."
        invalidConfirmPasswordLabel.isHidden = true
        
        return invalidConfirmPasswordLabel
        
    }()
    
    lazy private var signUpNextButton: LoadingButton = {
        
        let innerEdgeInset: CGFloat = .getPercentageWidth(percentage: 2.5)
        
        var signUpNextButton = LoadingButton(loadingIndicatorColor: .white)
        signUpNextButton.backgroundColor = .mainDARKPURPLE
        signUpNextButton.setTitle("Next", for: .normal)
        signUpNextButton.setTitleColor(.white, for: .normal)
        signUpNextButton.titleLabel?.font = .dynamicFont(with: "Octarine-Bold", style: .callout)
        signUpNextButton.titleLabel?.textAlignment = .center
        signUpNextButton.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 10.0, maxSize: 12.0), shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.2, shadowRadius: 8.0)
        signUpNextButton.isUserInteractionEnabled = false
        signUpNextButton.addTarget(self, action: #selector(transitionToNextPage(sender:)), for: .touchUpInside)
        signUpNextButton.alpha = 0.6
        
        signUpNextButton.translatesAutoresizingMaskIntoConstraints = false
        signUpNextButton.heightAnchor.constraint(equalToConstant: signUpNextButton.intrinsicContentSize.height+innerEdgeInset).isActive = true
        
        return signUpNextButton
        
    }()
    
    lazy private var switchToLoginTab: UIView = {
        
        let innerEdgeInset: CGFloat = .getPercentageWidth(percentage: 4)
        
        let switchToLoginButtonText = NSMutableAttributedString(string: "Already have an account? Log In", attributes: [.foregroundColor : UIColor.mainDARKPURPLE])
        let lightRange = switchToLoginButtonText.mutableString.range(of: "Already have an account?")
        let boldRange = switchToLoginButtonText.mutableString.range(of: "Log In")
        switchToLoginButtonText.addAttribute(.font, value: UIFont.dynamicFont(with: "Octarine-Light", style: .footnote), range: lightRange)
        switchToLoginButtonText.addAttribute(.font, value: UIFont.dynamicFont(with: "Octarine-Bold", style: .footnote), range: boldRange)
        
        let switchToLoginButton = BouncyButton(bouncyButtonImage: nil)
        switchToLoginButton.backgroundColor = .clear
        switchToLoginButton.setAttributedTitle(switchToLoginButtonText, for: .normal)
        switchToLoginButton.titleLabel?.textAlignment = .center
        switchToLoginButton.addTarget(self, action: #selector(switchToLogin(sender:)), for: .touchUpInside)
        
        let switchToLoginTabTopBorder = UIView()
        switchToLoginTabTopBorder.backgroundColor = .mainDARKPURPLE
        
        var switchToLoginTab = UIView()
        switchToLoginTab.backgroundColor = .white
        switchToLoginTab.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 14.0, maxSize: 16.0), shadowOpacity: 0.0, topRightMask: false, topLeftMask: false, bottomRightMask: true, bottomLeftMask: true)
        
        switchToLoginTab.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginTab.heightAnchor.constraint(equalToConstant: switchToLoginButton.intrinsicContentSize.height+innerEdgeInset+4.0).isActive = true
        
        switchToLoginTab.addSubview(switchToLoginTabTopBorder)
        switchToLoginTabTopBorder.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginTabTopBorder.topAnchor.constraint(equalTo: switchToLoginTab.topAnchor).isActive = true
        switchToLoginTabTopBorder.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        switchToLoginTabTopBorder.leadingAnchor.constraint(equalTo: switchToLoginTab.leadingAnchor).isActive = true
        switchToLoginTabTopBorder.trailingAnchor.constraint(equalTo: switchToLoginTab.trailingAnchor).isActive = true
        
        switchToLoginTab.addSubview(switchToLoginButton)
        switchToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginButton.topAnchor.constraint(equalTo: switchToLoginTabTopBorder.bottomAnchor).isActive = true
        switchToLoginButton.bottomAnchor.constraint(equalTo: switchToLoginTab.bottomAnchor, constant: -3.0).isActive = true
        switchToLoginButton.leadingAnchor.constraint(equalTo: switchToLoginTab.leadingAnchor).isActive = true
        switchToLoginButton.trailingAnchor.constraint(equalTo: switchToLoginTab.trailingAnchor).isActive = true
        
        return switchToLoginTab
        
    }()
    
    lazy private var backgroundImageView: UIImageView = {
        
        var backgroundImageView = UIImageView(image: UIImage.mainAppBackground)
        backgroundImageView.contentMode = .scaleAspectFill
        return backgroundImageView
        
    }()
    
    lazy private var poppinTitleLabel: UILabel = {
        
        var poppinTitleLabel = UILabel()
        poppinTitleLabel.font = .dynamicFont(with: "Octarine-Bold", style: .title1)
        poppinTitleLabel.textColor = .mainDARKPURPLE
        poppinTitleLabel.text = "poppin"
        poppinTitleLabel.textAlignment = .center
        
        poppinTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        poppinTitleLabel.heightAnchor.constraint(equalToConstant: poppinTitleLabel.intrinsicContentSize.height).isActive = true
        
        return poppinTitleLabel
        
    }()
    
    init(fullName: String, age: Int) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.fullName = fullName
        self.age = age
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .poppinLIGHTGOLD
        
        let dismissKeyboardGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardGesture)
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(signUpContainerView)
        signUpContainerView.translatesAutoresizingMaskIntoConstraints = false
        signUpContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: loginInsetY).isActive = true
        signUpContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: loginInsetX).isActive = true
        signUpContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -loginInsetX).isActive = true
        signUpContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -loginInsetY).isActive = true
        
    }
    
    @objc private func dismissKeyboard() { view.endEditing(true) }
    
    @objc private func textFieldDidChange() {
        
        if emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" && !signUpNextButton.isUserInteractionEnabled {
            
            signUpNextButton.isUserInteractionEnabled = true
            signUpNextButton.alpha = 1.0
            
        } else if emailTextField.text == "" || passwordTextField.text == "" && confirmPasswordTextField.text == "" && signUpNextButton.isUserInteractionEnabled {
            
            signUpNextButton.isUserInteractionEnabled = false
            signUpNextButton.alpha = 0.6
            
        }
        
    }
    
    @objc private func transitionToNextPage(sender: BouncyButton) {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        let passwordFormat = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        
        view.endEditing(true)
        
        var validSteps: Int = 0
        
        if emailPredicate.evaluate(with: emailTextField.text) {
            
            validSteps+=1
            
        } else {
            
            emailTextField.setBottomBorder(color: .socialRED, height: 1.0)
            invalidEmailLabel.isHidden = false
            
        }
        
        if passwordPredicate.evaluate(with: passwordTextField.text) {
            
            validSteps+=1
            
        } else {
            
            passwordTextField.setBottomBorder(color: .socialRED, height: 1.0)
            invalidPasswordLabel.textColor = .socialRED
            
        }
        
        if passwordTextField.text == confirmPasswordTextField.text {
            
            validSteps+=1
            
        } else {
            
            confirmPasswordTextField.setBottomBorder(color: .socialRED, height: 1.0)
            invalidConfirmPasswordLabel.isHidden = false
            
        }
        
        if fullName != "" && age >= 13 {
            
            validSteps+=1
            
        } else {
            
            let button1 = AlertButton(alertTitle: "Ok", alertButtonAction: { [weak self] in
            
                guard let self = self else { return }
                
                self.navigationController?.popToRootViewController(animated: true)
            
            })
            
            let alertVC = NewAlertViewController(alertTitle: "Unable to proceed with the sign up", alertMessage: "It was not possible to proceed with the sign up. Thanks for checking out Poppin.", alertButtons: [button1])
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
        if validSteps == 4 {
            
            signUpNextButton.startLoading()
            view.isUserInteractionEnabled = false
            
            Auth.auth().fetchSignInMethods(forEmail: emailTextField.text!) { [weak self] (signInMethods, error) in
                
                guard let self = self else { return }
                
                self.signUpNextButton.stopLoading()
                self.view.isUserInteractionEnabled = true
                
                if error != nil {
                    
                    let errorCode = AuthErrorCode(rawValue: error!._code)
                    let errorTitle: String
                    let errorMessage: String
                    
                    var invalidEmailButton: AlertButton? = nil
                    
                    switch errorCode {
                        
                    case .invalidEmail:
                        
                        invalidEmailButton = AlertButton(alertTitle: "Try again", alertButtonAction: { [weak self] in
                            
                            guard let self = self else { return }
                            
                            self.emailTextField.setBottomBorder(color: .socialRED, height: 1.0)
                            self.invalidEmailLabel.isHidden = false
                            
                        })
                        
                        errorTitle = "Invalid email"
                        errorMessage = "The email you entered is invalid. Please try again."
                        
                    case .networkError:
                    
                        errorTitle = "Network is unstable"
                        errorMessage = "Please check your internet connection and try again."
                        
                    default:
                        
                        errorTitle = "Something went wrong"
                        errorMessage = "Please try again."
                        
                    }
                    
                    if let invalidEmailButton = invalidEmailButton {
                        
                        let alertVC = NewAlertViewController(alertTitle: errorTitle, alertMessage: errorMessage, alertButtons: [invalidEmailButton])
                        
                        self.present(alertVC, animated: true, completion: nil)
                        
                    } else {

                        let button1 = AlertButton(alertTitle: "Try again", alertButtonAction: nil)
                        let alertVC = NewAlertViewController(alertTitle: errorTitle, alertMessage: errorMessage, alertButtons: [button1])
                        
                        self.present(alertVC, animated: true, completion: nil)
                        
                    }
                    
                } else {
                    
                    if let signInMethods = signInMethods, signInMethods.count != 0 {
                        
                        let button1 = AlertButton(alertTitle: "Try again", alertButtonAction: nil)
                        let alertVC = NewAlertViewController(alertTitle: "Email is already in used", alertMessage: "The email you entered is already associated with an account. Please try again.", alertButtons: [button1])
                        
                        self.present(alertVC, animated: true, completion: nil)
                        
                    } else {
                        
                        self.navigationController?.pushViewController(NewSignUpThirdPageViewController(fullName: self.fullName, age: self.age, email: self.emailTextField.text!, password: self.passwordTextField.text!), animated: true)
                        
                    }
                    
                }
        
            }
            
        }
        
    }
    
    @objc private func switchToLogin(sender: BouncyButton) {
        
        if let firstAfterRootVC = navigationController?.viewControllers[1] as? NewLoginViewController {
            
            firstAfterRootVC.resetTextFields()
            navigationController?.popToViewController(firstAfterRootVC, animated: true)
            
        } else {
            
            navigationController?.pushViewController(NewLoginViewController(), animated: true)
            
        }
        
    }
    
    @objc private func transitionToPreviousPage(sender: BouncyButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func resetTextFields() {
        
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        
        textFieldDidChange()
        
        emailTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
        invalidEmailLabel.isHidden = true
        passwordTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
        invalidPasswordLabel.textColor = .mainDARKPURPLE
        confirmPasswordTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
        invalidConfirmPasswordLabel.isHidden = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField == emailTextField {
            
            passwordTextField.becomeFirstResponder()
            
        } else if textField == passwordTextField {
            
            confirmPasswordTextField.becomeFirstResponder()
            
        } else if textField == confirmPasswordTextField {
            
            transitionToNextPage(sender: signUpNextButton)
            
        }
        
        return true
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField && !invalidEmailLabel.isHidden {
            
            emailTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
            invalidEmailLabel.isHidden = true
            
        } else if textField == passwordTextField && invalidPasswordLabel.textColor.isEqual(UIColor.socialRED) {
            
            passwordTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
            invalidPasswordLabel.textColor = .mainDARKPURPLE
            
        } else if textField == confirmPasswordTextField && !invalidConfirmPasswordLabel.isHidden {
            
            confirmPasswordTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
            invalidConfirmPasswordLabel.isHidden = true
            
        }
        
        return true
        
    }
    
}

/*
 Third Page
*/

class NewSignUpThirdPageViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let loginInsetY: CGFloat = .getPercentageWidth(percentage: 5)
    let loginInsetX: CGFloat = .getPercentageWidth(percentage: 5)
    let loginInnerInset: CGFloat = .getPercentageWidth(percentage: 4)
    
    let containerInsetY: CGFloat = .getPercentageWidth(percentage: 9)
    let containerInsetX: CGFloat = .getPercentageWidth(percentage: 9)
    
    let innerElementsSpacing: CGFloat = .getPercentageWidth(percentage: 3)
    
    private var fullName: String = ""
    private var age: Int = 0
    private var email: String = ""
    private var password: String = ""
    
    private let termsLink = "Terms"
    private let privacyPolicyLink = "Privacy"
    
    lazy private var signUpContainerView: UIView = {
        
        let contentStackViewSpacing: CGFloat = .getPercentageWidth(percentage: 6.5)
        
        let contentStackView = UIStackView(arrangedSubviews: [usernameStackView, signUpButton, disclaimerTextView])
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.spacing = contentStackViewSpacing
        
        var signUpContainerView = UIView(frame: .zero)
        signUpContainerView.backgroundColor = .white
        signUpContainerView.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 14.0, maxSize: 16.0), shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.3, shadowRadius: 8.0)
        
        signUpContainerView.addSubview(poppinTitleLabel)
        poppinTitleLabel.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: containerInsetY).isActive = true
        poppinTitleLabel.centerXAnchor.constraint(equalTo: signUpContainerView.centerXAnchor).isActive = true
        
        signUpContainerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: (containerInsetY*1.1)+poppinTitleLabel.intrinsicContentSize.height+contentStackViewSpacing).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: containerInsetX).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor, constant: -containerInsetX).isActive = true
        
        signUpContainerView.addSubview(poppinTitleLabel)
        poppinTitleLabel.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: containerInsetY).isActive = true
        poppinTitleLabel.centerXAnchor.constraint(equalTo: signUpContainerView.centerXAnchor).isActive = true
        
        signUpContainerView.addSubview(signUpBackButton)
        signUpBackButton.centerYAnchor.constraint(equalTo: poppinTitleLabel.centerYAnchor).isActive = true
        signUpBackButton.heightAnchor.constraint(equalTo: poppinTitleLabel.heightAnchor).isActive = true
        signUpBackButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor).isActive = true
        
        signUpContainerView.addSubview(switchToLoginTab)
        switchToLoginTab.bottomAnchor.constraint(equalTo: signUpContainerView.bottomAnchor).isActive = true
        switchToLoginTab.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor).isActive = true
        switchToLoginTab.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor).isActive = true
        
        return signUpContainerView
        
    }()
    
    lazy private var signUpBackButton: BouncyButton = {
        
        var signUpBackButton = BouncyButton(bouncyButtonImage: UIImage(systemSymbol: .arrowLeft).withTintColor(UIColor.mainDARKPURPLE))
        signUpBackButton.addTarget(self, action: #selector(transitionToPreviousPage(sender:)), for: .touchUpInside)
        
        signUpBackButton.translatesAutoresizingMaskIntoConstraints = false
        signUpBackButton.widthAnchor.constraint(equalTo: signUpBackButton.heightAnchor).isActive = true
        
        return signUpBackButton
        
    }()
    
    lazy private var usernameStackView: UIStackView = {
        
        var usernameStackView = UIStackView(arrangedSubviews: [usernameTextField, invalidUsernameLabel])
        usernameStackView.axis = .vertical
        usernameStackView.alignment = .fill
        usernameStackView.distribution = .fill
        usernameStackView.spacing = innerElementsSpacing
        return usernameStackView
        
    }()
    
    lazy private var usernameTextField: UITextField = {
        
        var usernameTextField = UITextField()
        usernameTextField.backgroundColor = .clear
        usernameTextField.textColor = .mainDARKPURPLE
        usernameTextField.font = .dynamicFont(with: "Octarine-Bold", style: .subheadline)
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Light", style: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        usernameTextField.delegate = self
        usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: usernameTextField.intrinsicContentSize.height))
        usernameTextField.leftViewMode = .always
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.returnKeyType = .next
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        usernameTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.heightAnchor.constraint(equalToConstant: usernameTextField.intrinsicContentSize.height+(loginInnerInset*0.4)).isActive = true
        
        return usernameTextField
        
    }()
    
    lazy private var invalidUsernameLabel: UILabel = {
        
        var invalidUsernameLabel = UILabel()
        invalidUsernameLabel.backgroundColor = .clear
        invalidUsernameLabel.sizeToFit()
        invalidUsernameLabel.numberOfLines = 0
        invalidUsernameLabel.textColor = .mainDARKPURPLE
        invalidUsernameLabel.font = .dynamicFont(with: "Octarine-Bold", style: .caption2)
        invalidUsernameLabel.text = "3-15 characters (alphanumeric or underscore)."
        
        return invalidUsernameLabel
        
    }()
    
    lazy private var disclaimerTextView: UITextView = {
        
        let disclaimerText = NSMutableAttributedString(string: "By clicking Sign up, you agree to our Terms and Privacy Policy", attributes: [NSAttributedString.Key.font: UIFont.dynamicFont(with: "Octarine-Bold", style: .caption2)])
        let termsRange = disclaimerText.mutableString.range(of: "Terms")
        let privacyPolicyRange = disclaimerText.mutableString.range(of: "Privacy Policy")
        
        disclaimerText.addAttribute(.link, value: termsLink, range: termsRange)
        disclaimerText.addAttribute(.link, value: privacyPolicyLink, range: privacyPolicyRange)
        
        var disclaimerTextView = UITextView()
        disclaimerTextView.textContainerInset = .zero
        disclaimerTextView.attributedText = disclaimerText
        disclaimerTextView.linkTextAttributes = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE]
        disclaimerTextView.textColor = .mainDARKPURPLE
        disclaimerTextView.backgroundColor = .clear
        disclaimerTextView.isEditable = false
        disclaimerTextView.isSelectable = true
        disclaimerTextView.isScrollEnabled = false
        disclaimerTextView.delegate = self
        disclaimerTextView.textAlignment = .center
        return disclaimerTextView
        
    }()
    
    lazy private var signUpButton: LoadingButton = {
        
        let innerEdgeInset: CGFloat = .getPercentageWidth(percentage: 2.5)
        
        var signUpButton = LoadingButton(loadingIndicatorColor: .white)
        signUpButton.backgroundColor = .mainDARKPURPLE
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont.dynamicFont(with: "Octarine-Bold", style: .callout)
        signUpButton.titleLabel?.textAlignment = .center
        signUpButton.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 10.0, maxSize: 12.0), shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.2, shadowRadius: 8.0)
        signUpButton.isUserInteractionEnabled = false
        signUpButton.addTarget(self, action: #selector(performSignUp(sender:)), for: .touchUpInside)
        signUpButton.alpha = 0.6
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.heightAnchor.constraint(equalToConstant: signUpButton.intrinsicContentSize.height+innerEdgeInset).isActive = true
        
        return signUpButton
        
    }()
    
    lazy private var switchToLoginTab: UIView = {
        
        let innerEdgeInset: CGFloat = .getPercentageWidth(percentage: 4)
        
        let switchToLoginButtonText = NSMutableAttributedString(string: "Already have an account? Log In", attributes: [.foregroundColor : UIColor.mainDARKPURPLE])
        let lightRange = switchToLoginButtonText.mutableString.range(of: "Already have an account?")
        let boldRange = switchToLoginButtonText.mutableString.range(of: "Log In")
        switchToLoginButtonText.addAttribute(.font, value: UIFont.dynamicFont(with: "Octarine-Light", style: .footnote), range: lightRange)
        switchToLoginButtonText.addAttribute(.font, value: UIFont.dynamicFont(with: "Octarine-Bold", style: .footnote), range: boldRange)
        
        let switchToLoginButton = BouncyButton(bouncyButtonImage: nil)
        switchToLoginButton.backgroundColor = .clear
        switchToLoginButton.setAttributedTitle(switchToLoginButtonText, for: .normal)
        switchToLoginButton.titleLabel?.textAlignment = .center
        switchToLoginButton.addTarget(self, action: #selector(switchToLogin(sender:)), for: .touchUpInside)
        
        let switchToLoginTabTopBorder = UIView()
        switchToLoginTabTopBorder.backgroundColor = .mainDARKPURPLE
        
        var switchToLoginTab = UIView()
        switchToLoginTab.backgroundColor = .white
        switchToLoginTab.addShadowAndRoundCorners(cornerRadius: .getWidthFitSize(minSize: 14.0, maxSize: 16.0), shadowOpacity: 0.0, topRightMask: false, topLeftMask: false, bottomRightMask: true, bottomLeftMask: true)
        
        switchToLoginTab.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginTab.heightAnchor.constraint(equalToConstant: switchToLoginButton.intrinsicContentSize.height+innerEdgeInset+4.0).isActive = true
        
        switchToLoginTab.addSubview(switchToLoginTabTopBorder)
        switchToLoginTabTopBorder.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginTabTopBorder.topAnchor.constraint(equalTo: switchToLoginTab.topAnchor).isActive = true
        switchToLoginTabTopBorder.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        switchToLoginTabTopBorder.leadingAnchor.constraint(equalTo: switchToLoginTab.leadingAnchor).isActive = true
        switchToLoginTabTopBorder.trailingAnchor.constraint(equalTo: switchToLoginTab.trailingAnchor).isActive = true
        
        switchToLoginTab.addSubview(switchToLoginButton)
        switchToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        switchToLoginButton.topAnchor.constraint(equalTo: switchToLoginTabTopBorder.bottomAnchor).isActive = true
        switchToLoginButton.bottomAnchor.constraint(equalTo: switchToLoginTab.bottomAnchor, constant: -3.0).isActive = true
        switchToLoginButton.leadingAnchor.constraint(equalTo: switchToLoginTab.leadingAnchor).isActive = true
        switchToLoginButton.trailingAnchor.constraint(equalTo: switchToLoginTab.trailingAnchor).isActive = true
        
        return switchToLoginTab
        
    }()
    
    lazy private var backgroundImageView: UIImageView = {
        
        var backgroundImageView = UIImageView(image: UIImage.mainAppBackground)
        backgroundImageView.contentMode = .scaleAspectFill
        return backgroundImageView
        
    }()
    
    lazy private var poppinTitleLabel: UILabel = {
        
        var poppinTitleLabel = UILabel()
        poppinTitleLabel.font = .dynamicFont(with: "Octarine-Bold", style: .title1)
        poppinTitleLabel.textColor = .mainDARKPURPLE
        poppinTitleLabel.text = "poppin"
        poppinTitleLabel.textAlignment = .center
        
        poppinTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        poppinTitleLabel.heightAnchor.constraint(equalToConstant: poppinTitleLabel.intrinsicContentSize.height).isActive = true
        
        return poppinTitleLabel
        
    }()
    
    init(fullName: String, age: Int, email: String, password: String) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.fullName = fullName
        self.age = age
        self.email = email
        self.password = password
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .poppinLIGHTGOLD
        
        let dismissKeyboardGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardGesture)
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(signUpContainerView)
        signUpContainerView.translatesAutoresizingMaskIntoConstraints = false
        signUpContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: loginInsetY).isActive = true
        signUpContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: loginInsetX).isActive = true
        signUpContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -loginInsetX).isActive = true
        signUpContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -loginInsetY).isActive = true
        
    }
    
    @objc private func dismissKeyboard() { view.endEditing(true) }
    
    @objc private func textFieldDidChange() {
        
        if usernameTextField.text != "" && !signUpButton.isUserInteractionEnabled {
            
            signUpButton.isUserInteractionEnabled = true
            signUpButton.alpha = 1.0
            
        } else if usernameTextField.text == "" && signUpButton.isUserInteractionEnabled {
            
            signUpButton.isUserInteractionEnabled = false
            signUpButton.alpha = 0.6
            
        }
        
    }
    
    @objc private func transitionToPreviousPage(sender: BouncyButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func performSignUp(sender: BouncyButton) {
        
        let usernameFormat = "\\w{3,15}"
        let usernamePredicate = NSPredicate(format:"SELF MATCHES %@", usernameFormat)
        
        var validSteps: Int = 0
        
        if usernamePredicate.evaluate(with: usernameTextField.text) && usernameTextField.text?.range(of: "poppin", options: .caseInsensitive) == nil && usernameTextField.text?.range(of: "admin", options: .caseInsensitive) == nil {
            
            validSteps+=1
            
        } else {
            
            usernameTextField.setBottomBorder(color: .socialRED, height: 1.0)
            invalidUsernameLabel.textColor = .socialRED
            
        }
        
        if fullName != "" && age >= 13 && email != "" && password != "" {
            
            validSteps+=1
            
        } else {
            
            let button1 = AlertButton(alertTitle: "Ok", alertButtonAction: { [weak self] in
            
                guard let self = self else { return }
                
                self.navigationController?.popViewController(animated: true)
            
            })
            
            let alertVC = NewAlertViewController(alertTitle: "Unable to proceed with the sign up", alertMessage: "It was not possible to proceed with the sign up. Thanks for checking out Poppin.", alertButtons: [button1])
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
        if validSteps == 2 {
            
            self.navigationController?.dismiss(animated: true, completion: nil)
            
            /*signUpButton.startLoading()
            view.isUserInteractionEnabled = false
            
            // Check if username is in db
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
                
                guard let self = self else { return }
                
                if error != nil {
                    
                    self.signUpButton.stopLoading()
                    self.view.isUserInteractionEnabled = true
                    
                    let errorCode = AuthErrorCode(rawValue: error!._code)
                    let errorTitle: String
                    let errorMessage: String
                    
                    switch errorCode {
                        
                    case .emailAlreadyInUse:
                        
                        errorTitle = "Email is already in used"
                        errorMessage = "The email you entered is already associated with an account. Please try again."
                        
                    case .invalidEmail:
                        
                        errorTitle = "Invalid email"
                        errorMessage = "The email you entered is invalid. Please try again."
                        
                    case .networkError:
                        
                        errorTitle = "Network is unstable"
                        errorMessage = "Please check your internet connection and try again."
                        
                    default:
                        
                        errorTitle = "Something went wrong"
                        errorMessage = "Please try again."
                        
                    }
                    
                    let button1 = AlertButton(alertTitle: "Try again", alertButtonAction: nil)
                    let alertVC = NewAlertViewController(alertTitle: errorTitle, alertMessage: errorMessage, alertButtons: [button1])
                    
                    self.present(alertVC, animated: true, completion: nil)
                    
                } else {
                    
                    self.navigationController?.dismiss(animated: true, completion: nil)
                    
                }
                
            }*/
            
        }
        
    }
    
    @objc private func switchToLogin(sender: BouncyButton) {
        
        if let firstAfterRootVC = navigationController?.viewControllers[1] as? NewLoginViewController {
            
            firstAfterRootVC.resetTextFields()
            navigationController?.popToViewController(firstAfterRootVC, animated: true)
            
        } else {
            
            navigationController?.pushViewController(NewLoginViewController(), animated: true)
            
        }
        
    }
    
    func resetTextFields() {
        
        usernameTextField.text = ""
        
        textFieldDidChange()
        
        usernameTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
        invalidUsernameLabel.textColor = .mainDARKPURPLE
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if textField == usernameTextField {
            
            performSignUp(sender: signUpButton)
            
        }
        
        return true
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField && invalidUsernameLabel.textColor.isEqual(UIColor.socialRED) {
            
            usernameTextField.setBottomBorder(color: .mainDARKPURPLE, height: 1.0)
            invalidUsernameLabel.textColor = .mainDARKPURPLE
            
        }
        
        return true
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.absoluteString == "Terms" {
            
            // Future Action
            
            print("Showing Terms")
            
        } else if URL.absoluteString == "Privacy" {
            
            // Future Action
            
            print("Showing Privacy Policy")
            
        }
        
        return false
        
    }
    
}
