//
//  UserService.swift
//  SignUp
//
//  Created by Abdulrahman Ayad on 10/30/19.
//  Copyright © 2019 Abdulrahman Ayad. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        
        let ref = Database.database().reference().child("users").child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let user = User(snapshot: snapshot) else {
                
                return completion(nil)
                
            }
            
            completion(user)
            
        })
        
    }
    
    static func create(_ firUser: User, username: String, completion: @escaping (User?) -> Void) {
        
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        ref.setValue(userAttrs) { (error, ref) in
            
            if let error = error {
                
                assertionFailure(error.localizedDescription)
                
                return completion(nil)
                
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let user = User(snapshot: snapshot)
                
                completion(user)
                
            })
            
        }
        
    }
    
    static func posts(for user: User, completion: @escaping ([Post]) -> Void) {
        
        let currentUser = User.current
        
        let uid = currentUser.uid
        
        let ref = Database.database().reference().child("images/\(uid)/profilePic/profilepic.jpg")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                
                return completion([])
                
            }
            
            let posts = snapshot.reversed().compactMap(Post.init)
            
            completion(posts)
            
        })
        
    }
    
}
