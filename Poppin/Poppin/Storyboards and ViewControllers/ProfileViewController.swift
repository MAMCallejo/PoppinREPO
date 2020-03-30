//
//  ProfileViewController.swift
//  
//
//  Created by Abdulrahman Ayad on 12/19/19.
//

import UIKit
import FirebaseUI
import FirebaseStorage
import FirebaseDatabase
import MobileCoreServices
import CoreLocation
import MapKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileBGView: UIImageView!
    
    @IBOutlet weak var profileContainerView: UIView!
    
    @IBOutlet weak var closeButton: loginButton!
    
    @IBOutlet weak var profilePicButton: loginButton!

    @IBOutlet weak var editButton: loginButton!
    
    @IBOutlet weak var usernameTitleLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var bioTitleLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    weak var returnProtocol : createEventViewControllerReturnProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("\nHello :D\n")
        
        profileContainerView.isHidden = true
        
        profileContainerView.alpha = 0.0
        
        // Do any additional setup after loading the view.
        
        //getProfilePic()
        
        getUsername()
        
        //getBio()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("\nHello :D\n")
        
        let endFrame:CGRect = profileContainerView.frame
        
        profileContainerView.frame = CGRect(origin: CGPoint(x: profileContainerView.frame.origin.x - (self.view.frame.size.width/2), y: profileContainerView.frame.origin.y), size: CGSize(width: profileContainerView.frame.size.width, height: profileContainerView.frame.size.height))
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() in
            
            self.profileContainerView.frame = endFrame
            
            self.profileContainerView.isHidden = false
            
            self.profileContainerView.alpha = 1.0
            
            self.view.layoutIfNeeded()
            
        }, completion:{(Bool) in
            
        })
        
    }
    
    override func viewDidLayoutSubviews() {
        
        profileContainerView.layer.masksToBounds = false
        
        profileContainerView.layer.cornerRadius = 15.0
        
        profileContainerView.layer.shadowColor = UIColor.black.cgColor
        
        profileContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        profileContainerView.layer.shadowOpacity = 0.3
        
        profileContainerView.layer.shadowRadius = 2
        
        profilePicButton.clipsToBounds = true
        
        profilePicButton.layer.cornerRadius = profilePicButton.frame.size.width / 2
        
        profilePicButton.layer.borderWidth = 2
        
        profilePicButton.layer.borderColor = UIColor.mainNAVYBLUE?.cgColor
        
    }
    
    func getProfilePic(){
        let uid = Auth.auth().currentUser!.uid
        
        let reference = Storage.storage().reference().child( "images/\(uid)/profilepic.jpg")
        
        reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Uh-oh, an error occurred!
                print("error")
            } else {
                
                let pic = UIImage(data: data! )
                self.profilePicButton.setImage(pic , for: UIControl.State.normal)
            }
        }
    }
    
    func getUsername(){
        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser!.uid
        ref.child("users/\(uid)/username").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? String
            
            self.usernameLabel.text = value
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func getBio(){
        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser!.uid
        ref.child("users/\(uid)/bio").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? String
            
            if (value == "") {
                
                self.bioLabel.text = "- No Bio Available -"
                
            } else {
                
                self.bioLabel.text = value
                
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func segueToEditProfileView(_ sender: Any) {
        
        let editProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "EditProfileVC") as EditProfileViewController
        
        let oldFrame:CGRect = profileContainerView.frame
        
        let endFrame:CGRect = CGRect(origin: CGPoint(x: profileContainerView.frame.origin.x - (self.view.frame.size.width/2), y: profileContainerView.frame.origin.y), size: CGSize(width: profileContainerView.frame.size.width, height: profileContainerView.frame.size.height))
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
            
            self.profileContainerView.frame = endFrame
            
            self.profileContainerView.alpha = 0.0
            
            self.view.layoutIfNeeded()
            
        }, completion:{(Bool) in
            
            self.profileContainerView.isHidden = true
            
            self.profileContainerView.alpha = 0.0
            
            self.profileContainerView.frame = oldFrame
            
            DispatchQueue.main.async {
                 
                self.navigationController?.pushViewController(editProfileVC, animated: false)
                
            }
            
        })
        
    }
    
    @IBAction func closeView(_ sender: Any) {
        
        returnProtocol?.showMainButtons()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
