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

protocol editProfileViewControllerReturnProtocol : NSObjectProtocol {
    
    func setProfileInfo(newUsername: String?, newBio: String?)
    
}

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, editProfileViewControllerReturnProtocol {
    
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var profileBGView: UIImageView!
    
    @IBOutlet weak var profileContainerView: UIView!
    
    @IBOutlet weak var closeButton: loginButton!
    
    @IBOutlet weak var profilePicButton: UIButton!

    @IBOutlet weak var editButton: loginButton!
    
    @IBOutlet weak var usernameTitleLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var bioTitleLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    weak var returnProtocol : profileViewControllerReturnProtocol?
    
    var profilePic : UIImage?
    
    var username: String?
    
    var profilePicWasChanged = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("\nHello :D\n")
        
        profileContainerView.isHidden = true
        
        profileContainerView.alpha = 0.0
        
        // Do any additional setup after loading the view.
        
        profilePicButton.setImage(profilePic, for: .normal)
        
        usernameLabel.text = username
        
        getBio()
        
        imagePicker =  UIImagePickerController()
        
        imagePicker.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("\nHello :D we back to the profile view\n")
        
        //update user credentials
        
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
        
        profilePicButton.contentHorizontalAlignment = .fill
        
        profilePicButton.contentVerticalAlignment = .fill
        
        profilePicButton.imageView?.contentMode = .scaleAspectFill
        
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
    
    public func setProfileInfo(newUsername: String?, newBio: String?) {
        
        if (newUsername != nil && usernameLabel.text != newUsername) {
            
            usernameLabel.text = newUsername
            
        }
        
        if (newBio != nil && bioLabel.text != newBio) {
            
            bioLabel.text = newBio
            
        }
        
    }
    
    @IBAction func segueToEditProfileView(_ sender: Any) {
        
        let editProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "EditProfileVC") as EditProfileViewController
        
        editProfileVC.returnProtocol = self
        
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
    
    @IBAction func changeProfilePic(_ sender: Any) {

        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallery()
    {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cameraImage = info[.editedImage] as? UIImage
        
        self.profilePicButton.setImage(cameraImage, for: UIControl.State.normal)
        
        self.profilePicButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFill;
        
        let uid = Auth.auth().currentUser!.uid
        let ref = Storage.storage().reference().child( "images/\(uid)/profilepic.jpg")
        
        ref.putData((cameraImage?.jpegData(compressionQuality: 0.3))!, metadata: nil)
        { (_, error) in
            
            self.imagePicker.dismiss(animated: true, completion: nil)
            
            if error != nil
            {
                print("Error took place \(String(describing: error?.localizedDescription))")
                return
            }
            
            self.profilePicWasChanged = true
            
        }
        
    }
    
    @IBAction func closeView(_ sender: Any) {
        
        if (profilePicWasChanged) {
            
            returnProtocol?.setUserInfo(newProfilePic: (profilePicButton.imageView?.image)!, newUsername: usernameLabel.text!)
            
        } else {
            
            returnProtocol?.setUserInfo(newProfilePic: nil, newUsername: usernameLabel.text!)
            
        }
        
        returnProtocol?.showMainButtons()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
