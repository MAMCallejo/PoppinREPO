//
//  popsicleInfoViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 1/18/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import FirebaseUI
import FirebaseStorage
import FirebaseDatabase

class popsicleInfoViewController : UIViewController, UIImagePickerControllerDelegate {
    
    weak var returnProtocol : createEventViewControllerReturnProtocol?
    
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var numRaters: UILabel!
    @IBOutlet weak var newRatingButton: UIButton!
    
    @IBOutlet weak var usersGoing: UIStackView!
    var usersGoingSpacing = 5.0
    @IBOutlet weak var goingButton: UIButton!
    
    var going = false
    var alreadyGoing = false
    
    var profiles: [String] = []
    var profilePicButton = UIButton()
    var profilePicButtons: [UIButton] = []
    
    /*
     Properties for the popsicle clicked...
     */
    var peventName: String!
    var peventInfo: String!
    var peventDate: String!
    var peventDuration: String!
    var peventCategory: String!
    var peventCategoryDetails: String!
    var peventSubcategory1: String!
    var peventSubcategory1Details: String!
    var peventImage: UIImage!
    
    @IBOutlet var popsicleInfoView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var topTextView: UIView!
    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var subcategoryView: UIView!
    
    // Labels in GUI to be set
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventInfo: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    //@IBOutlet weak var eventDuration: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var subcategoryImage: UIImageView!
    
    var gl:CAGradientLayer!
    var colorTop = UIColor(red: 255.0 / 255.0, green: 201.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0).cgColor
    var colorBottom = UIColor(red: 255.0 / 255.0, green: 179.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0).cgColor
    
    var currentUser = Auth.auth().currentUser
    
    // view did load function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        goingButton.layer.cornerRadius = 8
        
        ratingView.rating = 5
        numRaters.text = "1,165"
        
        // refresh the popsicle info view
        usersGoing.subviews.forEach({ $0.removeFromSuperview() }) // this gets things done
        usersGoing.spacing = CGFloat(usersGoingSpacing)
        usersGoing.tag = -1

        if(peventCategory == "Education") {
            colorTop = UIColor(red: 235.0 / 255.0, green: 166.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0).cgColor
            categoryLabel.text = "Education"
        } else if(peventCategory == "Food") {
            colorTop = UIColor(red: 255.0 / 255.0, green: 201.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0).cgColor
            categoryLabel.text = "Food"
        } else if(peventCategory == "Social") {
            colorTop = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0).cgColor
            categoryLabel.text = "Social"
        } else if(peventCategory == "Sports") {
            colorTop = UIColor(red: 127.0 / 255.0, green: 211.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0).cgColor
            categoryLabel.text = "Sports"
        } else if(peventCategory == "Shows") {
            colorTop = UIColor(red: 211.0 / 255.0, green: 147.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0).cgColor
            categoryLabel.text = "Shows"
        }
        
        // Set the bottom color in the gradient based on subcategory
        if(peventSubcategory1 == "First") {
            colorBottom = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventSubcategory1 == "Education") {
            colorBottom = UIColor(red: 235.0 / 255.0, green: 166.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventSubcategory1 == "Food") {
            colorBottom = UIColor(red: 255.0 / 255.0, green: 201.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventSubcategory1 == "Social") {
            colorBottom = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventSubcategory1 == "Sports") {
            colorBottom = UIColor(red: 127.0 / 255.0, green: 211.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventSubcategory1 == "Shows") {
            colorBottom = UIColor(red: 211.0 / 255.0, green: 147.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0).cgColor
        }
        
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        gl.frame = view.bounds
        frameView.layer.insertSublayer(gl, at: 0)
        
        // Makes the frame view have rounded corners.
        
        frameView.layer.cornerRadius = 15.0
        frameView.layer.masksToBounds = true
        frameView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        topTextView.layer.cornerRadius = 15.0
        topTextView.layer.masksToBounds = true
        topTextView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        // Disable the vertical scroll bar
        scrollView.showsVerticalScrollIndicator = false
        
        // Enhance scrolling animation pretty effects
        /*TO-DO*/
        
        // Set and display the data from the popsicle sent over the segue
        eventName.text = peventName
        eventInfo.text = peventInfo + "\n\n" + peventCategory + " details: " + peventCategoryDetails + "\n\n" + peventSubcategory1 + " details: " + peventSubcategory1Details
        
        let dur = Int(peventDuration)
        let hrs = dur! / 60
        let mins = dur! % 60
        
        var timeHrs = String(peventDate.suffix(5).prefix(2))
        let timeMins = String(peventDate.suffix(5).suffix(2))
        var ampm = ""
        if(Int(timeHrs)! > 12) {
            timeHrs = String(Int(timeHrs)! - 12)
            ampm = "pm"
        } else if(Int(timeHrs)! == 12) {
            ampm = "pm"
        } else {
            ampm = "am"
        }
        
        eventDate.text = timeHrs + ":" + timeMins + ampm + " for " + String(hrs) + " hrs"
        if(mins != 0) {
            eventDate.text! += " and " + String(mins) + " mins"
        }
        //eventDuration.text = peventDuration + " minutes"
        
        categoryImage.image = peventImage
        print(peventSubcategory1!)
        if(peventSubcategory1 == "First") {
            //subcategoryImage.image = UIImage(named: "categoryButtonNP")
            subcategoryImage.image = UIImage()
        } else if(peventSubcategory1 == "Education") {
            subcategoryImage.image = UIImage(named: "educationButton")
            categoryLabel.text! += " & Education"
        } else if(peventSubcategory1 == "Food") {
            subcategoryImage.image = UIImage(named: "foodButton")
            categoryLabel.text! += " & Food"
        } else if(peventSubcategory1 == "Social") {
            subcategoryImage.image = UIImage(named: "socialButton")
            categoryLabel.text! += " & Social"
        } else if(peventSubcategory1 == "Sports") {
            subcategoryImage.image = UIImage(named: "sportsButton")
            categoryLabel.text! += " & Sports"
        } else if(peventSubcategory1 == "Shows") {
            subcategoryImage.image = UIImage(named: "showsButton")
            categoryLabel.text! += " & Shows"
        }

        profiles = []
        
        let ref = Database.database().reference()
        // display all friends currently going
        var uids: [String] = []
        ref.child("currentPopsicles/\(peventName ?? "")").observeSingleEvent(of: .value, with: { (snapshot) in
          // ...
            let value = snapshot.value as? NSDictionary
            uids = value?["whosGoing"] as? [String] ?? []
            
            for uid in uids {
                
                let pB = UIButton()
                
                let reference = Storage.storage().reference().child( "images/\(uid)/profilepic.jpg")
                reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if error != nil {
                        // Uh-oh, an error occurred!
                        print("error")
                    } else {
                        let pic = UIImage(data: data! )
                        pB.setImage(pic, for: .normal)
                    }
                }
                
                self.profiles.append(uid)
                self.profilePicButtons.append(pB)
                //profilePicButton.tag = 111
                pB.tag = self.profiles.firstIndex(of: uid)!
                
                pB.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
                pB.clipsToBounds = true
                pB.layer.cornerRadius = pB.frame.size.width / 2
                //profilePicButton.layer.borderWidth = 0.1
                //profilePicButton.layer.borderColor = UIColor.mainDARKPURPLE?.cgColor
                
                NSLayoutConstraint(item: pB,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: 48).isActive = true

                NSLayoutConstraint(item: pB,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: 48).isActive = true
                
                // if theres too many profiles to display, stop adding to stack view
                if(self.profiles.count < 8) {
                    self.usersGoing.addArrangedSubview(pB)
                }
            }
            
            if(self.profiles.count == 2) {
                self.usersGoing.spacing = 5
            }else if(self.profiles.count == 3) {
                //usersGoing.spacing -= 15
                self.usersGoing.spacing = 5
            } else if(self.profiles.count == 4) {
                //usersGoing.spacing -= 10
                self.usersGoing.spacing = -11
            } else if(self.profiles.count > 7) {
                    // dont change spacing
            } else if(self.profiles.count == 5) {
                self.usersGoing.spacing = -15
            } else if(self.profiles.count == 6) {
                self.usersGoing.spacing = -19
            } else if(self.profiles.count == 7) {
                self.usersGoing.spacing = -22
            }
            
            if(self.profiles.contains(self.currentUser!.uid)) {
                self.alreadyGoing = true
                print("Already going")
                self.goingButton.setTitleColor(UIColor.white, for: .normal)
                self.goingButton.backgroundColor = UIColor(named: "sportsGREEN")
            }
            
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        
        //print(uids)
        
    }
    
    /*
     viewDidLayoutSubviews: Super useful function. It's called every time the view controller has to update...
     ...its views. Thus, most of the heavy styling is done here so that everything has been loaded before...
     ...applying the styling. It prevents certain errors with buttons and views not showing correctly.
     */
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()

        addShadowAndRoundCorners(currentView: moreInfoView)
        addShadowAndRoundCorners(currentView: dateView)
        addShadowAndRoundCorners(currentView: durationView)
        addShadowAndRoundCorners(currentView: categoryView)
        addShadowAndRoundCorners(currentView: subcategoryView)
        
    }
    
    /*
     addShadowAndRoundCorners: private helper method used mostly on viewDidLayoutSubviews in order to...
     ...add round corners and shadows to the views and buttons of the create event view.
     */
    
    private func addShadowAndRoundCorners (currentView: UIView) {
    
        currentView.layer.masksToBounds = false
        
        currentView.layer.cornerRadius = 15.0
        
        /*
        currentView.layer.shadowColor = UIColor.black.cgColor
        
        currentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        currentView.layer.shadowOpacity = 0.3
        
        currentView.layer.shadowRadius = 2
         */
    }
    
    @IBAction func addUserToGoingList(_ sender: Any) {
//        print("Current profiles: ")
//        print(profiles)
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser!.uid

        if(alreadyGoing) {
            
            goingButton.setTitleColor(UIColor.darkGray, for: .normal)
            goingButton.backgroundColor = UIColor.lightGray
            alreadyGoing = !alreadyGoing
            
            self.usersGoing.viewWithTag(profiles.firstIndex(of: uid)!)?.removeFromSuperview()
            profilePicButtons.remove(at: profiles.firstIndex(of: uid)!)
            profiles.remove(at: profiles.firstIndex(of: uid)!)
            
            ref.child("currentPopsicles/\(peventName ?? "")/whosGoing").setValue(profiles)
            
        } else if(going) {
            
            goingButton.setTitleColor(UIColor.darkGray, for: .normal)
            goingButton.backgroundColor = UIColor.lightGray
            going = !going
            
            self.usersGoing.viewWithTag(profiles.firstIndex(of: uid)!)?.removeFromSuperview()
            profilePicButtons.remove(at: profiles.firstIndex(of: uid)!)
            profiles.remove(at: profiles.firstIndex(of: uid)!)
            
            ref.child("currentPopsicles/\(peventName ?? "")/whosGoing").setValue(profiles)
            
        // else if not going and want to go
        } else {
            
            goingButton.setTitleColor(UIColor.white, for: .normal)
            goingButton.backgroundColor = UIColor(named: "sportsGREEN")
            going = !going
            
            let reference = Storage.storage().reference().child( "images/\(uid)/profilepic.jpg")
            reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error != nil {
                    // Uh-oh, an error occurred!
                    print("error")
                } else {
                    let pic = UIImage(data: data! )
                    self.profilePicButton.setImage(pic, for: .normal)
                }
            }
            
            profiles.append(uid)
            profilePicButton.tag = profiles.firstIndex(of: uid)!
            profilePicButtons.append(profilePicButton)
            
            profilePicButton.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
            profilePicButton.clipsToBounds = true
            profilePicButton.layer.cornerRadius = profilePicButton.frame.size.width / 2
            
            NSLayoutConstraint(item: profilePicButton,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 48).isActive = true

            NSLayoutConstraint(item: profilePicButton,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: 48).isActive = true
            
            // if theres too many profiles to display, stop adding to stack view
            if(profiles.count < 8) {
                //print(usersGoing)
                usersGoing.addArrangedSubview(profilePicButton)
            }
            
            ref.child("currentPopsicles/\(peventName ?? "")/whosGoing").setValue(profiles)
            
        }
        
        // Adjust spacing of stack view of profile pics
        if(profiles.count == 2) {
            usersGoing.spacing = 5
        }else if(profiles.count == 3) {
            //usersGoing.spacing -= 15
            usersGoing.spacing = 5
        } else if(profiles.count == 4) {
            //usersGoing.spacing -= 10
            usersGoing.spacing = -11
        } else if(profiles.count > 7) {
                // dont change spacing
        } else if(profiles.count == 5) {
            usersGoing.spacing = -15
        } else if(profiles.count == 6) {
            usersGoing.spacing = -19
        } else if(profiles.count == 7) {
            usersGoing.spacing = -22
        }
        
//        print("Profiles after press: ")
//        print(profiles)
    }
    
    @IBAction func closeView(_ sender: Any) {
        
        returnProtocol?.showMainButtons()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
