//
//  EditProfileViewController.swift
//  SignUp
//
//  Created by Abdulrahman Ayad on 11/13/19.
//  Copyright © 2019 Abdulrahman Ayad. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseStorage
import FirebaseDatabase
import MobileCoreServices

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var editProfileViewBG: UIImageView!
    
    @IBOutlet weak var editProfileViewContainerView: UIView!
    
    @IBOutlet weak var editProfileViewSaveButton: loginButton!
    
    @IBOutlet weak var editProfileViewUsernameLabel: UILabel!
    
    @IBOutlet weak var editProfileViewUsername: UITextField!
    
    @IBOutlet weak var editProfileViewBioLabel: UILabel!
    
    @IBOutlet weak var editProfileViewBio: UITextField!
    
    var firstAppearance = true
    
    var viewIsMovedUp = false
    
    var distanceMoved: CGFloat = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
        
        editProfileViewUsername.delegate = self
        
        editProfileViewBio.delegate = self
        
        editProfileViewContainerView.isHidden = true
        
        editProfileViewContainerView.alpha = 0.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
           
            let endFrameC:CGRect = editProfileViewContainerView.frame
            
            editProfileViewContainerView.frame = CGRect(origin: CGPoint(x: editProfileViewContainerView.frame.origin.x + (self.view.frame.size.width/2), y: editProfileViewContainerView.frame.origin.y), size: CGSize(width: editProfileViewContainerView.frame.size.width, height: editProfileViewContainerView.frame.size.height))
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() in
                
                self.editProfileViewContainerView.frame = endFrameC
                
                self.editProfileViewContainerView.alpha = 1.0
                
                self.editProfileViewContainerView.isHidden = false
                
                self.view.layoutIfNeeded()
                
            }, completion:{(Bool) in
                
            })
            
            firstAppearance = false
            
        }
        
        editProfileViewContainerView.layer.masksToBounds = false
        
        editProfileViewContainerView.layer.cornerRadius = 8.0
        
        editProfileViewContainerView.layer.shadowColor = UIColor.black.cgColor
        
        editProfileViewContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        editProfileViewContainerView.layer.shadowOpacity = 0.3
        
        editProfileViewContainerView.layer.shadowRadius = 2
        
        editProfileViewUsername.layer.cornerRadius = 5
        
        editProfileViewUsername.layer.masksToBounds = true
        
        editProfileViewUsername.layer.borderColor = UIColor.lightGray.cgColor
        
        editProfileViewUsername.layer.borderWidth = 1
        
        editProfileViewUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        editProfileViewBio.layer.cornerRadius = 5
        
        editProfileViewBio.layer.masksToBounds = true
        
        editProfileViewBio.layer.borderColor = UIColor.lightGray.cgColor
        
        editProfileViewBio.layer.borderWidth = 1
        
        editProfileViewBio.attributedPlaceholder = NSAttributedString(string: "Bio", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    //    func getProfilePic(){
    //            let uid = Auth.auth().currentUser!.uid
    //
    //           let reference = Storage.storage().reference().child( "images/\(uid)/profilepic.jpg")
    //
    //
    //           // UIImageView in your ViewController
    //           let imageView: UIImageView = self.profilePic
    //
    //           // Placeholder image
    //           let placeholderImage = UIImage(named: "placeholder.jpg")
    //
    //           // Load the image using SDWebImage
    //           imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
    
    /*
    @IBAction func addPicture(button: UIButton) {
        //        photoHelper.presentActionSheet(from: self)
        let profileImagePicker = UIImagePickerController()
        profileImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        profileImagePicker.mediaTypes = [kUTTypeImage as String]
        profileImagePicker.delegate = self
        present(profileImagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        if let profileImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let optimizedImageData = profileImage.jpegData(compressionQuality: 0.6)
        {
            // upload image from here
            
            uploadProfileImage(imageData: optimizedImageData)
            
        }
        picker.dismiss(animated: true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion:nil)
    }
    func uploadProfileImage(imageData: Data)
    {
        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        
        let storageReference = Storage.storage().reference()
        let uid = Auth.auth().currentUser!.uid
        
        let profileImageRef = storageReference.child("images/\(uid)/profilepic.jpg")
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        profileImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if error != nil
            {
                print("Error took place \(String(describing: error?.localizedDescription))")
                return
            } else {
                
                //                    self.profilePic.image =  UIImage(data: imageData)
                
                print("Meta data of uploaded image \(String(describing: uploadedImageMeta))")
            }
        }
    }
    */
    
    @IBAction func saveButtonPressed(button: UIButton){
        
        if (editProfileViewUsername.text != "") {
            
            let uid = Auth.auth().currentUser!.uid
            
            let ref = Database.database().reference()
            
            if (editProfileViewBio.text != "") {
                
                ref.child("users/\(uid)/bio").setValue(editProfileViewBio.text)
                
            }
            
            ref.child("users/\(uid)/username").setValue(editProfileViewUsername.text)
            
        } else if (editProfileViewBio.text != "") {
            
            let uid = Auth.auth().currentUser!.uid
            
            let ref = Database.database().reference()
            
            if (editProfileViewUsername.text != "") {
                
                ref.child("users/\(uid)/username").setValue(editProfileViewUsername.text)
                
            }
            
            ref.child("users/\(uid)/bio").setValue(editProfileViewBio.text)
            //print("BIOOOOOO")
        }
        
//        if (editProfileViewUsername.isEditing || editProfileViewBio.isEditing) {
//
//            editProfileViewUsername.resignFirstResponder()
//
//            editProfileViewBio.resignFirstResponder()
//
//            self.view.layoutIfNeeded()
//
//        }
        
        let endFrameC:CGRect = CGRect(origin: CGPoint(x: self.editProfileViewContainerView.frame.origin.x + (self.view.frame.size.width/2), y: self.editProfileViewContainerView.frame.origin.y), size: CGSize(width: self.editProfileViewContainerView.frame.size.width, height: self.editProfileViewContainerView.frame.size.height))
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {() in
            
            self.editProfileViewContainerView.frame = endFrameC
            
            self.editProfileViewContainerView.alpha = 0.0
            
            self.view.layoutIfNeeded()
            
        }, completion:{(Bool) in
            
            DispatchQueue.main.async {
                
                self.navigationController?.popViewController(animated: false)
                
            }
            
        })
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    /*
    func getUsername(){
        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser!.uid
        ref.child("users/\(uid)/username").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? String
            
            self.username.text = value
            
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
            
            self.about.text = value
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }*/
}
