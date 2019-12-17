//
//  CreateUsernameViewController.swift
//  SignUp
//
//  Created by Abdulrahman Ayad on 10/22/19.
//  Copyright © 2019 Abdulrahman Ayad. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton){
        guard let firUser = Auth.auth().currentUser,
             let username = usernameTextField.text,
             !username.isEmpty else { return }

         UserService.create(firUser, username: username) { (user) in
             guard let user = user else { return }

            User.setCurrent(user, writeToUserDefaults: true)
            
             print("Created new user: \(user.username)")

            let storyboard = UIStoryboard(name: "Main", bundle: .main)

               if let initialViewController = storyboard.instantiateInitialViewController() {
                   self.view.window?.rootViewController = initialViewController
                   self.view.window?.makeKeyAndVisible()
               }
           }
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
