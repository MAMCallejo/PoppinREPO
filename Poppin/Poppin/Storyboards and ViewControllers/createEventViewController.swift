//
//  createEventViewController.swift - Manages the view to create events with.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 10/13/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit

class createEventViewController : UIViewController {

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

    @IBOutlet weak var dateMinLabel: UILabel!

            // Duration View variables inside the StackView:

    @IBOutlet weak var durationView: UIView!

    @IBOutlet weak var durationLabel: UILabel!

    @IBOutlet weak var durationTextField: UITextField!

    @IBOutlet weak var durationMinMaxLabel: UILabel!

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

        // *** HELPER VARIABLES AND FUNCTIONS ***

            // Booleans to check whether the fields of the create event form have been filled or not.

    var nameTextViewEdited = false

    var infoTextViewEdited = false

    var dateTextFieldEdited = false

    var durationTextFieldEdited = false

    var categoryDetailsTextViewEdited = false

    var subcategory1DetailsTextViewEdited = false

    var subcategory2DetailsTextViewEdited = false

            // categoryButtonViews that not only check whether a category has been picked or not (they would be nil...
            // ...if they have not) but also contain the category information.

    var categoryPicked: categoryButtonView?

    var subcategory1Picked: categoryButtonView?

    var subcategory2Picked: categoryButtonView?

            // Text Views word limits and Duration of the view animations.

    let nameTextViewMax = 30

    let infoTextViewMax = 250

    let categoryDetailsTextViewMax = 100

    let subcategoryDetailsTextViewMax = 100

    let animationDuration = 0.5

            // datePicker: used by the date view to create an interface for the user...
            // ...to enter a date for the event and then turn this date into a String.

    let datePicker = UIDatePicker()

            // durationPicker: used by the duration view to create an interface for the user...
            // ...to enter a duration for the event and then turn this duration into a String.

    let durationPicker = UIDatePicker()

            // showDoneButton: function that checks the state of the form and shows or hides...
            // ...the done button depending on whether the form is empty still or not.

    var showDoneButton: (()-> Void)? = nil

            // returnProtocol: this protocol defined in the mainViewController holds the neccessary...
            // ...return functions that the createEventViewController has to call once it is done.

    weak var returnProtocol : createEventViewControllerReturnProtocol?

            // dateFormatted: string containing the formatted date for the event needed to store in the...
            // ...database.

    var dateFormatted: String?

            // durationFormatted: string containing the formatted duration for the event needed to store in the...
            // ...database.

    var durationFormatted: String?

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

            // Initialization of the showDoneButton function:

        showDoneButton = {

            if (!self.categoryView.isHidden || self.nameTextViewEdited || self.infoTextViewEdited || self.dateTextFieldEdited || self.durationTextFieldEdited) {

                // Animates the done button to pop into the screen if it has not been shown yet.

                if (self.doneButton.alpha == 0) {

                    self.doneButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

                    self.view.layoutIfNeeded()

                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                                   options: .curveEaseOut, animations: {

                                    self.doneButton.transform = .identity

                                    self.doneButton.alpha = 1

                                    self.view.layoutIfNeeded()

                    }, completion: nil)

                }

            } else {

                // Animates the done button to pop out of the screen if it is not hidden yet.

                if (self.doneButton.alpha == 1) {

                    self.view.layoutIfNeeded()

                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                                   options: .curveEaseOut, animations: {

                                    self.doneButton.alpha = 0

                                    self.doneButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

                                    self.view.layoutIfNeeded()

                    }, completion: nil)

                }

            }

        }

            // Sets word limits on the textViews and initializes their maxLabels.

        updateCharacterCount()

            // Initializes the interface of the dateTextField so that it gathers date information...
            // ...instead of text typed from the keyboard and adds a done button to close the interface...
            // ...Also, the minimum date is set to today and every time the dateTextField is changed, "dateChanged" is called (later defined). Also, it initializes the dateFormatted String to empty.

        dateTextField.inputView = datePicker

        datePicker.datePickerMode = .dateAndTime

        datePicker.minimumDate = Date()

        let dateToolbar = UIToolbar()

        dateToolbar.sizeToFit()

        let dateDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionDate))

        let dateFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        dateToolbar.setItems([dateFlexSpace,dateDoneButton], animated: true)

        dateTextField.inputAccessoryView = dateToolbar

        dateTextField.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        dateFormatted = ""

            // Initializes the interface of the durationTextField so that it gathers duration information...
            // ...instead of text typed from the keyboard and adds a done button to close the interface...
            // ...Also, the maximum duration is set to 5h and every time the durationTextField is changed, "durationChanged" is called (later defined). Also, it initializes the durationFormatted String to empty.

        durationTextField.inputView = durationPicker

        durationPicker.datePickerMode = .countDownTimer

        let durationToolbar = UIToolbar()

        durationToolbar.sizeToFit()

        let durationDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionDuration))

        let durationFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        durationToolbar.setItems([durationFlexSpace,durationDoneButton], animated: true)

        durationTextField.inputAccessoryView = durationToolbar

        durationTextField.addTarget(self, action: #selector(durationChanged), for: .valueChanged)

        durationFormatted = ""

            // Initializes a gesture to close the keyboard when the user taps out.

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))

        view.addGestureRecognizer(tap)

        // *** STYLING ***

            // Adds a bottom blue line to the textViews and textFields.

        nameTextView.delegate = self  // *** FOR FUTURE REFERENCE *** : When you set an object to be its own delegate, it can call certain functions when it performs certain actions. Later I showcase some examples of delegate functions.

        nameTextView.setBottomBorder()

        infoTextView.delegate = self

        infoTextView.setBottomBorder()

        dateTextField.delegate = self

        dateTextField.setBottomBorder()

        durationTextField.delegate = self

        durationTextField.setBottomBorder()

        categoryDetailsTextView.delegate = self

        categoryDetailsTextView.setBottomBorder()

        subcategory1DetailsTextView.delegate = self

        subcategory1DetailsTextView.setBottomBorder()

        subcategory2DetailsTextView.delegate = self

        subcategory2DetailsTextView.setBottomBorder()

            // Adjusts the textViews and textFields so that the typed text...
            // ...alligns correctly inside the view.

        nameTextView.textContainer.lineFragmentPadding = 0

        nameTextView.textContainerInset = .zero

        infoTextView.textContainer.lineFragmentPadding = 0

        infoTextView.textContainerInset = .zero

        categoryDetailsTextView.textContainer.lineFragmentPadding = 0

        categoryDetailsTextView.textContainerInset = .zero

        subcategory1DetailsTextView.textContainer.lineFragmentPadding = 0

        subcategory1DetailsTextView.textContainerInset = .zero

        subcategory2DetailsTextView.textContainer.lineFragmentPadding = 0

        subcategory2DetailsTextView.textContainerInset = .zero

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

            // Hide Category Details View and Subcategory Picker View and subcategory details...
            // ...since the user has not picked a category nor filled any information of the form yet.

        categoryView.isHidden = true

        categoryView.alpha = 0.0

        subcategory1View.isHidden = true

        subcategory1View.alpha = 0.0

        subcategory2View.isHidden = true

        subcategory2View.alpha = 0.0

        doneButton.alpha = 0.0

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

            // Creates two checkers for when the user starts or stops using the keyboard. It calls keyboardWillShow...
            // ...which scrolls the view so that the keyboard does not hide the text being typed by the user.

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
     keyboardWillShow: object function used by the view controller checkers to adjust...
     ...the view when the keyboard pops up.
     */

    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!

        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue

        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.createEventView.contentInset

        contentInset.bottom = keyboardFrame.size.height

        createEventView.contentInset = contentInset

    }

    /*
    keyboardWillHide: object function used by the view controller checkers to adjust...
    ...the view when the keyboard hides.
    */

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero

        createEventView.contentInset = contentInset

    }

    /*
     dateChanged: object function called by the date text field once it's been changed.
        - Calls getDateFromPicker to turn the date to a String.
     */

    @objc func dateChanged () {

        // Shows the done button since a field has been changed.

        self.showDoneButton!()

        getDateFromPicker()

    }

    /*
     durationChanged: object function called by the duration text field once it's been changed.
     - Calls getDurationFromPicker to turn the duration to a String.
     */

    @objc func durationChanged () {

        // Shows the done button since a field has been changed.

        self.showDoneButton!()

        getDurationFromPicker()

    }

    /*
     doneActionDate: object function called once the done button from the date text field is tapped.
        - Calls getDateFromPicker and dismisses the date text field.
     */

    @objc func doneActionDate() {

        getDateFromPicker()

        view.endEditing(true)

    }

    /*
     getDateFromPicker: private helper function that turns a date into a String and then fills the...
     ...dateTextField so the user can see it. Also, it fills the dateFormatted string with the correct...
     ...format to store it in the database.
     */

    private func getDateFromPicker() {

        let formatter = DateFormatter()

        formatter.dateFormat = "MMM d, yyyy, h:mm a"

        dateTextField.text = formatter.string(from: datePicker.date)

        formatter.dateFormat = "YYYY-MM-dd HH:mm"

        dateFormatted = formatter.string(from: datePicker.date)

    }

    /*
     getDurationFromPicker: private helper function that turns a duration into a String and then fills the...
     ...durationTextField so the user can see it. Also, it fills the durationFormatted string with the correct...
     ...format to store it in the database.
     */

    private func getDurationFromPicker() {

        let formatter = DateComponentsFormatter()

        formatter.allowedUnits = [.hour, .minute]

        formatter.unitsStyle = .abbreviated

        if (durationPicker.countDownDuration > 18000) {

            durationTextField.text = "5h 0m"

            durationFormatted = "300"

        /* } else if (durationPicker.countDownDuration < 1800) {

            durationTextField.text = "0h 30m"

            durationFormatted = "30"
            */
        } else {

            durationTextField.text = formatter.string(from: TimeInterval(durationPicker.countDownDuration))

            durationFormatted = String(Int(durationPicker.countDownDuration/60))

        }

    }

    /*
    doneActionDuration: object function called once the done button from the duration text field is tapped.
       - It dismisses the number pad.
    */

    @objc func doneActionDuration() {

        getDurationFromPicker()

        view.endEditing(true)

    }

    /*
    textFieldDidChange: function of the textField Delegate (thus, it is constantly called by the textField itself every time is altered)...
    ...It is implemented for the following reasons:
       - Shows or hides the done Button depending on whether any textView has been filled or not.
       - It turns all non-empty textFields back to blue (since they could have been turned red if the doneButton was pressed...
         ...and they were still empty).
       - Checks or unchecks the textFieldEdited booleans in order for the view controller to know which views are empty or not.
    */

    public func textFieldDidChange(_ textField: UITextField) {

        if (dateTextField.text != "") {

            self.dateLabel.textColor = UIColor.mainNAVYBLUE

            self.dateTextField.textColor = UIColor.mainNAVYBLUE

            self.dateTextField.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            self.dateMinLabel.textColor = UIColor.mainNAVYBLUE

            dateTextFieldEdited = true

        } else {

            dateTextFieldEdited = false

        }

        self.showDoneButton!()

    }

    /*
    textFieldDidEndEditing: function of the textField Delegate (thus, it is constantly called by the textField itself every time it is dismissed)...
    ...It is implemented for the following reasons:
       - Shows or hides the done Button depending on whether any textView has been filled or not.
       - It turns all non-empty textFields back to blue (since they could have been turned red if the doneButton was pressed...
         ...and they were still empty).
       - Checks or unchecks the textFieldEdited booleans in order for the view controller to know which views are empty or not.
    */

    public func textFieldDidEndEditing(_ textField: UITextField) {

        if (durationTextField.text != "") {

            self.durationLabel.textColor = UIColor.mainNAVYBLUE

            self.durationTextField.textColor = UIColor.mainNAVYBLUE

            self.durationTextField.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            self.durationMinMaxLabel.textColor = UIColor.mainNAVYBLUE

            durationTextFieldEdited = true

        } else {

            durationTextFieldEdited = false

        }

        if (dateTextField.text != "") {

            self.dateLabel.textColor = UIColor.mainNAVYBLUE

            self.dateTextField.textColor = UIColor.mainNAVYBLUE

            self.dateTextField.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            self.dateMinLabel.textColor = UIColor.mainNAVYBLUE

            dateTextFieldEdited = true

        } else {

            dateTextFieldEdited = false

        }

        self.showDoneButton!()

    }

    /*
     textViewDidChange: function of the textView Delegate (thus, it is constantly called by the textView itself)...
     ...It is implemented for the following reasons:
        - Shows or hides the done Button depending on whether any textView has been filled or not.
        - It turns all non-empty textViews back to blue (since they could have been turned red if the doneButton was pressed...
          ...and they were still empty).
        - Checks or unchecks the textViewEdited booleans in order for the view controller to know which views are empty or not.
        - Updates the character count for the character limit.
     */

    public func textViewDidChange(_ textView: UITextView) {

        // Since one of the textViews has been edited we show or hide the doneButton.

        if (nameTextView.text != "") {

            self.nameLabel.textColor = UIColor.mainNAVYBLUE

            self.nameMaxLabel.textColor = UIColor.mainNAVYBLUE

            self.nameTextView.textColor = UIColor.mainNAVYBLUE

            self.nameTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            nameTextViewEdited = true

        } else {

            nameTextViewEdited = false

        }

        if (infoTextView.text != "") {

            self.infoLabel.textColor = UIColor.mainNAVYBLUE

            self.infoMaxLabel.textColor = UIColor.mainNAVYBLUE

            self.infoTextView.textColor = UIColor.mainNAVYBLUE

            self.infoTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            infoTextViewEdited = true

        } else {

            infoTextViewEdited = false

        }

        if (categoryDetailsTextView.text != "") {

            self.categoryDetailsLabel.textColor = UIColor.mainNAVYBLUE

            self.categoryDetailsMaxLabel.textColor = UIColor.mainNAVYBLUE

            self.categoryDetailsTextView.textColor = UIColor.mainNAVYBLUE

            self.categoryDetailsTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            categoryDetailsTextViewEdited = true

        } else {

            categoryDetailsTextViewEdited = false

        }

        if (subcategory1DetailsTextView.text != "") {

            self.subcategory1DetailsLabel.textColor = UIColor.mainNAVYBLUE

            self.subcategory1DetailsMaxLabel.textColor = UIColor.mainNAVYBLUE

            self.subcategory1DetailsTextView.textColor = UIColor.mainNAVYBLUE

            self.subcategory1DetailsTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            subcategory1DetailsTextViewEdited = true

        } else {

            subcategory1DetailsTextViewEdited = false

        }

        if (subcategory2DetailsTextView.text != "") {

            self.subcategory2DetailsLabel.textColor = UIColor.mainNAVYBLUE

            self.subcategory2DetailsMaxLabel.textColor = UIColor.mainNAVYBLUE

            self.subcategory2DetailsTextView.textColor = UIColor.mainNAVYBLUE

            self.subcategory2DetailsTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            subcategory2DetailsTextViewEdited = true

        } else {

            subcategory2DetailsTextViewEdited = false

        }

        self.updateCharacterCount()

        self.showDoneButton!()

    }

    /*
     shouldChangeTextIn: function of the textView Delegate (thus, it is constantly called by the textView itself)...
     ...It is implemented for the following reasons:
        - It uses the character limits set up for every textView at the beginning of the code.
        - It prevents the user from typing more if the limit is surpassed.
     */

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if (text == "\n") {

            textView.resignFirstResponder()

        } else if(textView == infoTextView){

            return textView.text.count + (text.count - range.length) <= infoTextViewMax

        } else if (textView == nameTextView) {

            return textView.text.count + (text.count - range.length) <= nameTextViewMax

        } else if (textView == categoryDetailsTextView) {

            return textView.text.count + (text.count - range.length) <= categoryDetailsTextViewMax

        } else if (textView == subcategory1DetailsTextView || textView == subcategory2DetailsTextView) {

            return textView.text.count + (text.count - range.length) <= subcategoryDetailsTextViewMax

        }

        return false

    }

    /*
     updateCharacterCount: private helper method that keeps track of the amount of characters typed.
        - There is a count for every text view or field.
        - It updates the max label accordingly so the user is aware.
     */

    private func updateCharacterCount() {

        let nameCount = self.nameTextView.text.count

        let infoCount = self.infoTextView.text.count

        let categoryDetailsCount = self.categoryDetailsTextView.text.count

        let subcategory1DetailsCount = self.subcategory1DetailsTextView.text.count

        let subcategory2DetailsCount = self.subcategory2DetailsTextView.text.count

        self.nameMaxLabel.text = "\((0) + nameCount)/30"

        self.infoMaxLabel.text = "\((0) + infoCount)/250"

        self.categoryDetailsMaxLabel.text = "\((0) + categoryDetailsCount)/100"

        self.subcategory1DetailsMaxLabel.text = "\((0) + subcategory1DetailsCount)/100"

        self.subcategory2DetailsMaxLabel.text = "\((0) + subcategory2DetailsCount)/100"

    }

    /*
     showCategoryView: IBAction sent by category buttons.
        - It shows an alert if any information might be lost (maybe when deselecting a category or picking a different one).
        - It calls the buildCategoryView function which takes care of setting everything inside the category view.
     */

    @IBAction func showCategoryView(_ sender: Any) {

        if (categoryDetailsTextViewEdited || subcategory1DetailsTextViewEdited || subcategory2DetailsTextViewEdited) {

            let utils = Utils();

            let button1 = AlertButton(title: "Cancel", action: nil)

            let button2 = AlertButton(title: "Continue", action: {

                self.buildCategoryView(sender)

            })

            let alertPayload = AlertPayload(icon: UIImage.init(systemName: "exclamationmark.triangle.fill"), message: "If you proceed, some information will be lost.", buttons: [button1, button2])

            utils.showAlert(payload: alertPayload, parentViewController: self)

        } else {

            buildCategoryView(sender)

        }

    }

    /*
     buildCategoryView: private helper method called by showCategoryView and which takes care of setting up the category view.
        - Depending on the category button tapped, we hide or show the cateogry view with the updated category picked.
        - It calls the private helper methods showCategoryViewHelper and hideCategoryViewHelper.
        - It shows or hides the done button.
     */

    private func buildCategoryView (_ sender: Any) {

        let senderButton = sender as! UIButton

        let senderView = senderButton.superview as! categoryButtonView

        if (categoryPicked == nil) {

            showCategoryViewHelper(selectedCategoryView: senderView)

        } else {

            if (senderView.isSelected) {

                hideCategoryViewHelper(selectedCategoryView: senderView)

            } else {

                hideCategoryViewHelper(selectedCategoryView: categoryPicked!)

                showCategoryViewHelper(selectedCategoryView: senderView)

            }

        }

        self.showDoneButton!()

    }

    /*
     showCategoryViewHelper: private helper method called by the buildCategoryView function.
        - Extracts neccesary information for the styling of the category view from the "selectedCategoryView" parameter.
        - Sets the "categoryPicked" checker so the view controller knows a category has been picked.
        - Styles the category view.
        - Depending on the category picked, the remainding four categories are displayed for the user to pick a subcategory.
        - Animates a fade transition for the category view.
        - Shifts the scroll view down to show the whole category view.
     */

    private func showCategoryViewHelper (selectedCategoryView: categoryButtonView) {

        categoryPicked = selectedCategoryView

        selectedCategoryView.isSelected = true

        categoryLabel.textColor = UIColor.mainNAVYBLUE

        categoryDetailsLabel.textColor = UIColor.mainNAVYBLUE

        categoryDetailsMaxLabel.textColor = UIColor.mainNAVYBLUE

        categoryDetailsTextView.textColor = UIColor.mainNAVYBLUE

        categoryDetailsTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

        if (selectedCategoryView.categoryLegendLabel?.text == "Education") {

            categoryDetailsLabel.text = "Education Event Details:"

            educationSubView.isHidden = true

            foodSubView.isHidden = false

            socialSubView.isHidden = false

            sportsSubView.isHidden = false

            showsSubView.isHidden = false

        } else if (selectedCategoryView.categoryLegendLabel?.text == "Food") {

            categoryDetailsLabel.text = "Food Event Details:"

            educationSubView.isHidden = false

            foodSubView.isHidden = true

            socialSubView.isHidden = false

            sportsSubView.isHidden = false

            showsSubView.isHidden = false

        } else if (selectedCategoryView.categoryLegendLabel?.text == "Social") {

            categoryDetailsLabel.text = "Social Event Details:"

            educationSubView.isHidden = false

            foodSubView.isHidden = false

            socialSubView.isHidden = true

            sportsSubView.isHidden = false

            showsSubView.isHidden = false

        } else if (selectedCategoryView.categoryLegendLabel?.text == "Sports") {

            categoryDetailsLabel.text = "Sport Event Details:"

            educationSubView.isHidden = false

            foodSubView.isHidden = false

            socialSubView.isHidden = false

            sportsSubView.isHidden = true

            showsSubView.isHidden = false

        } else if (selectedCategoryView.categoryLegendLabel?.text == "Shows") {

            categoryDetailsLabel.text = "Show Details:"

            educationSubView.isHidden = false

            foodSubView.isHidden = false

            socialSubView.isHidden = false

            sportsSubView.isHidden = false

            showsSubView.isHidden = true

        } else {

            print("\nError: No such categories available.\n")

        }

        // Animates view show.

        self.categoryView.alpha = 0.0

        self.categoryView.isHidden = true

        self.view.layoutIfNeeded()

        UIView.animate(withDuration: animationDuration + 0.75, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

            self.categoryView.alpha = 1.0

            self.categoryView.isHidden = false

            self.view.layoutIfNeeded()

        }, completion: nil)

        self.view.layoutIfNeeded()

        UIView.animate(withDuration: animationDuration + 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

            let bottomOffset = CGPoint(x: 0, y: self.createEventView.contentSize.height - self.createEventView.bounds.size.height)

            self.createEventView.setContentOffset(bottomOffset, animated: false)

            self.view.layoutIfNeeded()

        }, completion: nil)

    }

    /*
    hideCategoryViewHelper: private helper method called by the buildCategoryView function.
       - Sets "categoryPicked" to nil so the view controller knows that a category has not been picked yet.
       - Animates a fade transition for the category view.
       - Closes the keyboard if is showing and resets the category view textviews.
       - Updates the character count to showcase that the text views have been reset.
    */

    private func hideCategoryViewHelper (selectedCategoryView: categoryButtonView) {

        categoryPicked = nil

        selectedCategoryView.isSelected = false

        // Animates view hide.

        self.categoryView.alpha = 1.0

        self.categoryView.isHidden = false

        self.view.layoutIfNeeded()

        UIView.animate(withDuration: animationDuration + 0.75, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

            self.categoryView.alpha = 0.0

            self.categoryView.isHidden = true

            self.view.layoutIfNeeded()

        }, completion: nil)

        view.endEditing(true)

        categoryDetailsTextView.text = ""

        categoryDetailsTextViewEdited = false

        subcategory1View.isHidden = true

        subcategory1DetailsTextView.text = ""

        subcategory1DetailsTextViewEdited = false

        subcategory2View.isHidden = true

        subcategory2DetailsTextView.text = ""

        subcategory2DetailsTextViewEdited = false

        updateCharacterCount()

    }

    /*
    showSubcategoryView: IBAction sent by subcategory buttons.
       - It shows an alert if any information might be lost (maybe when deselecting a subcategory or picking a different one).
       - It calls the buildSubcategoryView function which takes care of setting everything inside the subcategory views.
    */

    @IBAction func showSubcategoryView(_ sender: Any) {

        let senderButton = sender as! UIButton

        let senderView = senderButton.superview as! categoryButtonView

        if ((senderView == subcategory1Picked && subcategory1DetailsTextViewEdited) || (senderView == subcategory2Picked && subcategory2DetailsTextViewEdited)) {

            let utils = Utils();

            let button1 = AlertButton(title: "Cancel", action: nil)

            let button2 = AlertButton(title: "Continue", action: {

                self.buildSubcategoryView(selectedSubcategoryView: senderView)

            })

            let alertPayload = AlertPayload(icon: UIImage.init(systemName: "exclamationmark.triangle.fill"), message: "If you proceed, some information will be lost.", buttons: [button1, button2])

            utils.showAlert(payload: alertPayload, parentViewController: self)

        } else {

            buildSubcategoryView(selectedSubcategoryView: senderView)

        }

    }

    /*
    buildSubcategoryView: private helper method called by showSubcategoryView and which takes care of setting up the subcategory view.
       - Depending on the subcategory button tapped and which subcategory is empty, we hide or show one of the subcateogry views...
         ...with the updated subcategory picked.
       - It calls the private helper methods showSubcategoryViewHelper and hideSubcategoryViewHelper.
       - Since a subcategory IS NOT NECCESSARY then it does not affect the done Button.
    */

    private func buildSubcategoryView (selectedSubcategoryView: categoryButtonView) {

        if (!selectedSubcategoryView.isSelected) {

            if (subcategory1Picked == nil) {

                showSubcategoryViewHelper(selectedSubcategoryView: selectedSubcategoryView, subcategoryViewNumber: 1)

            } else if (subcategory2Picked == nil) {

                showSubcategoryViewHelper(selectedSubcategoryView: selectedSubcategoryView, subcategoryViewNumber: 2)

            }

        } else {

            if (subcategory1Picked == selectedSubcategoryView) {

                hideSubcategoryViewHelper(selectedSubcategoryView: selectedSubcategoryView, subcategoryViewNumber: 1)

            } else {

                hideSubcategoryViewHelper(selectedSubcategoryView: selectedSubcategoryView, subcategoryViewNumber: 2)

            }

        }

    }

    /*
    showCategoryViewHelper: private helper method called by the buildSubcategoryView function.
       - Extracts neccesary information for the styling of the subcategory view from the "selectedSubcategoryView" parameter.
       - Whichever subcategoryview that is empty is selected to host this new subcategory.
       - Sets one of the "subcategoryPicked" checkers so the view controller knows a subcategory has been picked.
       - Styles the subcategory view selected.
       - Animates a fade transition for the selected subcategory view.
       - Shifts the scroll view down to show the whole subcategory view.
    */

    private func showSubcategoryViewHelper (selectedSubcategoryView: categoryButtonView, subcategoryViewNumber: Int) {

        var subcategoryDetailsLabelText = ""

        if (selectedSubcategoryView.categoryLegendLabel?.text == "Education") {

            subcategoryDetailsLabelText = "Education Event Details:"

        } else if (selectedSubcategoryView.categoryLegendLabel?.text == "Food") {

            subcategoryDetailsLabelText = "Food Event Details:"

        } else if (selectedSubcategoryView.categoryLegendLabel?.text == "Social") {

            subcategoryDetailsLabelText = "Social Event Details:"

        } else if (selectedSubcategoryView.categoryLegendLabel?.text == "Sports") {

            subcategoryDetailsLabelText = "Sport Event Details:"

        } else if (selectedSubcategoryView.categoryLegendLabel?.text == "Shows") {

            subcategoryDetailsLabelText = "Show Details:"

        } else {

            print("\nError: No such subcategories available for subcategoryView1.\n")

        }

        if (subcategoryViewNumber == 1 && subcategoryDetailsLabelText != "") {

            subcategory1Picked = selectedSubcategoryView

            selectedSubcategoryView.isSelected = true

            subcategory1DetailsLabel.textColor = UIColor.mainNAVYBLUE

            subcategory1DetailsMaxLabel.textColor = UIColor.mainNAVYBLUE

            subcategory1DetailsTextView.textColor = UIColor.mainNAVYBLUE

            subcategory1DetailsTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            subcategory1DetailsLabel.text = subcategoryDetailsLabelText

            subcategory1View.alpha = 0.0

            subcategory1View.isHidden = true

            self.view.layoutIfNeeded()

            UIView.animate(withDuration: animationDuration + 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

                self.subcategory1View.alpha = 1.0

                self.subcategory1View.isHidden = false

                self.view.layoutIfNeeded()

            }, completion: nil)

            self.view.layoutIfNeeded()

            UIView.animate(withDuration: animationDuration + 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

                let bottomOffset = CGPoint(x: 0, y: self.createEventView.contentSize.height - self.createEventView.bounds.size.height)

                self.createEventView.setContentOffset(bottomOffset, animated: false)

            }, completion: nil)

        } else if (subcategoryViewNumber == 2 && subcategoryDetailsLabelText != "") {

            subcategory2Picked = selectedSubcategoryView

            selectedSubcategoryView.isSelected = true

            subcategory2DetailsLabel.textColor = UIColor.mainNAVYBLUE

            subcategory2DetailsMaxLabel.textColor = UIColor.mainNAVYBLUE

            subcategory2DetailsTextView.textColor = UIColor.mainNAVYBLUE

            subcategory2DetailsTextView.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor

            subcategory2DetailsLabel.text = subcategoryDetailsLabelText

            subcategory2View.alpha = 0.0

            subcategory2View.isHidden = true

            self.view.layoutIfNeeded()

           UIView.animate(withDuration: animationDuration + 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

                self.subcategory2View.alpha = 1.0

                self.subcategory2View.isHidden = false

                self.view.layoutIfNeeded()

            }, completion: nil)

            self.view.layoutIfNeeded()

            UIView.animate(withDuration: animationDuration + 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

                let bottomOffset = CGPoint(x: 0, y: self.createEventView.contentSize.height - self.createEventView.bounds.size.height)

                self.createEventView.setContentOffset(bottomOffset, animated: false)

            }, completion: nil)

        }

    }

    /*
    hideSubcategoryViewHelper: private helper method called by the buildSubcategoryView function.
       - Selects a subcategory to be hidden.
       - Sets one of the "subcategoryPicked" to nil so the view controller knows that one of the subcategories has not been picked yet.
       - Animates a fade transition for the category view.
       - Closes the keyboard if is showing and resets one of the subcategory view textviews.
       - Updates the character count to showcase that the text view have been reset.
    */

    private func hideSubcategoryViewHelper (selectedSubcategoryView: categoryButtonView, subcategoryViewNumber: Int) {

        if (subcategoryViewNumber == 1) {

            subcategory1Picked = nil

            selectedSubcategoryView.isSelected = false

            subcategory1View.alpha = 1.0

            subcategory1View.isHidden = false

            self.view.layoutIfNeeded()

            UIView.animate(withDuration: animationDuration + 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

                self.subcategory1View.alpha = 0.0

                self.subcategory1View.isHidden = true

                self.view.layoutIfNeeded()

            }, completion: nil)

            subcategory1DetailsTextView.text = ""

            subcategory1DetailsTextViewEdited = false

            view.endEditing(true)

            updateCharacterCount()

        } else {

            subcategory2Picked = nil

            selectedSubcategoryView.isSelected = false

            subcategory2View.alpha = 1.0

            subcategory2View.isHidden = false

            self.view.layoutIfNeeded()

            UIView.animate(withDuration: animationDuration + 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

                self.subcategory2View.alpha = 0.0

                self.subcategory2View.isHidden = true

                self.view.layoutIfNeeded()

            }, completion: nil)

            subcategory2DetailsTextView.text = ""

            subcategory2DetailsTextViewEdited = false

            view.endEditing(true)

            updateCharacterCount()

        }

    }

    /*
     closeView: IBAction sent by the returnButton.
        - If some information might be lost it throws an alert.
        - It calls one of the returnProtocol functions; the showMainButtons function which shows the createEvent...
          ...and menu Buttons again on the map.
        - It dismisses (or hides) the create event view and gives control back to the mainViewController.
     */

    @IBAction func closeView(_ sender: Any) {

        if (nameTextViewEdited || infoTextViewEdited || dateTextFieldEdited || durationTextFieldEdited || categoryDetailsTextViewEdited || subcategory1DetailsTextViewEdited || subcategory2DetailsTextViewEdited) {

            let utils = Utils();

            let button1 = AlertButton(title: "Cancel", action: nil)

            let button2 = AlertButton(title: "Continue", action: {

                self.returnProtocol?.showMainButtons()

                self.dismiss(animated: true, completion: nil)

            })

            let alertPayload = AlertPayload(icon: UIImage.init(systemName: "exclamationmark.triangle.fill"), message: "If you proceed, some information will be lost.", buttons: [button1, button2])

            utils.showAlert(payload: alertPayload, parentViewController: self)

        } else {

            returnProtocol?.showMainButtons()

            self.dismiss(animated: true, completion: nil)

        }

    }

    /*
     placePinOnMap: IBAction function sent by the Done Button.
        - If any fields are yet to be filled, we throw an alert and turn all empty fields red.
        - If everything is filled then the pinPlacementFunction is called.
        - Then, we close the create event view.
     */

    @IBAction func placePinOnMap(_ sender: Any) {

        if (!nameTextViewEdited || !infoTextViewEdited || !dateTextFieldEdited || !durationTextFieldEdited || categoryPicked == nil || !categoryDetailsTextViewEdited || (subcategory1Picked != nil && !subcategory1DetailsTextViewEdited) || (subcategory2Picked != nil && !subcategory2DetailsTextViewEdited)) {

            let utils = Utils();

            let button1 = AlertButton(title: "Ok", action: {

                // Not all fields have been filled yet.

                self.setViewsRed()

            })

            let alertPayload = AlertPayload(icon: UIImage.init(systemName: "xmark.circle.fill"), message: "Some information is missing, please fill it out.", buttons: [button1])

            utils.showAlert(payload: alertPayload, parentViewController: self)

        } else {

            // All fields have been filled, thus we call the pinPlacementFunction.

            pinPlacementFunction()

            self.dismiss(animated: true, completion: nil)

        }

    }

    /*
     setViewsRed: private helper method called by placePinOnMap.
        - Since the done Button has been pressed, all textViews not edited will turn to red so the user knows...
          ...which fields they have to fill still.
     */

    private func setViewsRed() {

        if (!self.nameTextViewEdited) {

            self.nameLabel.textColor = UIColor.red

            self.nameMaxLabel.textColor = UIColor.red

            self.nameTextView.textColor = UIColor.red

            self.nameTextView.layer.shadowColor = UIColor.red.cgColor

        }

        if (!self.infoTextViewEdited) {

            self.infoLabel.textColor = UIColor.red

            self.infoMaxLabel.textColor = UIColor.red

            self.infoTextView.textColor = UIColor.red

            self.infoTextView.layer.shadowColor = UIColor.red.cgColor

        }

        if (!self.dateTextFieldEdited) {

            self.dateLabel.textColor = UIColor.red

            self.dateTextField.textColor = UIColor.red

            self.dateTextField.layer.shadowColor = UIColor.red.cgColor

            self.dateMinLabel.textColor = UIColor.red

        }

        if (!self.durationTextFieldEdited) {

            self.durationLabel.textColor = UIColor.red

            self.durationTextField.textColor = UIColor.red

            self.durationTextField.layer.shadowColor = UIColor.red.cgColor

            self.durationMinMaxLabel.textColor = UIColor.red

        }

        if (self.categoryPicked == nil) {

            self.categoryLabel.textColor = UIColor.red

        } else if (!self.categoryDetailsTextViewEdited) {

            self.categoryDetailsLabel.textColor = UIColor.red

            self.categoryDetailsMaxLabel.textColor = UIColor.red

            self.categoryDetailsTextView.textColor = UIColor.red

            self.categoryDetailsTextView.layer.shadowColor = UIColor.red.cgColor

        }

        if (!self.subcategory1DetailsTextViewEdited) {

            self.subcategory1DetailsLabel.textColor = UIColor.red

            self.subcategory1DetailsMaxLabel.textColor = UIColor.red

            self.subcategory1DetailsTextView.textColor = UIColor.red

            self.subcategory1DetailsTextView.layer.shadowColor = UIColor.red.cgColor

        }

        if (!self.subcategory2DetailsTextViewEdited) {

            self.subcategory2DetailsLabel.textColor = UIColor.red

            self.subcategory2DetailsMaxLabel.textColor = UIColor.red

            self.subcategory2DetailsTextView.textColor = UIColor.red

            self.subcategory2DetailsTextView.layer.shadowColor = UIColor.red.cgColor

        }

    }

    /*
     pinPlacementFunction: private helper function called by placePinOnMap.
        - Since all the fields are correctly filled, we can gather all the data from them.
        - Then, we call another function from returnProtocol; setUserPinData. This function is defined on the mainViewController...
          ...It handles placing the pin on the map and setting it up. We pass all the information gathered to this function.
     */

    private func pinPlacementFunction() {

        // Getting the category and subcategory Names:

        var categoryName = categoryDetailsLabel.text!.components(separatedBy: " ").first ?? ""

        if (categoryName == "Sport") {

            categoryName = "Sports"

        } else if (categoryName == "Show") {

            categoryName = "Shows"

        }

        var subcategory1Name = subcategory1DetailsLabel.text?.components(separatedBy: " ").first ?? ""

        if (subcategory1Name == "Sport") {

            subcategory1Name = "Sports"

        } else if (subcategory1Name == "Show") {

            subcategory1Name = "Shows"

        }

        var subcategory2Name = subcategory2DetailsLabel.text?.components(separatedBy: " ").first ?? ""

        if (subcategory2Name == "Sport") {

            subcategory2Name = "Sports"

        } else if (subcategory2Name == "Show") {

            subcategory2Name = "Shows"

        }

        if (categoryName != "") {

            returnProtocol?.setUserPinData(en: nameTextView.text, ei: infoTextView.text, ed: dateFormatted!, edu: durationFormatted!, ec: categoryName, ecd: categoryDetailsTextView.text, es1: subcategory1Name, es1d: subcategory1DetailsTextView.text, es2: subcategory2Name, es2d: subcategory2DetailsTextView.text)

        } else {

            print("\nError. Unable to place pin on the map. Information about the popsicle category is missing.\n")

        }

    }

}

/*
    Add-on to the textField Delegate that closes the keyboard once the user has finished typing.
*/

extension createEventViewController: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        return true

    }

}

/*
    Add-on to the textView Delegate that closes the keyboard once the user has finished typing.
*/

extension createEventViewController: UITextViewDelegate {

    public func textViewShouldReturn(_ textView: UITextView) -> Bool {

           textView.resignFirstResponder()

           return true

       }

}

/*
    Add-on to the textField that implements extra styling functions.
*/

extension UITextField {

    public func setBottomBorder() {

      self.borderStyle = .none
      self.layer.backgroundColor = UIColor.white.cgColor
      self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor
      self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
      self.layer.shadowOpacity = 1.0
      self.layer.shadowRadius = 0.0

    }

}

/*
    Add-on to the textView that implements extra styling functions.
*/

extension UITextView {

    public func setBottomBorder() {

      self.layer.backgroundColor = UIColor.white.cgColor
      self.layer.masksToBounds = false
      self.layer.shadowColor = UIColor.mainNAVYBLUE?.cgColor
      self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
      self.layer.shadowOpacity = 1.0
      self.layer.shadowRadius = 0.0

    }

}
