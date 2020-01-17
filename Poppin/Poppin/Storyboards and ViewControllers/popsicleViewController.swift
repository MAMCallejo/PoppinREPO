//
//  popsicleViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 1/10/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class popsicleViewController : UIViewController {
    
    // *** DECLARATION OF USEFUL VARIABLES FOR THE CREATE EVENT VIEW CONTROLLER ***
      
          // ** IBOutlets ***
      
              // Main Views (top of the IB hirearchy).
      
      @IBOutlet weak var frameView: UIView!
      
      @IBOutlet weak var createEventView: UIScrollView!
      
      @IBOutlet weak var subviewsStackView: UIStackView!
      
      @IBOutlet weak var topTextView: UIView!
      
      @IBOutlet weak var topText: UILabel!

      @IBOutlet weak var returnButton: UIButton!
      
      @IBOutlet weak var doneButton: doneButton!
      
              // Name View variables inside the StackView:
      
      @IBOutlet weak var nameView: UIView!
      
      @IBOutlet weak var nameLabel: UILabel!
      
      @IBOutlet weak var nameTextView: UITextView!
      
      @IBOutlet weak var nameMaxLabel: UILabel!
      
              // Info View variables inside the StackView:
      
      @IBOutlet weak var infoView: UIView!
      
      @IBOutlet weak var infoLabel: UILabel!
      
      @IBOutlet weak var infoTextView: UITextView!
      
      @IBOutlet weak var infoMaxLabel: UILabel!
      
              // Date View variables inside the StackView:
      
      @IBOutlet weak var dateView: UIView!
      
      @IBOutlet weak var dateLabel: UILabel!
      
      @IBOutlet weak var dateTextField: UITextField!
      
              // Duration View variables inside the StackView:
      
      @IBOutlet weak var durationView: UIView!
      
      @IBOutlet weak var durationLabel: UILabel!
      
      @IBOutlet weak var durationTextField: UITextField!
      
              // Category Picker View Elements inside the StackView:
      
      @IBOutlet weak var categoryPickerView: UIView!
      
      @IBOutlet weak var categoryLabel: UILabel!
      
      @IBOutlet weak var categoryButtonsStackView: UIStackView!
      
              // Education Category (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var educationCategoryView: categoryButtonView!
      
      @IBOutlet weak var educationCategoryIcon: UIImageView!
      
      @IBOutlet weak var educationLegendLabel: UILabel!
      
      @IBOutlet weak var educationButton: UIButton!
      
              // Food Category (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var foodCategoryView: categoryButtonView!
      
      @IBOutlet weak var foodCategoryIcon: UIImageView!
      
      @IBOutlet weak var foodLegendLabel: UILabel!
      
      @IBOutlet weak var foodButton: UIButton!
      
              // Social Category (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var socialCategoryView: categoryButtonView!
      
      @IBOutlet weak var socialCategoryIcon: UIImageView!
      
      @IBOutlet weak var socialLegendLabel: UILabel!
      
      @IBOutlet weak var socialButton: UIButton!
      
              // Sports Category (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var sportsCategoryView: categoryButtonView!
      
      @IBOutlet weak var sportsCategoryIcon: UIImageView!
      
      @IBOutlet weak var sportsLegendLabel: UILabel!
      
      @IBOutlet weak var sportsButton: UIButton!
      
              // Shows Category (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var showsCategoryView: categoryButtonView!
      
      @IBOutlet weak var showsCategoryIcon: UIImageView!
      
      @IBOutlet weak var showsLegendLabel: UILabel!
     
      @IBOutlet weak var showsButton: UIButton!
      
              // Category Details View and Subcategory Picker (inside the StackView):
      
      @IBOutlet weak var categoryView: UIView!
      
      @IBOutlet weak var categoryDetailsLabel: UILabel!
      
      @IBOutlet weak var categoryDetailsTextView: UITextView!
      
      @IBOutlet weak var categoryDetailsMaxLabel: UILabel!
    
      @IBOutlet weak var eventSubcategoryLabel: UILabel!
      
      @IBOutlet weak var subcategoryButtonsStackView: UIStackView!
      
              // Education Subcategory (uses the CategoryButtonView custom class):

      @IBOutlet weak var educationSubView: categoryButtonView!
      
      @IBOutlet weak var educationSubIcon: UIImageView!
      
      @IBOutlet weak var educationSubLegendLabel: UILabel!
      
      @IBOutlet weak var educationSubButton: UIButton!
      
              // Food Subcategory (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var foodSubView: categoryButtonView!
      
      @IBOutlet weak var foodSubIcon: UIImageView!
      
      @IBOutlet weak var foodSubLegendLabel: UILabel!
      
      @IBOutlet weak var foodSubButton: UIButton!
      
              // Social Subcategory (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var socialSubView: categoryButtonView!
      
      @IBOutlet weak var socialSubIcon: UIImageView!
      
      @IBOutlet weak var socialSubLegendLabel: UILabel!
      
      @IBOutlet weak var socialSubButton: UIButton!
      
              // Sports Subcategory (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var sportsSubView: categoryButtonView!
      
      @IBOutlet weak var sportsSubIcon: UIImageView!
      
      @IBOutlet weak var sportsSubLegendLabel: UILabel!
      
      @IBOutlet weak var sportsSubButton: UIButton!
      
              // Shows Subcategory (uses the CategoryButtonView custom class):
      
      @IBOutlet weak var showsSubView: categoryButtonView!
      
      @IBOutlet weak var showsSubIcon: UIImageView!
      
      @IBOutlet weak var showsSubLegendLabel: UILabel!
      
      @IBOutlet weak var showsSubButton: UIButton!
      
              // Subcategory Details View (inside the StackView):
      
      @IBOutlet weak var subcategoryDetailsStackView: UIStackView!
      
      @IBOutlet weak var subcategory1View: UIView!
      
      @IBOutlet weak var subcategory1DetailsLabel: UILabel!
      
      @IBOutlet weak var subcategory1DetailsTextView: UITextView!
      
      @IBOutlet weak var subcategory1DetailsMaxLabel: UILabel!
      
      @IBOutlet weak var subcategory2View: UIView!
      
      @IBOutlet weak var subcategory2DetailsLabel: UILabel!
      
      @IBOutlet weak var subcategory2DetailsTextView: UITextView!
      
      @IBOutlet weak var subcategory2DetailsMaxLabel: UILabel!
      
              // returnProtocol: this protocol defined in the mainViewController holds the neccessary...
              // ...return functions that the createEventViewController has to call once it is done.
      
      weak var returnProtocol : createEventViewControllerReturnProtocol?
    
    // *** VIEWCONTROLLER FUNCTIONS ***
    
    /*
     viewDidLoad: Function called right when the create event view appears on the screen.
        - Initializes useful variables.
        - Styles views.
        - Adjusts certain parameters for the correct functioning of the create event view.
     */
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // *** INITIALIZATION OF USEFUL VARIABLES ***
        
            // Initialization of the category picker views:
        
        educationCategoryView.setParameters(ci: educationCategoryIcon, cll: educationLegendLabel, cb: educationButton)
        
        foodCategoryView.setParameters(ci: foodCategoryIcon, cll: foodLegendLabel, cb: foodButton)
        
        socialCategoryView.setParameters(ci: socialCategoryIcon, cll: socialLegendLabel, cb: socialButton)
        
        sportsCategoryView.setParameters(ci: sportsCategoryIcon, cll: sportsLegendLabel, cb: sportsButton)
        
        showsCategoryView.setParameters(ci: showsCategoryIcon, cll: showsLegendLabel, cb: showsButton)
        
            // Initialization of the subcategory picker views:
        
        educationSubView.setParameters(ci: educationSubIcon, cll: educationSubLegendLabel, cb: educationSubButton)
        
        foodSubView.setParameters(ci: foodSubIcon, cll: foodSubLegendLabel, cb: foodSubButton)
        
        socialSubView.setParameters(ci: socialSubIcon, cll: socialSubLegendLabel, cb: socialSubButton)
        
        sportsSubView.setParameters(ci: sportsSubIcon, cll: sportsSubLegendLabel, cb: sportsSubButton)
        
        showsSubView.setParameters(ci: showsSubIcon, cll: showsSubLegendLabel, cb: showsSubButton)
        
        // *** STYLING ***
        
            // Adjusts the labels parameters of the whole view so they adjust correctly to the screen size.
        
        topText.numberOfLines = 0
        
        dateLabel.numberOfLines = 0
        
        durationLabel.numberOfLines = 0
        
        nameLabel.numberOfLines = 0
        
        infoLabel.numberOfLines = 0
        
        categoryDetailsLabel.numberOfLines = 0
        
        subcategory1DetailsLabel.numberOfLines = 0
        
        subcategory2DetailsLabel.numberOfLines = 0
        
        topText.sizeToFit()
        
        dateLabel.sizeToFit()
        
        durationLabel.sizeToFit()
        
        nameLabel.sizeToFit()
        
        infoLabel.sizeToFit()
        
        categoryDetailsLabel.sizeToFit()
        
        subcategory1DetailsLabel.sizeToFit()
        
        subcategory2DetailsLabel.sizeToFit()
        
            // Makes the frame view have rounded corners.
        
        frameView.layer.cornerRadius = 15.0
        
        frameView.layer.masksToBounds = true
        
        frameView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
            // Renders the return button programatically. Else, it looks weird.
        
        returnButton.setImage(UIImage(named: "returnButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        // *** PARAMETER ADJUSTMENTS ***
        
            // Prevents views from hiding each other.
        
        view.bringSubviewToFront(createEventView)
        
            // Let's the text views resize their superviews.
        
        nameTextView.isScrollEnabled = false
        
        infoTextView.isScrollEnabled = false
        
        categoryDetailsTextView.isScrollEnabled = false
        
        subcategory1DetailsTextView.isScrollEnabled = false
        
        subcategory2DetailsTextView.isScrollEnabled = false
        
            // Removes the scroll view scroll bar.
        
        createEventView.showsVerticalScrollIndicator = false
    }
    
    // Set the shouldAutorotate to False
    
    override open var shouldAutorotate: Bool {
        
        return false
        
    }
    
    // Specify the orientation.
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .portrait
        
    }
    
    /*
     viewDidLayoutSubviews: Super useful function. It's called every time the view controller has to update...
     ...its views. Thus, most of the heavy styling is done here so that everything has been loaded before...
     ...applying the styling. It prevents certain errors with buttons and views not showing correctly.
     */
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        addShadowAndRoundCorners(currentView: topTextView)
        
        topTextView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addShadowAndRoundCorners(currentView: nameView)
        
        addShadowAndRoundCorners(currentView: infoView)
        
        addShadowAndRoundCorners(currentView: dateView)
        
        addShadowAndRoundCorners(currentView: durationView)
        
        addShadowAndRoundCorners(currentView: categoryPickerView)
        
        addShadowAndRoundCorners(currentView: categoryView)
        
        subcategoryDetailsStackView.layer.masksToBounds = false
        
        subcategoryDetailsStackView.layer.cornerRadius = 15.0
        
        subcategory1View.layer.masksToBounds = false
        
        subcategory1View.layer.cornerRadius = 15.0
        
        subcategory2View.layer.masksToBounds = false
        
        subcategory2View.layer.cornerRadius = 15.0
        
    }
    
    /*
     UIColorFromHex: Used to set the blue, pink, and cream colors we all love :)
     */
    
    private func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    /*
     addShadowAndRoundCorners: private helper method used mostly on viewDidLayoutSubviews in order to...
     ...add round corners and shadows to the views and buttons of the create event view.
     */
    
    private func addShadowAndRoundCorners (currentView: UIView) {
    
        currentView.layer.masksToBounds = false
        
        currentView.layer.cornerRadius = 15.0
        
        currentView.layer.shadowColor = UIColor.black.cgColor
        
        currentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        currentView.layer.shadowOpacity = 0.3
        
        currentView.layer.shadowRadius = 2
    
    }
    
    /*
     closeView: IBAction sent by the returnButton.
        - If some information might be lost it throws an alert.
        - It calls one of the returnProtocol functions; the showMainButtons function which shows the createEvent...
          ...and menu Buttons again on the map.
        - It dismisses (or hides) the create event view and gives control back to the mainViewController.
     */
    
    @IBAction func closeView(_ sender: Any) {
        returnProtocol?.showMainButtons()
        self.dismiss(animated: true, completion: nil)
    }
    
}
