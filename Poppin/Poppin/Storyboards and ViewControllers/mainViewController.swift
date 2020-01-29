//
//  mainViewController.swift - main view of the project. It contains the map view and menu view as well as a segue to the create event view.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 10/13/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import CoreData
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes


/*
    createEventViewControllerReturnProtocol: this return protocol is shared between the create event view controller and this one...
    ...so that data or actions can be transfered:
        - setUserPinData gathers all the popsicle data from the create event form and creates a popsicle on the map.
        - showMainButtons shows the createEvent button and menu button once the create event view is closed.
 */

protocol createEventViewControllerReturnProtocol : NSObjectProtocol {

    func setUserPinData(en: String, ei: String, ed: String, edu: String, ec: String, ecd: String, es1: String, es1d: String, es2: String, es2d: String)
     
    func showMainButtons()
    
}

/*
    MapSearchProtocol: this protocol defines the functions that a MapSearchDelegate needs to implement...
    ...The LocationSearchTable has a MapSearchDelegate.
        - dropPinZoomIn is the function in charge of placing the popsicle pin on the map (it is defined later in an extension).
 */

protocol MapSearchProtocol: class {
    
    func dropPinZoomIn(placemark:MKPlacemark)
    
}

class mainViewController: UIViewController, createEventViewControllerReturnProtocol, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    // *** SLIDE OUT MENU DECLARATION ***
    
        // *** IBOutlets ***
    
    @IBOutlet weak var refreshButton: UIButton!
    
    // Constraint needed to show and hide the menu from the left.
    
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
            // Main Views (top of the IB hirearchy).
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var mainMenuItemsView: UIScrollView!
    
            // Profile View Elements:
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    
            // Filter Menu View inside the mainMenuItemsView Scroll View:
    
    @IBOutlet weak var filterMenuView: UIView!

    @IBOutlet weak var filterMenuLabel: UILabel!
    
                // Filter Menu View Elements (Stack View containing all the category views):
    
    @IBOutlet weak var filtersStackView: UIStackView!
    
                // Education Category Filter (uses the CategoryButtonView custom class):
    
    @IBOutlet weak var educationFilterView: categoryButtonView!
    
    @IBOutlet weak var educationFilterIcon: UIImageView!
    
    @IBOutlet weak var educationFilterLegend: UILabel!
    
    @IBOutlet weak var educationFilterButton: UIButton!
    
                // Food Category Filter (uses the CategoryButtonView custom class):
    
    @IBOutlet weak var foodFilterView: categoryButtonView!
    
    @IBOutlet weak var foodFilterIcon: UIImageView!
    
    @IBOutlet weak var foodFilterLegend: UILabel!
    
    @IBOutlet weak var foodFilterButton: UIButton!
    
                // Social Category Filter (uses the CategoryButtonView custom class):
    
    @IBOutlet weak var socialFilterView: categoryButtonView!
    
    @IBOutlet weak var socialFilterIcon: UIImageView!
    
    @IBOutlet weak var socialFilterLegend: UILabel!
    
    @IBOutlet weak var socialFilterButton: UIButton!
    
                // Sports Category Filter (uses the CategoryButtonView custom class):
    
    @IBOutlet weak var sportsFilterView: categoryButtonView!
    
    @IBOutlet weak var sportsFilterIcon: UIImageView!
    
    @IBOutlet weak var sportsFilterLegend: UILabel!
    
    @IBOutlet weak var sportsFilterButton: UIButton!
    
                // Shows Category Filter (uses the CategoryButtonView custom class):
    
    @IBOutlet weak var showsFilterView: categoryButtonView!
    
    @IBOutlet weak var showsFilterIcon: UIImageView!
    
    @IBOutlet weak var showsFilterLegend: UILabel!
    
    @IBOutlet weak var showsFilterButton: UIButton!
    
            // My Events Menu View inside the mainMenuItemsView Scroll View:
    
    @IBOutlet weak var myEventsMenuView: UIView!
    
    @IBOutlet weak var myEventsMenuLabel: UILabel!
    
    @IBOutlet weak var myEventsMenuStackView: UIStackView!
    
    @IBOutlet weak var noEventsLabel: UILabel!
    
    @IBOutlet weak var myEventsButton: UIButton!
    
        // *** HELPER VARIABLES AND FUNCTIONS ***
    
            // Booleans to check whether a category has been filtered or not.
    
    var educationActive = true
    
    var foodActive = true
    
    var socialActive = true
    
    var sportsActive = true
    
    var showsActive = true
    
            // Booleans to check the state of the menuView as well as for initialization.
    
    var menuShowing = false
    
    var initialMenuConstraintHasBeenLoaded = false
    
            // These three recognizers facilitate the user to open or close the menu view by sliding from the edge...
            // ...or tapping outside of the menu view.
    
    var menuEdgePanGestureRecognizer:UIScreenEdgePanGestureRecognizer?
    
    var menuClosePanGestureRecognizer:UIPanGestureRecognizer?
    
    var menuOutsideTapGestureRecognizer:UITapGestureRecognizer?
    
    // *** MAIN MAP VIEW DECLARATION ***
    
        // *** IBOutlets ***
    
            // Main Views (top of the IB hirearchy).
    
    @IBOutlet weak var mainMapView: MKMapView!
    
    @IBOutlet weak var newEventButton: createEventButton!
    
            // Interface used to add a popsicle to the map.
    
    @IBOutlet weak var eventLocationPin: UIImageView!
    
    @IBOutlet weak var eventLocationDraggingNotification: UILabel!
    
    @IBOutlet weak var eventLocationConfirmationContainerView: UIView!
    
    @IBOutlet weak var eventLocationConfirmationView: UIView!
    
    @IBOutlet weak var eventLocationConfirmationLabel: UILabel!
    
    @IBOutlet weak var eventLocationConfirmationAddress: UILabel!
    
    @IBOutlet weak var eventLocationConfirmationButton: UIButton!
    
    @IBOutlet weak var zoomToUserLocationButton: UIButton!
    
        // *** HELPER VARIABLES AND FUNCTIONS ***
    
            // Boolean to let the main view controller that a pin has to be placed.
    
    var placingPin = false
    
            // resultSearchController: holds the interface for the search bar that look for addresses.
    
    var resultSearchController:UISearchController? = nil
    
            // locationManager: it updates locations live. It is used to get the location of the user...
            // ...which is saved onto userLocation. Furthermore, it requires permission from the user...
            // ...to work. Thus, first time they open the app they will be asked to allow location services.
    
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    
    var userLocation: CLLocation!
    
            // The following three variables hold all the neccessary information about the region to be shown...
            // ...on the map which corresponds to the user's campus (DU by default).
    
    var campusLocation: CLLocationCoordinate2D?
    
    var campusRegionRadius: CLLocationDistance?
    
    var campusRegion: MKCoordinateRegion?
    
            // mapPopsicles: array containing all the popsicles placed on the map.
    
    var mapPopsicles:[pinPopsicle]?
    
            // newPopsicle: template used to create a new popsicle to be added to mapPopsicles...
            // ...it uses pinPopsicle; a variation of a normal MKPointAnnotation that can hold...
            // ...all the extra information that popsicles need.
    
    var newPopsicle: pinPopsicle!
    
            // addressLookUpLocationSearchTable: a location search table used to show suggestions from the...
            // ...search bar when the user is looking up for an address. It is a custom class defined under...
            // ...the "Search Bar" folder.
    
    var addressLookUpLocationSearchTable: LocationSearchTable!
<<<<<<< Updated upstream
=======

            // foregroundBlurView: a blurred view that is set on top of the mapView when the create event view is opened.

    var foregroundBlurView: UIView!

    var popsicleTimer: Timer?

    var changesMade = false
    
    var counter = 0
    
    var Popsicles: [NSManagedObject] = []
<<<<<<< Updated upstream

=======


    @IBOutlet weak var count: UILabel!
    
    // *** VIEWCONTROLLER FUNCTIONS ***
>>>>>>> Stashed changes

    @IBOutlet weak var count: UILabel!
>>>>>>> Stashed changes
    
    // *** VIEWCONTROLLER FUNCTIONS ***
    
    /*
     viewDidLoad: Function called right when the main event view appears on the screen.
        - Initializes useful variables.
        - Styles views.
        - Adjusts certain parameters for the correct functioning of the main event view.
     */
    var popsicleTimer: Timer?
    
    var changesMade = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("\nWELCOME! This is the poppin terminal. Error messages and system notifications can be seen here.\n")
        
        // *** INITIALIZATION OF USEFUL VARIABLES ***
<<<<<<< Updated upstream
        
=======

            // Initializes the global variable popsicleSize (needs to layout first since we need to get the size after autolayout constraints have been applied).

       count.layer.cornerRadius = count.frame.width/2
        eventLocationPin.setNeedsLayout()

        eventLocationPin.layoutIfNeeded()

        popsicleSize = eventLocationPin.frame.size

>>>>>>> Stashed changes
            // Initializes the category button views of the filter menu:
        
        educationFilterView.setParameters(ci: educationFilterIcon, cll: educationFilterLegend, cb: educationFilterButton)
        
        educationFilterView.isSelected = true
        
        foodFilterView.setParameters(ci: foodFilterIcon, cll: foodFilterLegend, cb: foodFilterButton)
        
        foodFilterView.isSelected = true
        
        socialFilterView.setParameters(ci: socialFilterIcon, cll: socialFilterLegend, cb: socialFilterButton)
        
        socialFilterView.isSelected = true
        
        sportsFilterView.setParameters(ci: sportsFilterIcon, cll: sportsFilterLegend, cb: sportsFilterButton)
        
        sportsFilterView.isSelected = true
        
        showsFilterView.setParameters(ci: showsFilterIcon, cll: showsFilterLegend, cb: showsFilterButton)
        
        showsFilterView.isSelected = true
        
            // Initializes the gesture recognizers for the menu slide and adds them to the view.
            //  - The first two call handlePan to manage the sliding (later defined).
            //  - The last one calls hideMenuOnTap to manage closing the menu view (later defined).
        
        menuEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        menuEdgePanGestureRecognizer?.delegate = self
        
        menuEdgePanGestureRecognizer?.edges = .left
        
        view.addGestureRecognizer(menuEdgePanGestureRecognizer!)
        
        menuClosePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)) )
        
        view.addGestureRecognizer(menuClosePanGestureRecognizer!)
        
        menuOutsideTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideMenuOnTap(_ :)) )
        
        mainMapView.addGestureRecognizer(menuOutsideTapGestureRecognizer!)
        
            // Initializes the mapPopsicles array to be empty:
        
        mapPopsicles = []
        
            // Initializes the newPopsicle template by creating an empty userPinData object:
                   
        newPopsicle = pinPopsicle()
        
        newPopsicle.popsicleData = pinData(eventName: "", eventInfo: "", eventDate: "", eventDuration: "", eventCategory: "", eventCategoryDetails: "", eventSubcategory1: "", eventSubcategory1Details: "", eventSubcategory2: "", eventSubcategory2Details: "", eventLocation: CLLocationCoordinate2D(), eventPopsicle: UIImage(named: "categoryButtonNP")!)
        
            // Initializes the campus region (DU by default).
        
        campusLocation = CLLocationCoordinate2D(latitude: 39.6766, longitude: -104.9619)
        
        campusRegionRadius = 1500.0
        
        campusRegion = MKCoordinateRegion(center: campusLocation!, latitudinalMeters: campusRegionRadius!, longitudinalMeters: campusRegionRadius!)
        
            // Initializes the addressLookUpLocationSearchTable:
            //  - It creates a programatic storyboard to whole a Location Search Table View Controller...
            //    ...which later will show the search bar and suggestions table.
        
        addressLookUpLocationSearchTable = (storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable)
        
            // Initializes the resultSearchController by matching it with the addressLookUpLocationSearchTable.
            //  - Now the addressLookUpLocationSearchTable will manage the results gathered from the Search Bar.
        
        resultSearchController = UISearchController(searchResultsController: addressLookUpLocationSearchTable)
        
        resultSearchController?.searchResultsUpdater = addressLookUpLocationSearchTable
        
        // *** STYLING ***
        
            // Styles the category button views of the filter menu by rounding its corners:
        
        educationFilterView.layer.cornerRadius = 8.0
        
        foodFilterView.layer.cornerRadius = 8.0
        
        socialFilterView.layer.cornerRadius = 8.0
        
        sportsFilterView.layer.cornerRadius = 8.0
        
        showsFilterView.layer.cornerRadius = 8.0
        
            // Styles the menu view and its subviews by rounding their corners and adding shadows:
        
        addShadowAndRoundCorners(currentView: menuView)
        
        menuView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        addShadowAndRoundCorners(currentView: profileView)
        
        profileView.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        addShadowAndRoundCorners(currentView: filterMenuView)
        
        mainMenuItemsView.layer.masksToBounds = false
               
        mainMenuItemsView.layer.cornerRadius = 8.0
        
        addShadowAndRoundCorners(currentView: myEventsMenuView)
        
        logoutButton.layer.cornerRadius = 8.0
        
        logoutButton.clipsToBounds = true
        
        myEventsButton.layer.cornerRadius = 8.0
        
        myEventsButton.clipsToBounds = true
        
            // Styles the interface to place the pin on the map:
        
        zoomToUserLocationButton.layer.masksToBounds = false
        
        zoomToUserLocationButton.layer.cornerRadius = zoomToUserLocationButton.frame.height / 2
        
        eventLocationConfirmationContainerView.layer.cornerRadius = 15.0
        
        eventLocationConfirmationContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addShadowAndRoundCorners(currentView: eventLocationConfirmationView)
        
        eventLocationConfirmationView.layer.cornerRadius = 15.0
        
        eventLocationDraggingNotification.layer.masksToBounds = true
        
        eventLocationDraggingNotification.layer.cornerRadius = 3.0
        
        eventLocationConfirmationButton.layer.masksToBounds = false
        
        eventLocationConfirmationButton.layer.cornerRadius = 5.0
        
            // Styles and Adjusts some parameters of the Search Bar:
        
        resultSearchController!.searchBar.isTranslucent = false
        
        resultSearchController!.searchBar.sizeToFit()
        
        resultSearchController!.searchBar.placeholder = "Search event address..."
        
        resultSearchController!.searchBar.searchTextField.font = UIFont(name: "Octarine-Light", size: 15)
        
        resultSearchController!.searchBar.searchTextField.textColor = UIColor.black
        
        resultSearchController!.searchBar.searchTextField.backgroundColor = UIColor.white
        
        resultSearchController!.searchBar.searchTextField.layer.masksToBounds = false
        
        resultSearchController!.searchBar.searchTextField.layer.cornerRadius = 15.0
        
        resultSearchController!.searchBar.searchTextField.layer.shadowColor = UIColor.black.cgColor
        
        resultSearchController!.searchBar.searchTextField.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        resultSearchController!.searchBar.searchTextField.layer.shadowOpacity = 0.3
        
        resultSearchController!.searchBar.searchTextField.layer.shadowRadius = 2
        
        resultSearchController!.searchBar.searchTextField.sizeToFit()
        
        let glassIconView = resultSearchController!.searchBar.searchTextField.leftView as? UIImageView
        
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        
        glassIconView?.tintColor = UIColor.gray
        
        let attributes = [
            
            NSAttributedString.Key.foregroundColor : UIColorFromHex(rgbValue: 0x002868),
            
            NSAttributedString.Key.font : UIFont.init(name: "Octarine-Bold", size: 15)
            
        ]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
       
        // *** PARAMETER ADJUSTMENTS ***
        
            // Adjusts the label size parameters so they resize with the different phone sizes...
            // ...it also adds an underline effect.
        
        usernameLabel.adjustsFontSizeToFitWidth = true
        
        logoutButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        filterMenuLabel.adjustsFontSizeToFitWidth = true
        
        filterMenuLabel.underline()
        
        educationFilterLegend.adjustsFontSizeToFitWidth = true
        
        foodFilterLegend.adjustsFontSizeToFitWidth = true
        
        socialFilterLegend.adjustsFontSizeToFitWidth = true
        
        sportsFilterLegend.adjustsFontSizeToFitWidth = true
        
        showsFilterLegend.adjustsFontSizeToFitWidth = true
        
        myEventsMenuLabel.adjustsFontSizeToFitWidth = true
        
        myEventsMenuLabel.underline()

            // Prevents menu items scrollview from showing scroll bar:
        
        mainMenuItemsView.showsVerticalScrollIndicator = false
        
            // Adjusts technical features of the search bar.
    
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        
        definesPresentationContext = true
        
        addressLookUpLocationSearchTable.maxRegion = campusRegion
        
        addressLookUpLocationSearchTable.MapSearchDelegate = self

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.view.backgroundColor = UIColor.clear
        
            // Disables dark mode on the map.
        
        overrideUserInterfaceStyle = .light
        
            // Hides the placement pin interface:

        eventLocationPin.isHidden = true
        
        eventLocationDraggingNotification.isHidden = true
        
        eventLocationConfirmationContainerView.isHidden = true
        
        zoomToUserLocationButton.isHidden = true
        
            // Disable Rotation of the map.
        
        mainMapView.isRotateEnabled = false
        
            /*
             To make sure users do not accidentally pan away from the event and get
             lost, we apply a camera boundary. This ensures that the center point of
             the map always remain inside this region.
            */
        
        mainMapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: campusRegion!)

            /*
             There is no reason for users to zoom out to view all of the city and
             beyond. Thus, we apply a camera zoom range to restrict how far in
             and out users can zoom in the map view.
            */
        
        mainMapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 250, maxCenterCoordinateDistance: 3000)
        
            // The user location annotation is added to the map. The region of the map is defined. The map...
            // ...is set to be its own delegate so it can call functions on itself (later defined).
        
        mainMapView.register(MKUserLocation.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(MKUserLocation.self))

        mainMapView.setRegion(campusRegion!, animated: true)

        mainMapView.delegate = self
        
            // Sets up the locationManager and asks the user for permission if they have not given it yet.
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.startUpdatingLocation()
        
            // It hides the search bar initially until the pin placement interface is called.
            
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        getUsername()
        getProfilePic()
        getPopsicles()
        //refreshDatabase()
<<<<<<< Updated upstream
        
       // popsicleTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshDatabase), userInfo: nil, repeats: true)
        
        //refreshDatabase()
       // getPopsicles()
        
        
=======

         popsicleTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshDatabase), userInfo: nil, repeats: true)

>>>>>>> Stashed changes
    }
    
    @IBAction func refreshButtonPressed(sender: Any){
<<<<<<< Updated upstream
<<<<<<< Updated upstream
        refreshDatabase()
        //getPopsicles()
        
=======
=======

        //refreshDatabase()
        
        self.counter = 0
         self.count.text = String (self.counter)

        getPopsicles()
>>>>>>> Stashed changes

        //refreshDatabase()
        
        self.counter = 0
         self.count.text = String (self.counter)

        getPopsicles()

>>>>>>> Stashed changes
    }
    
    //getUsername: gets the username of the current user and displays it
    
    func getUsername(){
         let ref = Database.database().reference()

         let uid = Auth.auth().currentUser!.uid
    ref.child("users/\(uid)/username").observeSingleEvent(of: .value, with: { (snapshot) in
      // Get user value
      let value = snapshot.value as? String
     
     self.usernameLabel.text = value

      // ...
      }) { (error) in
        print(error.localizedDescription)
    }
     
     }
    
    //logOutAction: Logs the user out
    
    @IBAction func logOutAction(_ sender: Any) {
        do {
               try Auth.auth().signOut()
           }
        catch let signOutError as NSError {
               print ("Error signing out: %@", signOutError)
           }
           
        let storyboard = UIStoryboard(name: "Login", bundle: .main)
           let initial = storyboard.instantiateInitialViewController()
           UIApplication.shared.keyWindow?.rootViewController = initial
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
            self.profileButton.setImage(pic , for: UIControl.State.normal)
          }
        }
    }
        

//        // UIImageView in your ViewController
//        let imageView: UIButton = self.profileButton
//
//        // Placeholder image
//        let placeholderImage = UIImage(named: "placeholder.jpg")
//
//        // Load the image using SDWebImage
//        imageView.sd_setImage(with: referenceURL, for: .normal)
       

    
    /*
     viewDidLayoutSubviews: Super useful function. It's called every time the view controller has to update...
     ...its views. Thus, most of the heavy styling is done here so that everything has been loaded before...
     ...applying the styling. It prevents certain errors with buttons and views not showing correctly. Also...
     ...It adjusts the menu view initially (else a little piece of it shows up at the beginning).
    */
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        // Styles the profile button by rounding its corners.
        
        profileButton.clipsToBounds = true
        
        profileButton.layer.cornerRadius = profileButton.frame.size.width / 2
        
        profileButton.layer.borderColor = UIColorFromHex(rgbValue: 0xFFE6C8).cgColor
        
        profileButton.layer.borderWidth = 2
        
        // Styles the event views inside the myEvents stack view by adding round corners and shadows:
        
        for eventView in myEventsMenuStackView.subviews {
            
            if (!(eventView is UILabel)) {
                
                addShadowAndRoundCorners(currentView: eventView)
                
            }
            
        }
        
        // If the menu is being loaded for the first time, it adjusts it so that it is completely hidden.
        
        if (!initialMenuConstraintHasBeenLoaded) {
            
            menuLeadingConstraint.constant = 0 - menuView.frame.size.width
            
            initialMenuConstraintHasBeenLoaded = true
            
        }
        
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
        The following three functions handle the permissions to show the user location and also update...
        ...the user annotation on the map as the user changes its location live.
     */
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // Checks if permissions have changed and acts accordingly.
        
        if status == .authorizedWhenInUse {
            
            locationManager.requestLocation()
            
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Updates annotation with the user location (which is the first location returned by the Location Manager).
        
        if let location = locations.first {
            
            userLocation = location
            
        }

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // Prints an error if any were found.
        
        print("error:: (error)")
        
    }
    
    /*
        The following three object functions are different handlers that open the menu (for the different...
        ...ways to open the menu :D ).
     */
    
        /*
            hideMenuOnTap: Handler called when the user taps somewhere outside the menu and the menu is open...
            ...in order to close the menu view.
                - It checks if the menu is showing.
                - Then it tells the view it has to redraw.
                - Then it animates the menu to close.
                - Finally, it unchecks the menuShowing boolean so that the mainViewController knows that is not...
                  ...showing.
        */
    
    @objc func hideMenuOnTap(_ recognizer: UITapGestureRecognizer) {
        
        if (menuShowing) {
            
            // toggle side menu (to fully hide it)
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.menuLeadingConstraint.constant = 0 - self.menuView.frame.size.width
                
                self.view.layoutIfNeeded()
                
            })
            
            menuShowing = !menuShowing
            
        }
        
    }

    /*
        handlePan: Main handler called when the user slides the menu in or out.
            - It's mostly self-explanatory, and shotout to my boy Josiah ;)
    */
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        
        if (!menuView.isHidden) {
            
            // how much distance have user finger moved since touch start (in X and Y)
            
            let translation = recognizer.translation(in: self.view)
            
            // for demonstration purpose below, you can ignore this line
            // print("panned x: \(translation.x), y: \(translation.y)")
            
            // snap-back-to-nearest feature
            
            // when user lift up finger / end drag
            
            if(recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled){
                
                if(menuShowing){
                    
                    // user finger moved to left before ending drag
                    
                    if(translation.x < 0){
                        
                        // toggle side menu (to fully hide it)
                        
                        self.view.layoutIfNeeded()
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.menuLeadingConstraint.constant = 0 - self.menuView.frame.size.width;
                            self.view.layoutIfNeeded()
                        })
                        
                        menuShowing = !menuShowing
                        
                    }
                        
                        // user finger moved to left before ending drag
                        
                    else if (translation.x > 0) {
                        
                        // toggle side menu (to fully show it)
                        
                        self.view.layoutIfNeeded()
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.menuLeadingConstraint.constant = 0
                            self.view.layoutIfNeeded()
                        })
                        
                    }
                    
                } else {
                    
                    // user finger moved to right and more than 100pt
                    
                    if(translation.x > 100){
                        
                        // toggle side menu (to fully show it)
                        
                        self.view.layoutIfNeeded()
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.menuLeadingConstraint.constant = 0
                            self.view.layoutIfNeeded()
                        })
                        
                        menuShowing = !menuShowing
                        
                    } else {
                        
                        // user finger moved to right but too less
                        // hide back the side menu (with animation)
                        
                        self.view.layoutIfNeeded()
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.menuLeadingConstraint.constant = 0 - self.menuView.frame.size.width;
                            self.view.layoutIfNeeded()
                        })
                        
                    }
                    
                }
                
                // early return so code below won't get executed
                
                return
                
            }
            
            // if side menu is not visisble
            // and user finger move to right
            // and the distance moved is smaller than the side menu's width
            
            if (!menuShowing && translation.x > 0.0 && translation.x <= menuView.frame.size.width) {
                
                // move the side menu to the right
                
                menuLeadingConstraint.constant = 0 - menuView.frame.size.width + translation.x
                
            }
            
            // if the side menu is visible
            // and user finger move to left
            // and the distance moved is smaller than the side menu's width
            
            if (menuShowing && translation.x < 0.0 && translation.x >= 0 - menuView.frame.size.width) {
                
                // move the side menu to the left
                
                menuLeadingConstraint.constant = translation.x
                
            }
            
        }
        
    }
    
    /*
        openMenuFromButton: last handler this one receives an IBAction from the menu button that tells...
        ...the handler to either open or close the menu.
            - It checks if the menu is showing or not.
            - Then it animates the menu to close or open and also tells the main view to redraw itself.
            - Finally, it unchecks or checks the menuShowing boolean so that the mainViewController knows its new...
              ...state.
    */
    
    @IBAction func openMenuFromButton(_ sender: Any) {
        
        if(!menuShowing) {
            
            menuLeadingConstraint.constant = 0
        
        } else {
            
            menuLeadingConstraint.constant = 0 - menuView.frame.size.width
            
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations:
        {
            
            self.view.layoutIfNeeded()
            
        })
        
        menuShowing = !menuShowing
        
    }
    
    /*
        The following block of functions are the ones that handle the category filters.
            - They fetch IBActions from the category buttons and act accordingly.
            - They select or deselect the category view and then call the private helper...
              ...function filterPopsicles that updates the map with the current filters.
    */
    
    @IBAction func showEducation(_ sender: UIButton) {
        
        if(!educationActive) {
            
            educationFilterView.isSelected = true
            
        } else {
            
            educationFilterView.isSelected = false
            
        }
        
        educationActive = !educationActive;
        
        filterPopsicles()
        
    }
    
    @IBAction func showFood(_ sender: UIButton) {
        
        if(!foodActive) {
            
            foodFilterView.isSelected = true
            
        } else {
            
            foodFilterView.isSelected = false
            
        }
        
        foodActive = !foodActive;
        
        filterPopsicles()
        
    }
    
    @IBAction func showSocial(_ sender: UIButton) {
        
        if(!socialActive) {
            
            socialFilterView.isSelected = true
            
        } else {
            
            socialFilterView.isSelected = false
            
        }
        
        socialActive = !socialActive;
        
        filterPopsicles()
        
    }
    
    @IBAction func showSports(_ sender: UIButton) {
        if(!sportsActive) {
            
            sportsFilterView.isSelected = true
            
        } else {
           
            sportsFilterView.isSelected = false
            
        }
        
        sportsActive = !sportsActive;
        
        filterPopsicles()
        
    }
    
    @IBAction func showShows(_ sender: UIButton) {
        
        if(!showsActive) {
            
            showsFilterView.isSelected = true
            
        } else {
            
            showsFilterView.isSelected = false
            
        }
        showsActive = !showsActive;
        
        filterPopsicles()
        
    }
    
    /*
        filterPopsicles: private helper method that runs through all the annotations of the map...
        ...and hides them or shows them depending on the filters that are on place.
     */
    
    private func filterPopsicles() {
        
        for annotation in mainMapView.annotations {
            
            if (annotation is pinPopsicle) {
                
                let popsicle = annotation as! pinPopsicle
                
                if (!educationActive && !foodActive && !socialActive && !sportsActive && !showsActive) {
                    
                    mainMapView.view(for: popsicle)!.isHidden = true
                    
                } else if (popsicle.popsicleData.eventCategory == "Education" && educationActive) {
                    
                    mainMapView.view(for: popsicle)!.isHidden = false
                    
                } else if (popsicle.popsicleData.eventCategory == "Food" && foodActive) {
                    
                    mainMapView.view(for: popsicle)!.isHidden = false
                    
                } else if (popsicle.popsicleData.eventCategory == "Social" && socialActive) {
                    
                    mainMapView.view(for: popsicle)!.isHidden = false
                    
                } else if (popsicle.popsicleData.eventCategory == "Sports" && sportsActive) {
                    
                    mainMapView.view(for: popsicle)!.isHidden = false
                    
                } else if (popsicle.popsicleData.eventCategory == "Shows" && showsActive) {
                    
                    mainMapView.view(for: popsicle)!.isHidden = false
                    
                } else {
                    
                    mainMapView.view(for: popsicle)!.isHidden = true
                    
                }
                
            }
            
        }
        
    }
    
    /*
        prepareForSegue: function called before the segue (to the create event view in this case)...
        ...to prepare the returnProtocol and hide certain features from the main view that will not...
        ...be useful.
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "createEventSegue") {
            
            let inputVC = segue.destination as! createEventViewController
            
            inputVC.returnProtocol = self
            
            if (menuShowing) {
                
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.menuLeadingConstraint.constant =  0 - self.menuView.frame.size.width;
                    
                    self.view.layoutIfNeeded()
                    
                }, completion: { (finished: Bool) in
                    
                    self.menuView.isHidden = true
                    
                })
                
                menuShowing = !menuShowing
                
            }
            
            menuButton.isHidden = true
            
            newEventButton.isHidden = true
            
        }
        
    }
    
    /*
        setUserPinData: first function from the returnProtocol. It is called by the create event view once the user...
        has completed the form correctly.
            - It initializes the template popsicle (newPopsicle) with the information gathered.
            - Then the private helper method placePinOnMap is called which handles the pin placement interface.
     */
    
    public func setUserPinData(en: String, ei: String, ed: String, edu: String, ec: String, ecd: String, es1: String, es1d: String, es2: String, es2d: String) {
              
        newPopsicle.popsicleData.eventName = en
        
        newPopsicle.popsicleData.eventInfo = ei

        newPopsicle.popsicleData.eventDate = ed
        
        newPopsicle.popsicleData.eventDuration = edu
        
        newPopsicle.popsicleData.eventCategory = ec
        
        newPopsicle.popsicleData.eventCategoryDetails = ecd
        
        newPopsicle.popsicleData.eventSubcategory1 = es1
    
        newPopsicle.popsicleData.eventSubcategory1Details = es1d
        
        newPopsicle.popsicleData.eventSubcategory2 = es2
        
        newPopsicle.popsicleData.eventSubcategory2Details = es2d
        
        // Checker if you want to see the data passed to the popsicle.
        
        /*print(userPinData.eventName + " " + userPinData.eventInfo + " " + userPinData.eventDate + " " + userPinData.eventCategory + " " + userPinData.eventCategoryDetails + " " + userPinData.eventSubcategory1 + " " + userPinData.eventSubcategory1Details + " " + userPinData.eventSubcategory2 + " " + userPinData.eventSubcategory2Details)*/
        
        // We call placePinOnMap:
        
        placePinOnMap()
        
    }
    
    /*
        showMainButtons: second function from the return protocol. It shows all the elements once again...
        ...that had been hidden before the segue to the create event view. It is called after the user has...
        ...picked a location for the popsicle.
     */
    
    public func showMainButtons() {
        
        menuView.isHidden = false
        
        menuButton.isHidden = false
        
        newEventButton.isHidden = false
        
    }
    
    /*
        placePinOnMap: private helper method called by setUserPinData.
            - It initializes and styles the pin placement interface.
     */
    
    private func placePinOnMap () {
        
        // Initializes the pin placement view by showing all of its elements.
        
        placingPin = true
        
        resultSearchController?.searchBar.text = ""
        
        newEventButton.isHidden = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        eventLocationPin.isHidden = false
        
        eventLocationDraggingNotification.isHidden = false
        
        eventLocationDraggingNotification.alpha = 1.0
        
        zoomToUserLocationButton.isHidden = false
        
        // Depending on the category of the template popsicle, a different popsicle...
        // ...appears on the middle of the screen.
        
        if (newPopsicle.popsicleData.eventCategory == "Education") {
            
            eventLocationPin.image = UIImage(named: "educationButton")
            
            newPopsicle.popsicleData.eventPopsicle = UIImage(named: "educationButton")!
            
        } else if (newPopsicle.popsicleData.eventCategory == "Food") {
            
            eventLocationPin.image = UIImage(named: "foodButton")
            
            newPopsicle.popsicleData.eventPopsicle = UIImage(named: "foodButton")!
            
        } else if (newPopsicle.popsicleData.eventCategory == "Social") {
            
            eventLocationPin.image = UIImage(named: "socialButton")
            
            newPopsicle.popsicleData.eventPopsicle = UIImage(named: "socialButton")!
            
        } else if (newPopsicle.popsicleData.eventCategory == "Sports") {
            
            eventLocationPin.image = UIImage(named: "sportsButton")
            
            newPopsicle.popsicleData.eventPopsicle = UIImage(named: "sportsButton")!
            
        } else {
            
            eventLocationPin.image = UIImage(named: "showsButton")
            
            newPopsicle.popsicleData.eventPopsicle = UIImage(named: "showsButton")!
            
        }
        
    }
    
    /*
        zoomToUserLocation: called by the zoomToUserLocation button on the pin placement interface.
            - It creates a small region with the user location and then it zooms on it.
            - For a slower zoom animation, the setRegion function could be customly animated.
     */
    
    @IBAction func zoomToUserLocation(_ sender: Any) {
        
        // Creates the user region
        
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 50.0, longitudinalMeters: 50.0)
        
        // Zooms to user region
        
        mainMapView.setRegion(region, animated: true)
        
    }
    
    @objc func refreshDatabase(){
<<<<<<< Updated upstream
=======
        let ref = Database.database().reference(withPath:"currentPopsicles")
        let ref2 = Database.database().reference(withPath:"upcomingPopsicles")
        let ref3 = Database.database().reference(withPath:"completedPopsicles")
        
        guard let appDelegate =
                 UIApplication.shared.delegate as? AppDelegate else {
                 return
               }
               
               // 1
               let managedContext =
                 appDelegate.persistentContainer.viewContext
               
               // 2
               let entity =
                 NSEntityDescription.entity(forEntityName: "Popsicles",
                                            in: managedContext)!
               
               let popsicle = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
        
        let fetchRequest =
                 NSFetchRequest<NSManagedObject>(entityName: "Popsicles")
<<<<<<< Updated upstream
>>>>>>> Stashed changes

         let ref = Database.database().reference(withPath:"currentPopsicles")
         let ref2 = Database.database().reference(withPath:"upcomingPopsicles")
         let ref3 = Database.database().reference(withPath:"completedPopsicles")
        
=======

>>>>>>> Stashed changes
        ref2.observeSingleEvent(of: .value, with: { (snapshot) in
             if snapshot.childrenCount > 0 {
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                if let data = data.value as? [String: Any] {
                    
                     let eventDate = data["eventDate"] as! String
                    let eventName = data["eventName"] as! String
                    
                    let currentDate = Date()
                    let currentCalendar = Calendar.current
                    let currentHour = currentCalendar.component(.hour, from: currentDate)
                    let currentMinute = currentCalendar.component(.minute, from: currentDate)
                    let currentDay = currentCalendar.component(.day, from: currentDate)
                    let currentMonth = currentCalendar.component(.month, from: currentDate)
                    let currentYear = currentCalendar.component(.year, from: currentDate)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let date = dateFormatter.date(from: eventDate)!
                    
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    
                    
                    let hour = components.hour!
                    let year = components.year!
                    let month = components.month!
                    let day = components.day!
                    let minute = components.minute!

                    if year == currentYear && month == currentMonth && day >= currentDay {
                        
                        if (day > currentDay && day - currentDay == 1 && hour < currentHour) || day == currentDay || ( day - currentDay == 1 && hour == currentHour && minute <= currentMinute) {
                
                            ref.child(eventName).setValue(data)
                            let deleteRef = ref2.child(eventName)

<<<<<<< Updated upstream
                            self.changesMade = true
                            
                            deleteRef.removeValue { error, _ in
                                self.getPopsicles()
                                print(error)
=======
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let date = dateFormatter.date(from: eventDate)!

                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)


                        let hour = components.hour!
                        let year = components.year!
                        let month = components.month!
                        let day = components.day!
                        let minute = components.minute!
                        if year == currentYear && month == currentMonth && day >= currentDay {

                            if (day > currentDay && day - currentDay == 1 && hour < currentHour) || day == currentDay || ( day - currentDay == 1 && hour == currentHour && minute <= currentMinute) {
                                
                                let eventDate = data["eventDate"] as! String
                                let eventName = data["eventName"] as! String
                                let eventCategory = data["eventCategory"] as! String
                                let eventCategoryDetails = data["eventCategoryDetails"] as! String
                                let eventDuration = data["eventDuration"] as! String
                                let eventInfo = data["eventInfo"] as! String
                                let eventSubcategory1 = data["eventSubcategory1"] as! String
                                let eventSubcategory1Details = data["eventSubcategory1Details"] as! String
                                let eventSubcategory2 = data["eventSubcategory2"] as! String
                                let eventSubcategory2Details = data["eventSubcategory2Details"] as! String
                                let latitude = data["latitude"] as! CLLocationDegrees
                                let longitude = data["longitude"] as! CLLocationDegrees
                                
                                
                                          popsicle.setValue(latitude, forKeyPath: "latitude")
                                          popsicle.setValue(longitude, forKeyPath: "longitude")
                                          popsicle.setValue(eventName, forKeyPath: "eventName")
                                          popsicle.setValue(eventInfo, forKeyPath: "eventInfo")
                                          popsicle.setValue(eventDate, forKeyPath: "eventDate")
                                          popsicle.setValue(eventDuration, forKeyPath: "eventDuration")
                                          popsicle.setValue(eventCategory, forKeyPath: "eventCategory")
                                          popsicle.setValue(eventCategoryDetails, forKeyPath: "eventCategoryDetails")
                                          popsicle.setValue(eventSubcategory1, forKeyPath: "eventSubcategory1")
                                          popsicle.setValue(eventSubcategory1Details, forKeyPath: "eventSubcategory1Details")
                                          popsicle.setValue(eventSubcategory2, forKeyPath: "eventSubcategory2")
                                          popsicle.setValue(eventSubcategory2Details, forKeyPath: "eventSubcategory2Details")

                                          
                                          // 4
                                          do {
                                            try managedContext.save()
                                            self.Popsicles.append(popsicle)
                                          } catch let error as NSError {
                                            print("Could not save. \(error), \(error.userInfo)")
                                          }

                                
                                self.counter += 1
                                self.count.text = String (self.counter)

                                ref.child(eventName).setValue(data)
                                let deleteRef = ref2.child(eventName)
                                //self.changesMade = true

                                deleteRef.removeValue { error, _ in
                                    //self.getPopsicles()
                                    print(error ?? "Refresh Database Error")
                                }
>>>>>>> Stashed changes
                            }
                        }
                    }
                    
                    
                    }
                }
            }
        })
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    if let data = data.value as? [String: Any] {
                        
                        let eventDate = data["eventDate"] as! String
                        let eventName = data["eventName"] as! String
                        let duration = data["eventDuration"] as! String
                        let eventDuration:Int? = Int(duration)
                        
                        let currentDate = Date()
                        let currentCalendar = Calendar.current
                        let currentHour = currentCalendar.component(.hour, from: currentDate)
                        let currentMinute = currentCalendar.component(.minute, from: currentDate)
                        let currentDay = currentCalendar.component(.day, from: currentDate)
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let date = dateFormatter.date(from: eventDate)!
                        
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                        
                        
                        var hour = components.hour!
                        let minute = components.minute!
                        let day = components.day!
                        
                        let timeHours = eventDuration! / 60
                        let timeMinute = eventDuration! % 60
                        
                        if(timeMinute + minute >= 60){
                            hour += 1
                        }

<<<<<<< Updated upstream
<<<<<<< Updated upstream
                        
                        if day < currentDay || ((hour + timeHours) % 24 <= currentHour && (minute + timeMinute) % 60 <= currentMinute)  {
                            ref3.child(eventName).setValue(data)
                            let deleteRef = ref.child(eventName)
                            
                            self.changesMade = true
                            
                            deleteRef.removeValue { error, _ in
                                self.getPopsicles()
                                print(error)
=======
                        if day < currentDay || (day == currentDay && ((hour + timeHours) % 24 <= currentHour && (minute + timeMinute) % 60 <= currentMinute)) {
                            
                            do {
                                let eventName = data["eventName"] as! String
                                fetchRequest.predicate = NSPredicate(format: "eventName == %@", eventName)
                                let result = try managedContext.fetch(fetchRequest)
                                managedContext.delete(result[0])
                                
                            } catch {
                                fatalError("Failed to fetch employees: \(error)")
=======
                        if day < currentDay || (day == currentDay && ((hour + timeHours) % 24 <= currentHour && (minute + timeMinute) % 60 <= currentMinute)) {
                            
                            do {
                                let eventName = data["eventName"] as! String
                                fetchRequest.predicate = NSPredicate(format: "eventName == %@", eventName)
                                let result = try managedContext.fetch(fetchRequest)
                                managedContext.delete(result[0])
                                
                            } catch {
                                fatalError("Failed to fetch employees: \(error)")
                            }
                            
                            self.counter += 1
                             self.count.text = String (self.counter)
                            ref3.child(eventName).setValue(data)
                            let deleteRef = ref.child(eventName)

                            //self.changesMade = true

                            deleteRef.removeValue { error, _ in
                                //self.getPopsicles()
                                print(error ?? "Refresh Database Error")
>>>>>>> Stashed changes
                            }
                            
                            self.counter += 1
                             self.count.text = String (self.counter)
                            ref3.child(eventName).setValue(data)
                            let deleteRef = ref.child(eventName)

                            //self.changesMade = true

                            deleteRef.removeValue { error, _ in
                                //self.getPopsicles()
                                print(error ?? "Refresh Database Error")
>>>>>>> Stashed changes
                            }
                            
                            //sleep(2)
                            
                        }
                    }
                }
            }
        })
<<<<<<< Updated upstream
        
      //  if(self.changesMade){
            //getPopsicles()
            self.changesMade = false
       // }
=======

        // if(self.changesMade){
        //getPopsicles()
        //self.changesMade = false
        // }
>>>>>>> Stashed changes
    }
    
    func getPopsicles(){
        for annotation in mainMapView.annotations{
            if annotation is pinPopsicle{
                mainMapView.removeAnnotation(annotation)
            }
            
        }
        
        mapPopsicles = []
        
<<<<<<< Updated upstream
<<<<<<< Updated upstream
        let ref = Database.database().reference(withPath:"currentPopsicles")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            // Printing the child count
            //print("There are \(snapshot.childrenCount) children found")

            // Checking if the reference has some values
            if snapshot.childrenCount > 0 {

                // Go through every child
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    if let data = data.value as? [String: Any] {
                        // Retrieve the data per child
                        
                        let eventDate = data["eventDate"] as! String
                                let eventName = data["eventName"] as! String
                                let eventCategory = data["eventCategory"] as! String
                                let eventCategoryDetails = data["eventCategoryDetails"] as! String
                                let eventDuration = data["eventDuration"] as! String
                                let eventInfo = data["eventInfo"] as! String
                                let eventSubcategory1 = data["eventSubcategory1"] as! String
                                let eventSubcategory1Details = data["eventSubcategory1Details"] as! String
                                let eventSubcategory2 = data["eventSubcategory2"] as! String
                                let eventSubcategory2Details = data["eventSubcategory2Details"] as! String
                                let latitude = data["latitude"] as! CLLocationDegrees
                                let longitude = data["longitude"] as! CLLocationDegrees
                                
                                let popsicleToAdd = pinPopsicle()
                                
                                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                                
                                let eventPopsicle: UIImage
                                
                                if (eventCategory == "Education") {
                                    
                                    eventPopsicle = UIImage(named: "educationButton")!
                                    
                                    
                                    
                                } else if (eventCategory == "Food") {
                                    
                                    eventPopsicle = UIImage(named: "foodButton")!
                                    
                                    
                                    
                                } else if (eventCategory == "Social") {
                                    
                                    eventPopsicle = UIImage(named: "socialButton")!
                                    
                                    
                                    
                                } else if (eventCategory == "Sports") {
                                    
                                    eventPopsicle = UIImage(named: "sportsButton")!
                                    
                                } else {
                                    
                                    eventPopsicle = UIImage(named: "showsButton")!
                                    
                                }
                                popsicleToAdd.popsicleData = pinData(eventName: eventName, eventInfo: eventInfo, eventDate: eventDate, eventDuration: eventDuration, eventCategory: eventCategory, eventCategoryDetails: eventCategoryDetails, eventSubcategory1: eventSubcategory1, eventSubcategory1Details: eventSubcategory1Details, eventSubcategory2: eventSubcategory2, eventSubcategory2Details: eventSubcategory2Details, eventLocation: coordinates, eventPopsicle: eventPopsicle)
                                
                                popsicleToAdd.coordinate = coordinates
                                
                                self.mapPopsicles?.append(popsicleToAdd)
                                
                                self.addNewPopsicleToMap()
                            
                        
                    }
                }
            }
        })
        
        
=======
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Popsicles")
        
        //3
        do {
          Popsicles = try managedContext.fetch(fetchRequest)
            
            for popsicle in Popsicles{
                let eventDate = popsicle.value(forKeyPath: "eventDate") as! String
                let eventName = popsicle.value(forKeyPath: "eventName") as! String
                let eventCategory = popsicle.value(forKeyPath: "eventCategory") as! String
                let eventCategoryDetails = popsicle.value(forKeyPath: "eventCategoryDetails") as! String
                let eventDuration = popsicle.value(forKeyPath: "eventDuration") as! String
                let eventInfo = popsicle.value(forKeyPath: "eventInfo") as! String
                let eventSubcategory1 = popsicle.value(forKeyPath: "eventSubcategory1") as! String
                let eventSubcategory1Details = popsicle.value(forKeyPath: "eventSubcategory1Details") as! String
                let eventSubcategory2 = popsicle.value(forKeyPath: "eventSubcategory2") as! String
                let eventSubcategory2Details = popsicle.value(forKeyPath: "eventSubcategory2Details") as! String
                let latitude = popsicle.value(forKeyPath: "latitude") as! CLLocationDegrees
                let longitude = popsicle.value(forKeyPath: "longitude") as! CLLocationDegrees


                let popsicleToAdd = pinPopsicle()
                
                                        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                
                                        let eventPopsicle: UIImage
                
                                        if (eventCategory == "Education") {
                
                                            eventPopsicle = UIImage(named: "educationButton")!
                
                
                
                                        } else if (eventCategory == "Food") {
                
                                            eventPopsicle = UIImage(named: "foodButton")!
                
                
                
                                        } else if (eventCategory == "Social") {
                
                                            eventPopsicle = UIImage(named: "socialButton")!
                
                
                
                                        } else if (eventCategory == "Sports") {
                
                                            eventPopsicle = UIImage(named: "sportsButton")!
                
                                        } else {
                
                                            eventPopsicle = UIImage(named: "showsButton")!
                
                                        }
                                        popsicleToAdd.popsicleData = pinData(eventName: eventName, eventInfo: eventInfo, eventDate: eventDate, eventDuration: eventDuration, eventCategory: eventCategory, eventCategoryDetails: eventCategoryDetails, eventSubcategory1: eventSubcategory1, eventSubcategory1Details: eventSubcategory1Details, eventSubcategory2: eventSubcategory2, eventSubcategory2Details: eventSubcategory2Details, eventLocation: coordinates, eventPopsicle: eventPopsicle)
                
                                        popsicleToAdd.coordinate = coordinates
                
                                        self.mapPopsicles?.append(popsicleToAdd)
                
                                        self.addNewPopsicleToMap()
                
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
=======
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Popsicles")
        
        //3
        do {
          Popsicles = try managedContext.fetch(fetchRequest)
            
            for popsicle in Popsicles{
                let eventDate = popsicle.value(forKeyPath: "eventDate") as! String
                let eventName = popsicle.value(forKeyPath: "eventName") as! String
                let eventCategory = popsicle.value(forKeyPath: "eventCategory") as! String
                let eventCategoryDetails = popsicle.value(forKeyPath: "eventCategoryDetails") as! String
                let eventDuration = popsicle.value(forKeyPath: "eventDuration") as! String
                let eventInfo = popsicle.value(forKeyPath: "eventInfo") as! String
                let eventSubcategory1 = popsicle.value(forKeyPath: "eventSubcategory1") as! String
                let eventSubcategory1Details = popsicle.value(forKeyPath: "eventSubcategory1Details") as! String
                let eventSubcategory2 = popsicle.value(forKeyPath: "eventSubcategory2") as! String
                let eventSubcategory2Details = popsicle.value(forKeyPath: "eventSubcategory2Details") as! String
                let latitude = popsicle.value(forKeyPath: "latitude") as! CLLocationDegrees
                let longitude = popsicle.value(forKeyPath: "longitude") as! CLLocationDegrees


                let popsicleToAdd = pinPopsicle()
                
                                        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                
                                        let eventPopsicle: UIImage
                
                                        if (eventCategory == "Education") {
                
                                            eventPopsicle = UIImage(named: "educationButton")!
                
                
                
                                        } else if (eventCategory == "Food") {
                
                                            eventPopsicle = UIImage(named: "foodButton")!
                
                
                
                                        } else if (eventCategory == "Social") {
                
                                            eventPopsicle = UIImage(named: "socialButton")!
                
                
                
                                        } else if (eventCategory == "Sports") {
                
                                            eventPopsicle = UIImage(named: "sportsButton")!
                
                                        } else {
                
                                            eventPopsicle = UIImage(named: "showsButton")!
                
                                        }
                                        popsicleToAdd.popsicleData = pinData(eventName: eventName, eventInfo: eventInfo, eventDate: eventDate, eventDuration: eventDuration, eventCategory: eventCategory, eventCategoryDetails: eventCategoryDetails, eventSubcategory1: eventSubcategory1, eventSubcategory1Details: eventSubcategory1Details, eventSubcategory2: eventSubcategory2, eventSubcategory2Details: eventSubcategory2Details, eventLocation: coordinates, eventPopsicle: eventPopsicle)
                
                                        popsicleToAdd.coordinate = coordinates
                
                                        self.mapPopsicles?.append(popsicleToAdd)
                
                                        self.addNewPopsicleToMap()
                
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }

        //let ref = Database.database().reference(withPath:"currentPopsicles")

//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            // Printing the child count
//            //print("There are \(snapshot.childrenCount) children found")
//            // Checking if the reference has some values
//            if snapshot.childrenCount > 0 {
//                // Go through every child
//                for data in snapshot.children.allObjects as! [DataSnapshot] {
//                    if let data = data.value as? [String: Any] {
//                        // Retrieve the data per child
//
//                        let eventDate = data["eventDate"] as! String
//                        let eventName = data["eventName"] as! String
//                        let eventCategory = data["eventCategory"] as! String
//                        let eventCategoryDetails = data["eventCategoryDetails"] as! String
//                        let eventDuration = data["eventDuration"] as! String
//                        let eventInfo = data["eventInfo"] as! String
//                        let eventSubcategory1 = data["eventSubcategory1"] as! String
//                        let eventSubcategory1Details = data["eventSubcategory1Details"] as! String
//                        let eventSubcategory2 = data["eventSubcategory2"] as! String
//                        let eventSubcategory2Details = data["eventSubcategory2Details"] as! String
//                        let latitude = data["latitude"] as! CLLocationDegrees
//                        let longitude = data["longitude"] as! CLLocationDegrees
//
//                        let popsicleToAdd = pinPopsicle()
//
//                        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//
//                        let eventPopsicle: UIImage
//
//                        if (eventCategory == "Education") {
//
//                            eventPopsicle = UIImage(named: "educationButton")!
//
//
//
//                        } else if (eventCategory == "Food") {
//
//                            eventPopsicle = UIImage(named: "foodButton")!
//
//
//
//                        } else if (eventCategory == "Social") {
//
//                            eventPopsicle = UIImage(named: "socialButton")!
//
//
//
//                        } else if (eventCategory == "Sports") {
//
//                            eventPopsicle = UIImage(named: "sportsButton")!
//
//                        } else {
//
//                            eventPopsicle = UIImage(named: "showsButton")!
//
//                        }
//                        popsicleToAdd.popsicleData = pinData(eventName: eventName, eventInfo: eventInfo, eventDate: eventDate, eventDuration: eventDuration, eventCategory: eventCategory, eventCategoryDetails: eventCategoryDetails, eventSubcategory1: eventSubcategory1, eventSubcategory1Details: eventSubcategory1Details, eventSubcategory2: eventSubcategory2, eventSubcategory2Details: eventSubcategory2Details, eventLocation: coordinates, eventPopsicle: eventPopsicle)
//
//                        popsicleToAdd.coordinate = coordinates
//
//                        self.mapPopsicles?.append(popsicleToAdd)
//
//                        self.addNewPopsicleToMap()
//
//
//                    }
//                }
//            }
//        })
>>>>>>> Stashed changes

        //let ref = Database.database().reference(withPath:"currentPopsicles")

//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            // Printing the child count
//            //print("There are \(snapshot.childrenCount) children found")
//            // Checking if the reference has some values
//            if snapshot.childrenCount > 0 {
//                // Go through every child
//                for data in snapshot.children.allObjects as! [DataSnapshot] {
//                    if let data = data.value as? [String: Any] {
//                        // Retrieve the data per child
//
//                        let eventDate = data["eventDate"] as! String
//                        let eventName = data["eventName"] as! String
//                        let eventCategory = data["eventCategory"] as! String
//                        let eventCategoryDetails = data["eventCategoryDetails"] as! String
//                        let eventDuration = data["eventDuration"] as! String
//                        let eventInfo = data["eventInfo"] as! String
//                        let eventSubcategory1 = data["eventSubcategory1"] as! String
//                        let eventSubcategory1Details = data["eventSubcategory1Details"] as! String
//                        let eventSubcategory2 = data["eventSubcategory2"] as! String
//                        let eventSubcategory2Details = data["eventSubcategory2Details"] as! String
//                        let latitude = data["latitude"] as! CLLocationDegrees
//                        let longitude = data["longitude"] as! CLLocationDegrees
//
//                        let popsicleToAdd = pinPopsicle()
//
//                        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//
//                        let eventPopsicle: UIImage
//
//                        if (eventCategory == "Education") {
//
//                            eventPopsicle = UIImage(named: "educationButton")!
//
//
//
//                        } else if (eventCategory == "Food") {
//
//                            eventPopsicle = UIImage(named: "foodButton")!
//
//
//
//                        } else if (eventCategory == "Social") {
//
//                            eventPopsicle = UIImage(named: "socialButton")!
//
//
//
//                        } else if (eventCategory == "Sports") {
//
//                            eventPopsicle = UIImage(named: "sportsButton")!
//
//                        } else {
//
//                            eventPopsicle = UIImage(named: "showsButton")!
//
//                        }
//                        popsicleToAdd.popsicleData = pinData(eventName: eventName, eventInfo: eventInfo, eventDate: eventDate, eventDuration: eventDuration, eventCategory: eventCategory, eventCategoryDetails: eventCategoryDetails, eventSubcategory1: eventSubcategory1, eventSubcategory1Details: eventSubcategory1Details, eventSubcategory2: eventSubcategory2, eventSubcategory2Details: eventSubcategory2Details, eventLocation: coordinates, eventPopsicle: eventPopsicle)
//
//                        popsicleToAdd.coordinate = coordinates
//
//                        self.mapPopsicles?.append(popsicleToAdd)
//
//                        self.addNewPopsicleToMap()
//
//
//                    }
//                }
//            }
//        })


>>>>>>> Stashed changes
    }
    
    /*
        confirmLocation: called by the confirmButton once the user has decided which location to use...
        ...for their popsicle.
            - Once pressed, the map center location is recorded and every element of the pin placement...
              ...interface is hidden.
            - A new element of the mapPopsicles array is created and initialized using the information from...
              ...the popsicle template and the map center location.
            - The popsicle is added to the mapPopsicles array.
            - Then, the addNewPopsicleToMap function is called to add the popsicle to the map as an annotation.
            - Finally, the addEventToMenu function is called to add (if possible) the event to the informative...
              tab on the menu about my most recent events.
     */
    
    @IBAction func confirmLocation(_ sender: Any) {
        
        let ref = Database.database().reference()
        
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
          NSEntityDescription.entity(forEntityName: "Popsicles",
                                     in: managedContext)!
        
        let popsicle = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        

<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
        let eventDate = newPopsicle.popsicleData.eventDate
        
        let currentDate = Date()
        let currentCalendar = Calendar.current
        let currentHour = currentCalendar.component(.hour, from: currentDate)
        let currentMinute = currentCalendar.component(.minute, from: currentDate)
        let currentDay = currentCalendar.component(.day, from: currentDate)
        let currentMonth = currentCalendar.component(.month, from: currentDate)
        let currentYear = currentCalendar.component(.year, from: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: eventDate)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        
        let hour = components.hour!
        let year = components.year!
        let month = components.month!
        let day = components.day!
        let minute = components.minute!
        
        if year == currentYear && month == currentMonth && day >= currentDay {
<<<<<<< Updated upstream
            
            if (day > currentDay && day - currentDay == 1 && hour < currentHour) || day == currentDay || ( day - currentDay == 1 && hour == currentHour && minute <= currentMinute){
                
                ref.child("currentPopsicles/\(newPopsicle.popsicleData.eventName)/latitude").setValue(mainMapView.centerCoordinate.latitude)
                
                ref.child("currentPopsicles/\(newPopsicle.popsicleData.eventName)/longitude").setValue(mainMapView.centerCoordinate.longitude)
                
                let en = newPopsicle.popsicleData.eventName
                ref.child("currentPopsicles/\(en)/eventName").setValue(newPopsicle.popsicleData.eventName)
                
                ref.child("currentPopsicles/\(en)/eventInfo").setValue(newPopsicle.popsicleData.eventInfo)
                
                ref.child("currentPopsicles/\(en)/eventDate").setValue(newPopsicle.popsicleData.eventDate)
                
                ref.child("currentPopsicles/\(en)/eventDuration").setValue(newPopsicle.popsicleData.eventDuration)
                
                ref.child("currentPopsicles/\(en)/eventCategory").setValue(newPopsicle.popsicleData.eventCategory)
                
                ref.child("currentPopsicles/\(en)/eventCategoryDetails").setValue(newPopsicle.popsicleData.eventCategoryDetails)
                
                ref.child("currentPopsicles/\(en)/eventSubcategory1").setValue(newPopsicle.popsicleData.eventSubcategory1)
                
                ref.child("currentPopsicles/\(en)/eventSubcategory1Details").setValue(newPopsicle.popsicleData.eventSubcategory1Details)
                
                ref.child("currentPopsicles/\(en)/eventSubcategory2").setValue(newPopsicle.popsicleData.eventSubcategory2)
                
                ref.child("currentPopsicles/\(en)/eventSubcategory2Details").setValue(newPopsicle.popsicleData.eventSubcategory2Details)
                
            }
            
=======

          if (day > currentDay && day - currentDay == 1 && hour < currentHour) || day == currentDay || ( day - currentDay == 1 && hour == currentHour && minute <= currentMinute){
            
            popsicle.setValue(mainMapView.centerCoordinate.latitude, forKeyPath: "latitude")
            popsicle.setValue(mainMapView.centerCoordinate.longitude, forKeyPath: "longitude")
            popsicle.setValue(newPopsicle.popsicleData.eventName, forKeyPath: "eventName")
            popsicle.setValue(newPopsicle.popsicleData.eventInfo, forKeyPath: "eventInfo")
            popsicle.setValue(newPopsicle.popsicleData.eventDate, forKeyPath: "eventDate")
            popsicle.setValue(newPopsicle.popsicleData.eventDuration, forKeyPath: "eventDuration")
            popsicle.setValue(newPopsicle.popsicleData.eventCategory, forKeyPath: "eventCategory")
            popsicle.setValue(newPopsicle.popsicleData.eventCategoryDetails, forKeyPath: "eventCategoryDetails")
            popsicle.setValue(newPopsicle.popsicleData.eventSubcategory1, forKeyPath: "eventSubcategory1")
            popsicle.setValue(newPopsicle.popsicleData.eventSubcategory1Details, forKeyPath: "eventSubcategory1Details")
            popsicle.setValue(newPopsicle.popsicleData.eventSubcategory2, forKeyPath: "eventSubcategory2")
            popsicle.setValue(newPopsicle.popsicleData.eventSubcategory2Details, forKeyPath: "eventSubcategory2Details")

            
            // 4
            do {
              try managedContext.save()
              Popsicles.append(popsicle)
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }

            ref.child("currentPopsicles/\(newPopsicle.popsicleData.eventName)/latitude").setValue(mainMapView.centerCoordinate.latitude)

            ref.child("currentPopsicles/\(newPopsicle.popsicleData.eventName)/longitude").setValue(mainMapView.centerCoordinate.longitude)

            let en = newPopsicle.popsicleData.eventName
            ref.child("currentPopsicles/\(en)/eventName").setValue(newPopsicle.popsicleData.eventName)

            ref.child("currentPopsicles/\(en)/eventInfo").setValue(newPopsicle.popsicleData.eventInfo)

            ref.child("currentPopsicles/\(en)/eventDate").setValue(newPopsicle.popsicleData.eventDate)

            ref.child("currentPopsicles/\(en)/eventDuration").setValue(newPopsicle.popsicleData.eventDuration)

            ref.child("currentPopsicles/\(en)/eventCategory").setValue(newPopsicle.popsicleData.eventCategory)

            ref.child("currentPopsicles/\(en)/eventCategoryDetails").setValue(newPopsicle.popsicleData.eventCategoryDetails)

            ref.child("currentPopsicles/\(en)/eventSubcategory1").setValue(newPopsicle.popsicleData.eventSubcategory1)

            ref.child("currentPopsicles/\(en)/eventSubcategory1Details").setValue(newPopsicle.popsicleData.eventSubcategory1Details)

            ref.child("currentPopsicles/\(en)/eventSubcategory2").setValue(newPopsicle.popsicleData.eventSubcategory2)

            ref.child("currentPopsicles/\(en)/eventSubcategory2Details").setValue(newPopsicle.popsicleData.eventSubcategory2Details)

          }

>>>>>>> Stashed changes
        else{
            
            ref.child("upcomingPopsicles/\(newPopsicle.popsicleData.eventName)/latitude").setValue(mainMapView.centerCoordinate.latitude)
            
            ref.child("upcomingPopsicles/\(newPopsicle.popsicleData.eventName)/longitude").setValue(mainMapView.centerCoordinate.longitude)
            
            let en = newPopsicle.popsicleData.eventName
            ref.child("upcomingPopsicles/\(en)/eventName").setValue(newPopsicle.popsicleData.eventName)
            
            ref.child("upcomingPopsicles/\(en)/eventInfo").setValue(newPopsicle.popsicleData.eventInfo)
            
            ref.child("upcomingPopsicles/\(en)/eventDate").setValue(newPopsicle.popsicleData.eventDate)
            
            ref.child("upcomingPopsicles/\(en)/eventDuration").setValue(newPopsicle.popsicleData.eventDuration)
            
            ref.child("upcomingPopsicles/\(en)/eventCategory").setValue(newPopsicle.popsicleData.eventCategory)
            
            ref.child("upcomingPopsicles/\(en)/eventCategoryDetails").setValue(newPopsicle.popsicleData.eventCategoryDetails)
            
            ref.child("upcomingPopsicles/\(en)/eventSubcategory1").setValue(newPopsicle.popsicleData.eventSubcategory1)
            
            ref.child("upcomingPopsicles/\(en)/eventSubcategory1Details").setValue(newPopsicle.popsicleData.eventSubcategory1Details)
            
            ref.child("upcomingPopsicles/\(en)/eventSubcategory2").setValue(newPopsicle.popsicleData.eventSubcategory2)
            
            ref.child("upcomingPopsicles/\(en)/eventSubcategory2Details").setValue(newPopsicle.popsicleData.eventSubcategory2Details)
            
        }
        }
        
        
        newPopsicle.popsicleData.eventLocation = mainMapView.centerCoordinate
        
        newPopsicle.coordinate = newPopsicle.popsicleData.eventLocation
        
        UIView.transition(with: eventLocationConfirmationContainerView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            
            self.eventLocationConfirmationContainerView.alpha = 0.0
            
        }, completion: { (true) in
            
            self.eventLocationConfirmationContainerView.isHidden = true
            
        })
        
        placingPin = false
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        eventLocationPin.isHidden = true
        
        zoomToUserLocationButton.isHidden = true
        
        let popsicleToAdd = pinPopsicle()
        
        popsicleToAdd.popsicleData = pinData(eventName: newPopsicle.popsicleData.eventName, eventInfo: newPopsicle.popsicleData.eventInfo, eventDate: newPopsicle.popsicleData.eventDate, eventDuration: newPopsicle.popsicleData.eventDuration, eventCategory: newPopsicle.popsicleData.eventCategory, eventCategoryDetails: newPopsicle.popsicleData.eventCategoryDetails, eventSubcategory1: newPopsicle.popsicleData.eventSubcategory1, eventSubcategory1Details: newPopsicle.popsicleData.eventSubcategory1Details, eventSubcategory2: newPopsicle.popsicleData.eventSubcategory2, eventSubcategory2Details: newPopsicle.popsicleData.eventSubcategory2Details, eventLocation: newPopsicle.popsicleData.eventLocation, eventPopsicle: newPopsicle.popsicleData.eventPopsicle)
        
        popsicleToAdd.coordinate = popsicleToAdd.popsicleData.eventLocation
        
        //mapPopsicles?.append(popsicleToAdd)
        
        //addNewPopsicleToMap()
        refreshDatabase()
        
        getPopsicles()
        
        showMainButtons()
        
        addEventToMenu(eventName: newPopsicle.popsicleData.eventName)
        
    }
    
    /*
        addNewPopsicleToMap: private helper method called by confirmLocation which takes the last element...
        ...added to the mapPopsicles array (the newly added popsicle) and adds it to the map view as an...
        ...annotation. End of the create event cycle :D
     */
    
    private func addNewPopsicleToMap() {
        
        if (mapPopsicles?.last != nil) {
            
            mainMapView.addAnnotation((mapPopsicles?.last)!)
                    
        } else {
            
            print("\nERROR: Trying to add a repeated or non-existent popsicle.\n")
            
        }
        
    }
    
    /*
        addEventToMenu: private helper method that adds an informative button to the myEvents...
        ...menu Stack View with the newly create event (up to 3).
            - For now, it simply takes the name of the event and creates a button and sets this name...
              ...to be the title of the button.
            - Then it styles the button and inserts it at the top of the stack.
            - Also, if this is the first event created by the user, then the noEventsLabel is hidden.
     */
    
    private func addEventToMenu (eventName: String) {
        
        if (!noEventsLabel.isHidden) {
            
            noEventsLabel.isHidden = true
            
            let newEventView = UIButton(type: .system)
            
            newEventView.setTitle(eventName, for: .normal)
            
            newEventView.titleLabel?.font = UIFont(name: "Octarine-Bold", size: 17)
            
            newEventView.tintColor = .white
            
            newEventView.titleLabel?.minimumScaleFactor = 0.7
            
            newEventView.titleLabel?.numberOfLines = 1
            
            newEventView.contentEdgeInsets.left = 5
            
            newEventView.contentEdgeInsets.right = 5
            
            newEventView.backgroundColor = myEventsButton.backgroundColor
            
            myEventsMenuStackView.insertArrangedSubview(newEventView, at: 0)
            
        } else if (myEventsMenuStackView.arrangedSubviews.count < 5) {
            
            let newEventView = UIButton(type: .system)
            
            newEventView.setTitle(eventName, for: .normal)
            
            newEventView.titleLabel?.font = UIFont(name: "Octarine-Bold", size: 17)
            
            newEventView.tintColor = .white
            
            newEventView.titleLabel?.adjustsFontSizeToFitWidth = true
            
            newEventView.titleLabel?.minimumScaleFactor = 0.7
            
            newEventView.titleLabel?.numberOfLines = 1
            
            newEventView.contentEdgeInsets.left = 5
            
            newEventView.contentEdgeInsets.right = 5
            
            newEventView.backgroundColor = myEventsButton.backgroundColor

            myEventsMenuStackView.insertArrangedSubview(newEventView, at: 0)
            
        }
        
    }
    
    /*
        addShadowAndRoundCorners: private helper method used to style the views by the viewDidLoad and...
        ...viewDidLayoutSubviews.
     */
    
    private func addShadowAndRoundCorners (currentView: UIView) {
        
        currentView.layer.masksToBounds = false
        
        currentView.layer.cornerRadius = 8.0
        
        currentView.layer.shadowColor = UIColor.black.cgColor
        
        currentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        currentView.layer.shadowOpacity = 0.3
        
        currentView.layer.shadowRadius = 2
        
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
    
}

/*
    The following functions are called by the mapView itself (since the map itself is its own delegate)...
    ...to regulate several of its features.
 */

extension mainViewController: MKMapViewDelegate {
    
    /*
        regionWillChangeAnimated: delegate function called by the map view every time it needs to change...
        ...something from it.
            - In this case it is only used to show the Dragging Notification after the pin placement...
              ...interface shows up.
     */
    
    public func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if (placingPin) {
            
            UIView.transition(with: eventLocationDraggingNotification, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                
                self.eventLocationDraggingNotification.alpha = 0.0
                
            }, completion: { (true) in
                
                self.eventLocationDraggingNotification.isHidden = true
                
            })
            
        }
        
    }
    
    /*
        regionDidChangeAnimated: delegate function called by the map view every time it has finished...
        ...changing something from it.
            - In this case it is used to get the location from the center of the screen.
            - Use this center location to look up its correspoding address through the use of the private...
              ...helper method lookUpSpecifiedLocation.
            - Use the address obtained to fill out the eventLocationConfirmationAddress that the user sees and...
              ...confirms if the address is correct.
            - Since the eventLocationConfirmationContainerView is initially hidden, it does a fade transition to...
              ...show it the first time.
     */
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if (placingPin) {
        
            let centerCoordinate = mapView.centerCoordinate
        
            let centerLocation = CLLocation(latitude: centerCoordinate.latitude - 0.0001, longitude: centerCoordinate.longitude)
        
            lookUpSpecifiedLocation(location: centerLocation) { (placemark) in
            
                if (placemark != nil) {
                
                    self.eventLocationConfirmationAddress.text =  self.parseAddress(selectedItem: placemark!)
                    
                    if (self.eventLocationConfirmationContainerView.isHidden) {
                        
                        UIView.transition(with: self.eventLocationConfirmationContainerView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                                
                            self.eventLocationConfirmationContainerView.alpha = 1
                            
                            self.eventLocationConfirmationContainerView.isHidden = false
                            
                        }, completion: { (true) in
                            
                        })
                        
                    }
                
                } else {
                
                    print("\nError: unable to retrieve address from center location.\n")
                
                }
            
            }
        
        }
            
    }
    
    /*
        viewFor: delegate function called by the map view every time it renders its annotations.
            - Since this method is called for every annotation present on the map we must distinct...
              ...the ones we need which are the user annotation and the annotations of the popsicles.
            - Once they have been identified, we give them an identifier so they do not have to be...
              ...initialized every time.
            - We style the annotation accordingly.
            - We return the annotation once again so the map can present it.
     */
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // USER ANNOTATION
        
        if (annotation.isEqual(mainMapView.userLocation)) {

            let userIdentifier = "UserLocation"
            
            var userAnnotationView = mainMapView.dequeueReusableAnnotationView(withIdentifier: userIdentifier)
            
            if userAnnotationView == nil {
                
                userAnnotationView = MKAnnotationView(annotation:annotation, reuseIdentifier:userIdentifier)
                
            }
            
            userAnnotationView!.annotation = annotation
            
            userAnnotationView!.canShowCallout = false

            userAnnotationView!.image = UIImage(named: "Profile Pic")
            
            userAnnotationView!.frame.size.width = 40
            
            userAnnotationView!.frame.size.height = 40
            
            userAnnotationView!.layer.cornerRadius = userAnnotationView!.frame.height / 2
            
            userAnnotationView!.layer.borderColor = UIColor.white.cgColor
            
            userAnnotationView!.layer.borderWidth = 3
            
            userAnnotationView!.clipsToBounds = true
            
            userAnnotationView!.layer.masksToBounds = true
            
            userAnnotationView!.contentMode = .scaleAspectFit
            
            return userAnnotationView
            
        }
            
        // POPSICLES PIN ANNOTATIONS
        
        else if (annotation is pinPopsicle) {
            
            let popsicleAnnotation = annotation as! pinPopsicle
            
            let popsicleIdentifier = popsicleAnnotation.popsicleData!.eventName
            
            var popsicleAnnotationView = mainMapView.dequeueReusableAnnotationView(withIdentifier: popsicleIdentifier)
            
            if popsicleAnnotationView == nil {
                
                popsicleAnnotationView = MKAnnotationView(annotation:annotation, reuseIdentifier:popsicleIdentifier)
                
            }
            
            popsicleAnnotation.title = popsicleAnnotation.popsicleData.eventName
            
            popsicleAnnotation.subtitle = popsicleAnnotation.popsicleData.eventInfo
            
            popsicleAnnotationView!.annotation = popsicleAnnotation
            
            popsicleAnnotationView!.canShowCallout = true

            popsicleAnnotationView!.image = popsicleAnnotation.popsicleData?.eventPopsicle
            
            popsicleAnnotationView!.frame.size = CGSize(width: eventLocationPin.frame.width, height: eventLocationPin.frame.height)
            
            return popsicleAnnotationView
            
        }
        
        return nil

    }
    
    /*
        lookUpSpecifiedLocation: private helper method that takes a location and uses a CLGeocoder...
        ...to find its corresponding address. If an address is found, it returns the first one (since...
        ...more than one might be found). Else, it returns an error.
            - The return variable is a Void but still something is returned. This is a programming technique...
              ...used in Swift. What is really going on is that another function is passed as a parameter...
              ...this function passed (the completion handler, which is defined on the caller function)...
              ...is awaiting a parameter (the return value!)...
              ...once it has been passed a parameter it runs back on the original function.
            - The above technique stops the course of the original function and makes it wait til this function...
              ...finishes. Since geocoder runs on a different thread simultaneously, this technique is needed to...
              ...prevent errors.
     
     */
    
    private func lookUpSpecifiedLocation(location:CLLocation, completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler.
        
        geocoder.reverseGeocodeLocation(location,
                                        completionHandler: { (placemarks, error) in
                                            
                                            if error == nil {
                                                
                                                let firstLocation = placemarks?[0]
                                                
                                                completionHandler(firstLocation)
                                                
                                            }
                                            else {
                                                
                                                // An error occurred during geocoding.
                                                
                                                completionHandler(nil)
                                                
                                            }
                                            
        })
        
    }
    
    /*
        parseAddress: private helper method that parses an address from a CLPlacemark since...
        ...it does not have a method that does it by default.
            - It simply takes all the different information stored in a CLPlacemark and writes...
              ...it into a formated address String.
            - It is inspired from a source on the internet.
     */
    
    private func parseAddress(selectedItem:CLPlacemark) -> String {
        
        // put a space between a street number and a street name for example:
        
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state:
        
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC" for example:
        
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        
        let parsedAddress = String(
            format:"%@%@%@%@%@%@%@",
            
            // street number
            
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            
            // street name
            
            selectedItem.thoroughfare ?? "",
            comma,
            
            // city
            
            selectedItem.locality ?? "",
            secondSpace,
            
            // state
            
            selectedItem.administrativeArea ?? ""
            
        )
        
        return parsedAddress
        
    }
    
}

/*
    The dropPinZoomIn function used by the MapSearchProtocol is defined in this add-on to the mainViewController.
 */

extension mainViewController: MapSearchProtocol {
    
    /*
        dropPinZoomIn: function defined in the Map Search Protocol. It is called by the Location Search Table whenever needed.
            - Once the user has picked a suggestion from the search bar table, the search bar changes its text to the suggestion title...
              ...selected.
            - Using the location from the suggestion, the map is zoomed and centered to show this location. The popsicle icon should be...
              ...should be positioned right at this location.
     */
    
    public func dropPinZoomIn (placemark: MKPlacemark) {
        
        // Changes the search bar text to the option selected.
        
        resultSearchController!.searchBar.text = placemark.name
        
        // Zooms and centers the map to the location of the suggestion.
        
        var region = MKCoordinateRegion()
        
        region.center.latitude = placemark.coordinate.latitude
        
        region.center.longitude = placemark.coordinate.longitude
        
        region.span.latitudeDelta = 0
        
        region.span.longitudeDelta = 0

        mainMapView.setRegion(region, animated: true)
        
    }
    
}

/*
    Add-on functions to the UILabels of the mainViewController.
 */

extension UILabel {
    
    /*
        underline: it adds an underline text feature to the labels in the mainViewController.
     */
    
    public func underline () {
        
        if let textString = text {
            
            let attributedString = NSMutableAttributedString(string: textString)
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
            
        }
        
    }
    
}
