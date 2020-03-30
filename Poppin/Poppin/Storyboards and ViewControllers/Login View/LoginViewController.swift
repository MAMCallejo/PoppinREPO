//
//  LoginViewController.swift
//  SignUp
//
//  Created by Abdulrahman Ayad on 10/13/19.
//  Copyright © 2019 Abdulrahman Ayad. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var loginBG: UIImageView!
    
    @IBOutlet weak var loginContainerView: UIView!
    
    @IBOutlet weak var loginLogo: UIImageView!
    
    @IBOutlet weak var loginWelcomeLabel: UILabel!
    
    @IBOutlet weak var loginInfoLabel: UILabel!
    
    @IBOutlet weak var loginButton: loginButton!
    
    @IBOutlet weak var loginRegisterButton: loginButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginContainerView.isHidden = true
        
        loginContainerView.alpha = 0.0
        
        loginButton.addTarget(self, action: #selector(segueToLogin), for: .touchUpInside)
        
        loginRegisterButton.addTarget(self, action: #selector(segueToRegister), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let endFrame:CGRect = loginContainerView.frame
        
        loginContainerView.frame = CGRect(origin: CGPoint(x: loginContainerView.frame.origin.x - (self.view.frame.size.width/2), y: loginContainerView.frame.origin.y), size: CGSize(width: loginContainerView.frame.size.width, height: loginContainerView.frame.size.height))
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() in
            
            self.loginContainerView.frame = endFrame
            
            self.loginContainerView.isHidden = false
            
            self.loginContainerView.alpha = 1.0
            
            self.view.layoutIfNeeded()
            
        }, completion:{(Bool) in
            
        })
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        loginContainerView.layer.masksToBounds = false
        
        loginContainerView.layer.cornerRadius = 8.0
        
        loginContainerView.layer.shadowColor = UIColor.black.cgColor
        
        loginContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        loginContainerView.layer.shadowOpacity = 0.3
        
        loginContainerView.layer.shadowRadius = 2
        
        loginButton.layer.masksToBounds = false
        
        loginButton.layer.cornerRadius = 8.0
        
        loginButton.layer.shadowColor = UIColor.black.cgColor
        
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        loginButton.layer.shadowOpacity = 0.3
        
        loginButton.layer.shadowRadius = 2
        
        loginRegisterButton.layer.masksToBounds = false
        
        loginRegisterButton.layer.cornerRadius = 8.0
        
        loginRegisterButton.layer.shadowColor = UIColor.black.cgColor
        
        loginRegisterButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        loginRegisterButton.layer.shadowOpacity = 0.3
        
        loginRegisterButton.layer.shadowRadius = 2
        
    }
    
    @objc func segueToLogin () {
        
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "loginPageViewController") as loginPageViewController
        
        let oldFrame:CGRect = loginContainerView.frame
        
        let endFrame:CGRect = CGRect(origin: CGPoint(x: loginContainerView.frame.origin.x - (self.view.frame.size.width/2), y: loginContainerView.frame.origin.y), size: CGSize(width: loginContainerView.frame.size.width, height: loginContainerView.frame.size.height))
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
            
            self.loginContainerView.frame = endFrame
            
            self.loginContainerView.alpha = 0.0
            
            self.view.layoutIfNeeded()
            
        }, completion:{(Bool) in
            
            self.loginContainerView.isHidden = true
            
            self.loginContainerView.alpha = 0.0
            
            self.loginContainerView.frame = oldFrame
            
            DispatchQueue.main.async {
                
                 self.navigationController?.pushViewController(loginVC, animated: false)
                
            }
            
        })
        
    }
    
    @objc func segueToRegister () {
        
        let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "registerPageViewController") as registerPageViewController
        
        let oldFrame:CGRect = loginContainerView.frame
        
        let endFrame:CGRect = CGRect(origin: CGPoint(x: loginContainerView.frame.origin.x - (self.view.frame.size.width/2), y: loginContainerView.frame.origin.y), size: CGSize(width: loginContainerView.frame.size.width, height: loginContainerView.frame.size.height))
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
            
            self.loginContainerView.frame = endFrame
            
            self.loginContainerView.alpha = 0.0
            
            self.view.layoutIfNeeded()
            
        }, completion:{(Bool) in
            
            self.loginContainerView.isHidden = true
            
            self.loginContainerView.alpha = 0.0
            
            self.loginContainerView.frame = oldFrame
            
            DispatchQueue.main.async {
                
                 self.navigationController?.pushViewController(registerVC, animated: false)
                
            }
            
        })
        
    }
    
}
