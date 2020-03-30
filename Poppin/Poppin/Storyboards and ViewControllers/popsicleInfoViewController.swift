//
//  popsicleInfoViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 1/18/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class popsicleInfoViewController : UIViewController {
    
    weak var returnProtocol : createEventViewControllerReturnProtocol?
    
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
    @IBOutlet weak var eventDuration: UILabel!
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var subcategoryImage: UIImageView!
    
    var gl:CAGradientLayer!
    var colorTop = UIColor(red: 255.0 / 255.0, green: 201.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0).cgColor
    var colorBottom = UIColor(red: 255.0 / 255.0, green: 179.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0).cgColor
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set top color in the gradient based on main category of popsicle
        if(peventCategory == "Education") {
            colorTop = UIColor(red: 235.0 / 255.0, green: 166.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventCategory == "Food") {
            colorTop = UIColor(red: 255.0 / 255.0, green: 201.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventCategory == "Social") {
            colorTop = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventCategory == "Sports") {
            colorTop = UIColor(red: 127.0 / 255.0, green: 211.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0).cgColor
        } else if(peventCategory == "Shows") {
            colorTop = UIColor(red: 211.0 / 255.0, green: 147.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0).cgColor
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
        eventInfo.text = peventInfo
        eventDate.text = peventDate
        eventDuration.text = peventDuration + " minutes"
        
        categoryImage.image = peventImage
        print(peventSubcategory1!)
        if(peventSubcategory1 == "First") {
            subcategoryImage.image = UIImage(named: "categoryButtonNP")
        } else if(peventSubcategory1 == "Education") {
            subcategoryImage.image = UIImage(named: "educationButton")
        } else if(peventSubcategory1 == "Food") {
            subcategoryImage.image = UIImage(named: "foodButton")
        } else if(peventSubcategory1 == "Social") {
            subcategoryImage.image = UIImage(named: "socialButton")
        } else if(peventSubcategory1 == "Sports") {
            subcategoryImage.image = UIImage(named: "sportsButton")
        } else if(peventSubcategory1 == "Shows") {
            subcategoryImage.image = UIImage(named: "showsButton")
        }
    
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
    
    @IBAction func closeView(_ sender: Any) {
        returnProtocol?.showMainButtons()
        self.dismiss(animated: true, completion: nil)
    }
    
}
