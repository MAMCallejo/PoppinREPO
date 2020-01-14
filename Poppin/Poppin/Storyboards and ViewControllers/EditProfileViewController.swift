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

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var about: UITextField!
    
    @IBOutlet weak var profilePic: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.clipsToBounds = true
        
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        
        profilePic.layer.borderWidth = 2

        getProfilePic()
               getUsername()
               getBio()
        // Do any additional setup after loading the view.
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
            func getProfilePic(){
               let uid = Auth.auth().currentUser!.uid
                  
              let reference = Storage.storage().reference().child( "images/\(uid)/profilepic.jpg")
              
              reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error != nil {
                  // Uh-oh, an error occurred!
                    
                } else {
                  
                  let pic = UIImage(data: data! )
                  self.profilePic.setImage(pic , for: UIControl.State.normal)
                }
              }
          }
    
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
        

    @IBAction func saveButtonPressed(button: UIButton){

        let uid = Auth.auth().currentUser!.uid
        
        let ref = Database.database().reference()
        ref.child("users/\(uid)/username").setValue(username.text)
        
        ref.child("users/\(uid)/bio").setValue(about.text)
                   self.dismiss(animated: true, completion: nil)
  
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
      
      }
}
