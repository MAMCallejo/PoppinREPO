//
//  registerPageViewController.swift
//  Poppin
//
//  Created by Abdulrahman Ayad on 10/22/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class registerPageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registerPageBG: UIImageView!
    
    @IBOutlet weak var registerPageContainerView: UIView!
    
    @IBOutlet weak var registerPageStackView: UIStackView!
    
    @IBOutlet weak var registerPageTitleLabel: UILabel!
    
    @IBOutlet weak var registerPageUsernameTextField: UITextField!
    
    @IBOutlet weak var registerPageEmailTextField: UITextField!
    
    @IBOutlet weak var registerPagePasswordTextField: UITextField!
    
    @IBOutlet weak var registerPageNextButton: loginButton!
    
    @IBOutlet weak var registerPageBackButton: loginButton!
    
    var firstAppearance = true
    
    var viewIsMovedUp = false
    
    var distanceMoved: CGFloat = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
        
        registerPageUsernameTextField.delegate = self
        
        registerPageEmailTextField.delegate = self
        
        registerPagePasswordTextField.delegate = self
        
        registerPageBackButton.addTarget(self, action: #selector(returnToMainLogin), for: .touchUpInside)
        
        registerPageContainerView.isHidden = true
        
        registerPageBackButton.isHidden = true
        
        registerPageContainerView.alpha = 0.0
        
        registerPageBackButton.alpha = 0.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        registerPagePasswordTextField.isSecureTextEntry = true
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if (!viewIsMovedUp) {
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                if (self.view.frame.origin.y == 0) {
                    
                    self.view.frame.origin.y -= keyboardSize.height/2
                    
                    viewIsMovedUp = true
                    
                    distanceMoved = keyboardSize.height/2
                    
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
            
            let endFrameB:CGRect = registerPageBackButton.frame
            
            let endFrameC:CGRect = registerPageContainerView.frame
            
            registerPageBackButton.frame = CGRect(origin: CGPoint(x: registerPageBackButton.frame.origin.x + (self.view.frame.size.width/2), y: registerPageBackButton.frame.origin.y), size: CGSize(width: registerPageBackButton.frame.size.width, height: registerPageBackButton.frame.size.height))
            
            registerPageContainerView.frame = CGRect(origin: CGPoint(x: registerPageContainerView.frame.origin.x + (self.view.frame.size.width/2), y: registerPageContainerView.frame.origin.y), size: CGSize(width: registerPageContainerView.frame.size.width, height: registerPageContainerView.frame.size.height))
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() in
                
                self.registerPageContainerView.frame = endFrameC
                
                self.registerPageBackButton.frame = endFrameB
                
                self.registerPageContainerView.alpha = 1.0
                
                self.registerPageBackButton.alpha = 1.0
                
                self.registerPageContainerView.isHidden = false
                
                self.registerPageBackButton.isHidden = false
                
                self.view.layoutIfNeeded()
                
            }, completion:{(Bool) in
                
            })
            
            firstAppearance = false
            
        }
        
        registerPageContainerView.layer.masksToBounds = false
        
        registerPageContainerView.layer.cornerRadius = 8.0
        
        registerPageContainerView.layer.shadowColor = UIColor.black.cgColor
        
        registerPageContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        registerPageContainerView.layer.shadowOpacity = 0.3
        
        registerPageContainerView.layer.shadowRadius = 2
        
        registerPageNextButton.layer.masksToBounds = false
        
        registerPageNextButton.layer.cornerRadius = 8.0
        
        registerPageNextButton.layer.shadowColor = UIColor.black.cgColor
        
        registerPageNextButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        registerPageNextButton.layer.shadowOpacity = 0.3
        
        registerPageNextButton.layer.shadowRadius = 2
        
        registerPageUsernameTextField.layer.cornerRadius = 5
        
        registerPageUsernameTextField.layer.masksToBounds = true
        
        registerPageUsernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        registerPageUsernameTextField.layer.borderWidth = 1
        
        registerPageUsernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        registerPageEmailTextField.layer.cornerRadius = 5
        
        registerPageEmailTextField.layer.masksToBounds = true
        
        registerPageEmailTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        registerPageEmailTextField.layer.borderWidth = 1
        
        registerPageEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        registerPagePasswordTextField.layer.cornerRadius = 5
        
        registerPagePasswordTextField.layer.masksToBounds = true
        
        registerPagePasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        registerPagePasswordTextField.layer.borderWidth = 1
        
        registerPagePasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    @objc func returnToMainLogin () {
        
        if (registerPageUsernameTextField.isEditing || registerPageEmailTextField.isEditing || registerPagePasswordTextField.isEditing) {
            
            registerPageUsernameTextField.resignFirstResponder()
            
            registerPageEmailTextField.resignFirstResponder()
            
            registerPagePasswordTextField.resignFirstResponder()
            
            self.view.layoutIfNeeded()
            
        }
        
        if (registerPageUsernameTextField.text != "" || registerPageEmailTextField.text != "" || registerPagePasswordTextField.text != "") {
            
            let utils = Utils()
            
            let button1 = AlertButton(title: "Cancel", action: nil)
            
            let button2 = AlertButton(title: "Continue", action: {
             
                let endFrameB:CGRect = CGRect(origin: CGPoint(x: self.registerPageBackButton.frame.origin.x + (self.view.frame.size.width/2), y: self.registerPageBackButton.frame.origin.y), size: CGSize(width: self.registerPageBackButton.frame.size.width, height: self.registerPageBackButton.frame.size.height))
                
                let endFrameC:CGRect = CGRect(origin: CGPoint(x: self.registerPageContainerView.frame.origin.x + (self.view.frame.size.width/2), y: self.registerPageContainerView.frame.origin.y), size: CGSize(width: self.registerPageContainerView.frame.size.width, height: self.registerPageContainerView.frame.size.height))
                
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
                    
                    self.registerPageContainerView.frame = endFrameC
                    
                    self.registerPageBackButton.frame = endFrameB
                    
                    self.registerPageContainerView.alpha = 0.0
                    
                    self.registerPageBackButton.alpha = 0.0
                    
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
            
            let endFrameB:CGRect = CGRect(origin: CGPoint(x: self.registerPageBackButton.frame.origin.x + (self.view.frame.size.width/2), y: self.registerPageBackButton.frame.origin.y), size: CGSize(width: self.registerPageBackButton.frame.size.width, height: self.registerPageBackButton.frame.size.height))
            
            let endFrameC:CGRect = CGRect(origin: CGPoint(x: self.registerPageContainerView.frame.origin.x + (self.view.frame.size.width/2), y: self.registerPageContainerView.frame.origin.y), size: CGSize(width: self.registerPageContainerView.frame.size.width, height: self.registerPageContainerView.frame.size.height))
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
                
                self.registerPageContainerView.frame = endFrameC
                
                self.registerPageBackButton.frame = endFrameB
                
                self.registerPageContainerView.alpha = 0.0
                
                self.registerPageBackButton.alpha = 0.0
                
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
    
    @IBAction func registerPageNextButtonTapped(_ sender: Any) {
        
        if (registerPageUsernameTextField.isEditing || registerPageEmailTextField.isEditing || registerPagePasswordTextField.isEditing) {
            
            registerPageUsernameTextField.resignFirstResponder()
            
            registerPageEmailTextField.resignFirstResponder()
            
            registerPagePasswordTextField.resignFirstResponder()
            
            self.view.layoutIfNeeded()
            
        }
        
        if (registerPageUsernameTextField.text == "" || registerPageEmailTextField.text == "" || registerPagePasswordTextField.text == "") {
            
            let utils = Utils()
            
            let button1 = AlertButton(title: "Ok", action: nil)
            
            let alertPayload = AlertPayload(icon: UIImage.init(systemName: "xmark.circle.fill"), message: "Some information is missing, please fill it out.", buttons: [button1])
            
            utils.showAlert(payload: alertPayload, parentViewController: self)
            
        } else {
            
            Auth.auth().createUser(withEmail: registerPageEmailTextField.text!, password: registerPagePasswordTextField.text!, completion: { (authResult, error) in
                
                if (error != nil) {
                    
                    let errorCode = AuthErrorCode(rawValue: error!._code)
                    
                    var errorMessage = ""
                    
                    switch errorCode {
                        
                    case .emailAlreadyInUse:
                        
                        errorMessage = "The email is already in use. Please enter a new one."
                        
                    case .invalidEmail:
                        
                        errorMessage = "Invalid email. Please enter another one."
                        
                    case .weakPassword:
                        
                        errorMessage = "The Password is too weak. Please enter a longer one."
                        
                    default:
                        
                        errorMessage = "Oops! Something went wrong. Please try again."
                    }
                    
                    let utils = Utils()
                    
                    let button1 = AlertButton(title: "Ok", action: nil)
                    
                    let alertPayload = AlertPayload(icon: UIImage.init(systemName: "xmark.circle.fill"), message: errorMessage, buttons: [button1])
                    
                    utils.showAlert(payload: alertPayload, parentViewController: self)
                    
                } else {
                    
                    let newUser = authResult!.user
                    
                    let username = self.registerPageUsernameTextField.text
                    
                    let userAttrs = ["username": username]
                    
                    let ref = Database.database().reference().child("users").child(newUser.uid)
                    
                    ref.setValue(userAttrs) { (error, ref) in
                        
                        if let error = error {
                            
                            assertionFailure(error.localizedDescription)
                        }
                        
                        ref.observeSingleEvent(of: .value, with: { (snapshot) in
                            
                            let user = User(snapshot: snapshot)
                            
                            User.setCurrent(user!, writeToUserDefaults: true)
                            
                            print("Created new user: \(user!.username)")
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: .main)
                            
                            if let initialViewController = storyboard.instantiateInitialViewController() {
                                
                                guard let window = self.view.window else {

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
                    
                }
                
            })
            
        }
        
    }
        
}
