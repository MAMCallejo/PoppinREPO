//
//  loginPageViewController.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 2/18/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

class loginPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginPageBG: UIImageView!
    
    @IBOutlet weak var loginPageContainerView: UIView!
    
    @IBOutlet weak var loginPageStackView: UIStackView!
    
    @IBOutlet weak var loginPageTitleLabel: UILabel!
    
    @IBOutlet weak var loginPageEmailTextField: UITextField!
    
    @IBOutlet weak var loginPagePasswordTextField: UITextField!
    
    @IBOutlet weak var loginPageNextButton: loginButton!
    
    @IBOutlet weak var loginPageBackButton: loginButton!
    
    var firstAppearance = true
    
    var viewIsMovedUp = false
    
    var distanceMoved: CGFloat = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
        
        loginPageEmailTextField.delegate = self
        
        loginPagePasswordTextField.delegate = self
        
        loginPageBackButton.addTarget(self, action: #selector(returnToMainLogin), for: .touchUpInside)
        
        loginPageContainerView.isHidden = true
        
        loginPageContainerView.alpha = 0.0
        
        loginPageBackButton.isHidden = true
        
        loginPageBackButton.alpha = 0.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        loginPagePasswordTextField.isSecureTextEntry = true
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if (!viewIsMovedUp) {
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                if (self.view.frame.origin.y == 0) {
                    
                    self.view.frame.origin.y -= keyboardSize.height/2
                    
                    distanceMoved = keyboardSize.height/2
                    
                    viewIsMovedUp = true
                    
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if (viewIsMovedUp) {
            
            if (self.view.frame.origin.y != 0) {
                
                self.view.frame.origin.y += distanceMoved
                
                viewIsMovedUp = false
                
                self.view.layoutIfNeeded()
                
            }
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if (firstAppearance) {
            
            let endFrameB:CGRect = loginPageBackButton.frame
            
            let endFrameC:CGRect = loginPageContainerView.frame
            
            loginPageBackButton.frame = CGRect(origin: CGPoint(x: loginPageBackButton.frame.origin.x + (self.view.frame.size.width/2), y: loginPageBackButton.frame.origin.y), size: CGSize(width: loginPageBackButton.frame.size.width, height: loginPageBackButton.frame.size.height))
            
            loginPageContainerView.frame = CGRect(origin: CGPoint(x: loginPageContainerView.frame.origin.x + (self.view.frame.size.width/2), y: loginPageContainerView.frame.origin.y), size: CGSize(width: loginPageContainerView.frame.size.width, height: loginPageContainerView.frame.size.height))
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() in
                
                self.loginPageContainerView.alpha = 1.0
                
                self.loginPageBackButton.alpha = 1.0
                
                self.loginPageContainerView.isHidden = false
                
                self.loginPageBackButton.isHidden = false
                
                self.loginPageContainerView.frame = endFrameC
                
                self.loginPageBackButton.frame = endFrameB
                
                self.view.layoutIfNeeded()
                
            }, completion:{(Bool) in
                
            })
            
            firstAppearance = false
            
        }
        
        loginPageContainerView.layer.masksToBounds = false
        
        loginPageContainerView.layer.cornerRadius = 8.0
        
        loginPageContainerView.layer.shadowColor = UIColor.black.cgColor
        
        loginPageContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        loginPageContainerView.layer.shadowOpacity = 0.3
        
        loginPageContainerView.layer.shadowRadius = 2
        
        loginPageNextButton.layer.masksToBounds = false
        
        loginPageNextButton.layer.cornerRadius = 8.0
        
        loginPageNextButton.layer.shadowColor = UIColor.black.cgColor
        
        loginPageNextButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        loginPageNextButton.layer.shadowOpacity = 0.3
        
        loginPageNextButton.layer.shadowRadius = 2
        
        loginPageEmailTextField.layer.cornerRadius = 5
        
        loginPageEmailTextField.layer.masksToBounds = true
        
        loginPageEmailTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        loginPageEmailTextField.layer.borderWidth = 1
        
        loginPageEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        loginPagePasswordTextField.layer.cornerRadius = 5
        
        loginPagePasswordTextField.layer.masksToBounds = true
        
        loginPagePasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        loginPagePasswordTextField.layer.borderWidth = 1
        
        loginPagePasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    @objc func returnToMainLogin () {
        
        if (loginPagePasswordTextField.isEditing || loginPageEmailTextField.isEditing) {
            
            loginPagePasswordTextField.resignFirstResponder()
            
            loginPageEmailTextField.resignFirstResponder()
            
            self.view.layoutIfNeeded()
            
        }
        
        if (loginPageEmailTextField.text != "" || loginPagePasswordTextField.text != "") {
            
            let utils = Utils()
            
            let button1 = AlertButton(title: "Cancel", action: nil)
            
            let button2 = AlertButton(title: "Continue", action: {
                
                NotificationCenter.default.removeObserver(self)
                
                NotificationCenter.default.removeObserver(self)
                
                let endFrameB:CGRect = CGRect(origin: CGPoint(x: self.loginPageBackButton.frame.origin.x + (self.view.frame.size.width/2), y: self.loginPageBackButton.frame.origin.y), size: CGSize(width: self.loginPageBackButton.frame.size.width, height: self.loginPageBackButton.frame.size.height))
                
                let endFrameC:CGRect = CGRect(origin: CGPoint(x: self.loginPageContainerView.frame.origin.x + (self.view.frame.size.width/2), y: self.loginPageContainerView.frame.origin.y), size: CGSize(width: self.loginPageContainerView.frame.size.width, height: self.loginPageContainerView.frame.size.height))
                
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
                    
                    self.loginPageContainerView.frame = endFrameC
                    
                    self.loginPageContainerView.alpha = 0.0
                    
                    self.loginPageBackButton.frame = endFrameB
                    
                    self.loginPageBackButton.alpha = 0.0
                    
                    self.view.layoutIfNeeded()
                    
                }, completion:{(Bool) in
                    
                    DispatchQueue.main.async {
                        
                        self.navigationController?.popViewController(animated: false)
                        
                    }
                    
                })
                
            })
            
            let alertPayload = AlertPayload(icon: UIImage.init(systemName: "exclamationmark.triangle.fill"), message: "If you proceed, some information will be lost.", buttons: [button1, button2])
            
            utils.showAlert(payload: alertPayload, parentViewController: self)
            
        } else {
            
            NotificationCenter.default.removeObserver(self)
            
            NotificationCenter.default.removeObserver(self)
            
            let endFrameB:CGRect = CGRect(origin: CGPoint(x: self.loginPageBackButton.frame.origin.x + (self.view.frame.size.width/2), y: self.loginPageBackButton.frame.origin.y), size: CGSize(width: self.loginPageBackButton.frame.size.width, height: self.loginPageBackButton.frame.size.height))
            
            let endFrameC:CGRect = CGRect(origin: CGPoint(x: self.loginPageContainerView.frame.origin.x + (self.view.frame.size.width/2), y: self.loginPageContainerView.frame.origin.y), size: CGSize(width: self.loginPageContainerView.frame.size.width, height: self.loginPageContainerView.frame.size.height))
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
                
                self.loginPageContainerView.frame = endFrameC
                
                self.loginPageContainerView.alpha = 0.0
                
                self.loginPageBackButton.frame = endFrameB
                
                self.loginPageBackButton.alpha = 0.0
                
                self.view.layoutIfNeeded()
                
            }, completion:{(Bool) in
                
                DispatchQueue.main.async {
                    
                    self.navigationController?.popViewController(animated: false)
                    
                }
                
            })
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    @IBAction func loginPageNextButtonTapped(_ sender: Any) {
        
        if (loginPageEmailTextField.isEditing || loginPagePasswordTextField.isEditing) {
            
            loginPageEmailTextField.resignFirstResponder()
            
            loginPagePasswordTextField.resignFirstResponder()
            
            self.view.layoutIfNeeded()
            
        }
        
        if (loginPageEmailTextField.text == "" || loginPagePasswordTextField.text == "") {
            
            let utils = Utils()
            
            let button1 = AlertButton(title: "Ok", action: nil)
            
            let alertPayload = AlertPayload(icon: UIImage.init(systemName: "xmark.circle.fill"), message: "Some information is missing, please fill it out.", buttons: [button1])
            
            utils.showAlert(payload: alertPayload, parentViewController: self)
            
        } else {
            
            Auth.auth().signIn(withEmail: loginPageEmailTextField.text!, password: loginPagePasswordTextField.text!, completion: { [weak self] authResult, error in
                
                guard let strongSelf = self else {return}
                
                if (error != nil) {
                    
                    let errorCode = AuthErrorCode(rawValue: error!._code)
                    
                    var errorMessage = ""
                    
                    switch errorCode {
                        
                    case .userNotFound:
                        
                        errorMessage = "No user found with that email. Please try another one."
                        
                    case .invalidEmail:
                        
                        errorMessage = "Invalid email. Please enter another one."
                        
                    case .wrongPassword:
                        
                        errorMessage = "The Password is incorrect. Please enter another one."
                        
                    default:
                        
                        errorMessage = "Oops! Something went wrong. Please try again."
                    }
                    
                    let utils = Utils()
                    
                    let button1 = AlertButton(title: "Ok", action: nil)
                    
                    let alertPayload = AlertPayload(icon: UIImage.init(systemName: "xmark.circle.fill"), message: errorMessage, buttons: [button1])
                    
                    utils.showAlert(payload: alertPayload, parentViewController: strongSelf)
                    
                } else {
                    
                    let newUser = authResult!.user
                    
                    let ref = Database.database().reference().child("users").child(newUser.uid)
                    
                    ref.observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let user = User(snapshot: snapshot)
                        
                        User.setCurrent(user!, writeToUserDefaults: true)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                        
                        if let initialViewController = storyboard.instantiateInitialViewController() {
                            
                            guard let window = strongSelf.view.window else {

                                return

                            }

                            let transition = CATransition()

                            transition.type = .fade

                            transition.duration = 0.5

                            window.layer.add(transition, forKey: kCATransition)

                            window.rootViewController = initialViewController

                            window.makeKeyAndVisible()
                            
                        }
                        
                    })
                    
                }
                
            })
            
        }
        
    }
    
}
