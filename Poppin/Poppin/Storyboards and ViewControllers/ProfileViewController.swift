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

    
    @IBOutlet weak var profilePic: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var about: UILabel!

    @IBOutlet weak var edit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.clipsToBounds = true
        
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        
        profilePic.layer.borderWidth = 2

        // Do any additional setup after loading the view.
        getProfilePic()
               getUsername()
               getBio()
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
            self.profilePic.setImage(pic , for: UIControl.State.normal)
          }
        }
    }
    
     func getUsername(){
         let ref = Database.database().reference()

         let uid = Auth.auth().currentUser!.uid
    ref.child("users/\(uid)/username").observeSingleEvent(of: .value, with: { (snapshot) in
      // Get user value
      let value = snapshot.value as? String
     
     self.name.text = value

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
    
    @IBAction func closeView(_ sender: Any) {
            
            self.dismiss(animated: true, completion: nil)
            
        
        
    }
    
    @IBAction func editProfile(sender: Any){
        performSegue(withIdentifier:"editProfile", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
