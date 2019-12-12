//
//  mainViewController.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 10/13/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol createEventViewControllerReturnProtocol : NSObjectProtocol {

    func setUserPinData(en: String, ei: String, ed: String, edu: String, ec: String, ecd: String, es1: String, es1d: String, es2: String, es2d: String)
     
    func showMainButtons()
    
}

protocol HandleMapSearch: class {
    
    func dropPinZoomIn(placemark:MKPlacemark)
    
}

class mainViewController: UIViewController, createEventViewControllerReturnProtocol, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    // SLIDE OUT MENU VARIABLES:
    
        // Filter checkers.
    
    var educationActive = true
    
    var foodActive = true
    
    var socialActive = true
    
    var sportsActive = true
    
    var showsActive = true
    
        // Menu Pan Recognizers and other misc.
    
    var menuEdgePanGestureRecognizer:UIScreenEdgePanGestureRecognizer?
    
    var menuOutsideTapGestureRecognizer:UITapGestureRecognizer?
    
    var menuShowing = false;
    
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
    var pink: UIColor?
    
    var navy: UIColor?
    
    var cream: UIColor?
    
    var initialMenuConstraintHasBeenLoaded = false
    
        // Menu Variables.
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var menuButton: UIButton!
    
        // Profile View and Elements:
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    
        // Main Menu Items: Filters and My Events.
    
    @IBOutlet weak var mainMenuItemsView: UIScrollView!
    
        // Filter Menu View:
    
    @IBOutlet weak var filterMenuView: UIView!
    
    @IBOutlet weak var filterMenuLabel: UILabel!
    
        // Filters Stack View.
    
    @IBOutlet weak var filtersStackView: UIStackView!
    
        // Education Filter.
    
    @IBOutlet weak var educationFilterView: categoryButtonView!
    
    @IBOutlet weak var educationFilterIcon: UIImageView!
    
    @IBOutlet weak var educationFilterLegend: UILabel!
    
    @IBOutlet weak var educationFilterButton: UIButton!
    
        // Food Filter.
    
    @IBOutlet weak var foodFilterView: categoryButtonView!
    
    @IBOutlet weak var foodFilterIcon: UIImageView!
    
    @IBOutlet weak var foodFilterLegend: UILabel!
    
    @IBOutlet weak var foodFilterButton: UIButton!
    
        // Social Filter.
    
    @IBOutlet weak var socialFilterView: categoryButtonView!
    
    @IBOutlet weak var socialFilterIcon: UIImageView!
    
    @IBOutlet weak var socialFilterLegend: UILabel!
    
    @IBOutlet weak var socialFilterButton: UIButton!
    
        // Sports Filter.
    
    @IBOutlet weak var sportsFilterView: categoryButtonView!
    
    @IBOutlet weak var sportsFilterIcon: UIImageView!
    
    @IBOutlet weak var sportsFilterLegend: UILabel!
    
    @IBOutlet weak var sportsFilterButton: UIButton!
    
        // Shows Filter.
    
    @IBOutlet weak var showsFilterView: categoryButtonView!
    
    @IBOutlet weak var showsFilterIcon: UIImageView!
    
    @IBOutlet weak var showsFilterLegend: UILabel!
    
    @IBOutlet weak var showsFilterButton: UIButton!
    
        // My Events Menu View:
    
    @IBOutlet weak var myEventsMenuView: UIView!
    
    @IBOutlet weak var myEventsMenuLabel: UILabel!
    
    @IBOutlet weak var myEventsMenuStackView: UIStackView!
    
    @IBOutlet weak var noEventsLabel: UILabel!
    
    @IBOutlet weak var myEventsButton: UIButton!
    
    // MAIN VIEW MAP VARIABLES:
    
    var resultSearchController:UISearchController? = nil
    
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mainMapView: MKMapView!
    
    @IBOutlet weak var newEventButton: createEventButton!
    
    var centerCoordinate: CLLocationCoordinate2D!
    
    var centerAnnotation: MKPointAnnotation!
    
    var mapPopsicles:[pinPopsicle]?
    
    var newPopsicle: pinPopsicle!
    
    var userLocation: CLLocation!
    
    var selectedPin: MKPlacemark?
    
    var placingPin: Bool!
    
    @IBOutlet weak var eventLocationPin: UIImageView!
    
    @IBOutlet weak var eventLocationDraggingNotification: UILabel!
    
    @IBOutlet weak var eventLocationConfirmationContainerView: UIView!
    
    @IBOutlet weak var eventLocationConfirmationView: UIView!
    
    @IBOutlet weak var eventLocationConfirmationLabel: UILabel!
    
    @IBOutlet weak var eventLocationConfirmationAddress: UILabel!
    
    @IBOutlet weak var eventLocationConfirmationButton: UIButton!
    
    @IBOutlet weak var zoomToUserLocationButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("\nWELCOME! This is the poppin terminal. Error messages and system notificans can be seen here.\n")
        
        // Adjusting Font Size:
        
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

        // Initialize colors:
        
        pink = UIColorFromHex(rgbValue: 0xFFC3D5)
        
        navy = UIColorFromHex(rgbValue: 0x002868)
        
        cream = UIColorFromHex(rgbValue: 0xFFF0D8)
        
        // Add shadows to the menu:
        
        menuView.layer.masksToBounds = false
        
        menuView.layer.cornerRadius = 8
        
        menuView.layer.shadowColor = UIColor.black.cgColor
        
        menuView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        menuView.layer.shadowOpacity = 0.5
        
        menuView.layer.shadowRadius = 3
        
        menuView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        // Add shadows to the profile view:
        
        profileView.layer.masksToBounds = false
        
        profileView.layer.cornerRadius = 8
        
        profileView.layer.shadowColor = UIColor.black.cgColor
        
        profileView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        profileView.layer.shadowOpacity = 0.5
        
        profileView.layer.shadowRadius = 3
        
        profileView.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        // Add shadows to the menu filter view:
        
        filterMenuView.layer.masksToBounds = false
        
        filterMenuView.layer.cornerRadius = 8
        
        filterMenuView.layer.shadowColor = UIColor.black.cgColor
        
        filterMenuView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        filterMenuView.layer.shadowOpacity = 0.5
        
        filterMenuView.layer.shadowRadius = 3
        
        // Adjusts menu items scrollview parameters:
        
        mainMenuItemsView.layer.masksToBounds = false
        
        mainMenuItemsView.layer.cornerRadius = 8
        
        mainMenuItemsView.showsVerticalScrollIndicator = false
        
        // Add shadows to my events menu view:
        
        myEventsMenuView.layer.masksToBounds = false
        
        myEventsMenuView.layer.cornerRadius = 8
        
        myEventsMenuView.layer.shadowColor = UIColor.black.cgColor
        
        myEventsMenuView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        myEventsMenuView.layer.shadowOpacity = 0.5
        
        myEventsMenuView.layer.shadowRadius = 3
        
        // Creating categoryButtonViews for the filter buttons:
        
        educationFilterView.setParameters(ci: educationFilterIcon, cll: educationFilterLegend, cb: educationFilterButton)
        
        educationFilterView.isSelected = true
        
        educationFilterView.layer.cornerRadius = 10
        
        foodFilterView.setParameters(ci: foodFilterIcon, cll: foodFilterLegend, cb: foodFilterButton)
        
        foodFilterView.isSelected = true
        
        foodFilterView.layer.cornerRadius = 10
        
        socialFilterView.setParameters(ci: socialFilterIcon, cll: socialFilterLegend, cb: socialFilterButton)
        
        socialFilterView.isSelected = true
        
        socialFilterView.layer.cornerRadius = 10
        
        sportsFilterView.setParameters(ci: sportsFilterIcon, cll: sportsFilterLegend, cb: sportsFilterButton)
        
        sportsFilterView.isSelected = true
        
        sportsFilterView.layer.cornerRadius = 10
        
        showsFilterView.setParameters(ci: showsFilterIcon, cll: showsFilterLegend, cb: showsFilterButton)
        
        showsFilterView.isSelected = true
        
        showsFilterView.layer.cornerRadius = 10
        
        // Do any additional setup for the slide out menu after loading the view.
        
        menuEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        menuEdgePanGestureRecognizer?.delegate = self
        
        menuEdgePanGestureRecognizer?.edges = .left
        
        view.addGestureRecognizer(menuEdgePanGestureRecognizer!)
        
        let panGestureRecognizser = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)) )
        
        view.addGestureRecognizer(panGestureRecognizser)
        
        menuOutsideTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideMenuOnTap(_ :)) )
        
        mainMapView.addGestureRecognizer(menuOutsideTapGestureRecognizer!)
        
        logoutButton.layer.cornerRadius = 9
        
        logoutButton.clipsToBounds = true
        
        myEventsButton.layer.cornerRadius = 9
        
        myEventsButton.clipsToBounds = true
        
        // Initializes the mapPopsicles:
        
        mapPopsicles = []
        
        // Disables dark mode on the map.
        
        overrideUserInterfaceStyle = .light
        
        // Hide the placement pin view objects:
        
        placingPin = false

        eventLocationPin.isHidden = true
        
        eventLocationDraggingNotification.isHidden = true
        
        eventLocationConfirmationContainerView.isHidden = true
        
        zoomToUserLocationButton.isHidden = true
        
        // Initialize userPinData:
        
        newPopsicle = pinPopsicle()
        
        newPopsicle.popsicleData = pinData(eventName: "", eventInfo: "", eventDate: "", eventDuration: "", eventCategory: "", eventCategoryDetails: "", eventSubcategory1: "", eventSubcategory1Details: "", eventSubcategory2: "", eventSubcategory2Details: "", eventLocation: CLLocationCoordinate2D(latitude: 39.6766, longitude: -104.9619), eventPopsicle: UIImage(named: "categoryButtonNP")!)
        
        // Do any additional setup after loading the view.
        
        let duLocation = CLLocationCoordinate2D(latitude: 39.6766, longitude: -104.9619)
        
        let regionRadius: CLLocationDistance = 1500.0
        
        let region = MKCoordinateRegion(center: duLocation, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        // Disable Rotation.
        
        mainMapView.isRotateEnabled = false
        
        /*
         To make sure users do not accidentally pan away from the event and get
         lost, apply a camera boundary. This ensures that the center point of
         the map always remain inside this region.
        */
        
        mainMapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: region)

        /*
         There is no reason for users to zoom out to view all of California and
         beyond, nor does the event map have enough details to make detailed
         zoom levels relevant. Apply a camera zoom range to restrict how far in
         and out users can zoom in the map view.
        */
        
        mainMapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 250, maxCenterCoordinateDistance: 3000)
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.startUpdatingLocation()
        
        mainMapView.register(MKUserLocation.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(MKUserLocation.self))

        mainMapView.setRegion(region, animated: true)

        mainMapView.delegate = self
        
        // Set up search bar for location search.
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        
        searchBar.isTranslucent = false
        
        searchBar.sizeToFit()
        
        searchBar.placeholder = "Search event address..."
        
        searchBar.searchTextField.font = UIFont(name: "Octarine-Light", size: 15)
        
        searchBar.searchTextField.textColor = UIColor.black
        
        searchBar.searchTextField.backgroundColor = UIColor.white
        
        searchBar.searchTextField.layer.masksToBounds = false
        
        searchBar.searchTextField.layer.cornerRadius = 15.0
        
        searchBar.searchTextField.layer.shadowColor = UIColor.black.cgColor
        
        searchBar.searchTextField.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        searchBar.searchTextField.layer.shadowOpacity = 0.3
        
        searchBar.searchTextField.layer.shadowRadius = 2
        
        searchBar.searchTextField.sizeToFit()
        
        let glassIconView = searchBar.searchTextField.leftView as? UIImageView
        
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        
        glassIconView?.tintColor = UIColor.gray
        
        let attributes = [
            
            NSAttributedString.Key.foregroundColor : UIColorFromHex(rgbValue: 0x002868),
            
            NSAttributedString.Key.font : UIFont.init(name: "Octarine-Bold", size: 15)
            
        ]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        
        definesPresentationContext = true
        
        locationSearchTable.maxRegion = region
        
        locationSearchTable.handleMapSearchDelegate = self

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.view.backgroundColor = UIColor.clear
    
        // Hide search bar:
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Rounding zoomToUserLocationButton and all the views:
        
        zoomToUserLocationButton.layer.masksToBounds = false
        
        zoomToUserLocationButton.layer.cornerRadius = zoomToUserLocationButton.frame.height / 2
        
        eventLocationConfirmationContainerView.layer.cornerRadius = 15
        
        eventLocationConfirmationContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addShadowAndRoundCorners(currentView: eventLocationConfirmationView)
        
        eventLocationDraggingNotification.layer.masksToBounds = true
        
        eventLocationDraggingNotification.layer.cornerRadius = 2
        
        eventLocationConfirmationButton.layer.masksToBounds = false
        
        eventLocationConfirmationButton.layer.cornerRadius = 5
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        // Add Rounded Corners and Borders to the profile button.
        
        profileButton.clipsToBounds = true
        
        profileButton.layer.cornerRadius = profileButton.frame.size.width / 2
        
        profileButton.layer.borderColor = UIColorFromHex(rgbValue: 0xFFE6C8).cgColor
        
        profileButton.layer.borderWidth = 2
        
        // Add shadows and round event views inside the stack view:
        
        for eventView in myEventsMenuStackView.subviews {
            
            if (!(eventView is UILabel)) {
                
                eventView.layer.masksToBounds = false
                
                eventView.layer.cornerRadius = 8
                
                eventView.layer.shadowColor = UIColor.black.cgColor
                
                eventView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                
                eventView.layer.shadowOpacity = 0.5
                
                eventView.layer.shadowRadius = 3
                
            }
            
        }
        
        if (!initialMenuConstraintHasBeenLoaded) {
            
            menuLeadingConstraint.constant = 0 - menuView.frame.size.width
            
            initialMenuConstraintHasBeenLoaded = true
            
        }
        
    }
    
    // SLIDE OUT MENU HIDE WHEN TAP OUT
    
    @objc func hideMenuOnTap(_ recognizer: UITapGestureRecognizer) {
        
        if (menuShowing) {
            
            // toggle side menu (to fully hide it)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, animations: {
                self.menuLeadingConstraint.constant = 0 - self.menuView.frame.size.width;
                self.view.layoutIfNeeded()
            })
            
            menuShowing = !menuShowing
            
        }
        
    }

    // SLIDE OUT MENU HANDLING METHOD.
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        
        if (!menuView.isHidden) {
            
             // how much distance have user finger moved since touch start (in X and Y)
        
            let translation = recognizer.translation(in: self.view)
    
            // for demonstration purpose below, you can ignore this line
            print("panned x: \(translation.x), y: \(translation.y)")

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
            if(!menuShowing && translation.x > 0.0 && translation.x <= menuView.frame.size.width) {
                  // move the side menu to the right
                menuLeadingConstraint.constant = 0 - menuView.frame.size.width + translation.x
              }
              // if the side menu is visible
              // and user finger move to left
              // and the distance moved is smaller than the side menu's width
            if(menuShowing && translation.x < 0.0 && translation.x >= 0 - menuView.frame.size.width) {
                // move the side menu to the left
                menuLeadingConstraint.constant = translation.x
              }
            
        }
        
    }
    
    // Button open Menu Action.
    
    @IBAction func openMenuFromButton(_ sender: Any) {
        
        if(!menuShowing) {
            
            menuLeadingConstraint.constant = 0;
        } else {
            
            menuLeadingConstraint.constant = 0 - menuView.frame.size.width;
            
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations:
        {
            
            self.view.layoutIfNeeded()
            
        })
        
        menuShowing = !menuShowing;
        
    }
    
    // Filters popsicles depending on the option selected:
    
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
    
    // Adds shadows and round corners to views.
    
    private func addShadowAndRoundCorners (currentView: UIView) {
    
        currentView.layer.masksToBounds = false
        
        currentView.layer.cornerRadius = 15.0
        
        currentView.layer.shadowColor = UIColor.black.cgColor
        
        currentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        currentView.layer.shadowOpacity = 0.3
        
        currentView.layer.shadowRadius = 2
    
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    // Prepare for segue:
    
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
    
    // Shows buttons once the create event view close button is pressed:
    
    func showMainButtons() {
        
        menuView.isHidden = false
        
        menuButton.isHidden = false
        
        newEventButton.isHidden = false
        
    }
    
    // Performs respective actions when CONFIRM button is pressed:
    
    @IBAction func confirmLocation(_ sender: Any) {
        
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
        
        mapPopsicles?.append(popsicleToAdd)
        
        addNewPopsicleToMap()
        
        showMainButtons()
        
        addEventToMenu(eventName: newPopsicle.popsicleData.eventName)
        
    }
    
    // Adds a new event button to the menu event view:
    
    private func addEventToMenu (eventName: String) {
        
        if (!noEventsLabel.isHidden) {
            
            noEventsLabel.isHidden = true
            
            let newEventView = UIButton(type: .system)
            
            newEventView.setTitle(eventName, for: .normal)
            
            newEventView.titleLabel?.font = UIFont(name: "Octarine-Bold", size: 17)
            
            newEventView.tintColor = .white
            
            //newEventView.titleLabel?.adjustsFontSizeToFitWidth = true
            
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
    
    // Adds a new pin to the map corresponding to the new element added to the mapPopsicles List:
    
    private func addNewPopsicleToMap() {
        
        if (mapPopsicles?.last != nil) {
            
            mainMapView.addAnnotation((mapPopsicles?.last)!)
                    
        } else {
            
            print("\n Trying to add non-existent popsicle \n")
            
        }
        
    }
    
    // Zooms to user location when zoomToUserLocationButton is pressed:
    
    @IBAction func zoomToUserLocation(_ sender: Any) {
        
        // Creates the user region
        
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 50.0, longitudinalMeters: 50.0)
        
        // Zooms to user region
        
        mainMapView.setRegion(region, animated: true)
        
    }
    
    // Lets user select the event location by moving a pin around:
    
    private func placePinOnMap () {
        
        // Initializes the pin placement view.
        
        placingPin = true
        
        resultSearchController?.searchBar.text = ""
        
        newEventButton.isHidden = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        eventLocationPin.isHidden = false
        
        eventLocationDraggingNotification.isHidden = false
        
        eventLocationDraggingNotification.alpha = 1.0

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
        
        eventLocationConfirmationContainerView.isHidden = true
        
        zoomToUserLocationButton.isHidden = false
        
    }
    
    // Fill in userPinData with inputData from createEventViewController:
    
    func setUserPinData(en: String, ei: String, ed: String, edu: String, ec: String, ecd: String, es1: String, es1d: String, es2: String, es2d: String) {
        
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
        
        /*print(userPinData.eventName + " " + userPinData.eventInfo + " " + userPinData.eventDate + " " + userPinData.eventCategory + " " + userPinData.eventCategoryDetails + " " + userPinData.eventSubcategory1 + " " + userPinData.eventSubcategory1Details + " " + userPinData.eventSubcategory2 + " " + userPinData.eventSubcategory2Details)*/
        
        // We call placePinOnMap:
        
        placePinOnMap()
        
    }
    
    // Set the shouldAutorotate to False
    override open var shouldAutorotate: Bool {
        
        return false
        
    }
       
    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
           return .portrait
        
    }
       
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            userLocation = location
            
        }

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
}

extension mainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        if (placingPin) {
            
            UIView.transition(with: eventLocationDraggingNotification, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                
                self.eventLocationDraggingNotification.alpha = 0.0
                
            }, completion: { (true) in
                
                self.eventLocationDraggingNotification.isHidden = true
                
            })
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if (placingPin) {
        
            centerCoordinate = mapView.centerCoordinate
        
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
                
                    print("\nError when trying to retrieve address from center location.\n")
                
                }
            
            }
        
        }
            
    }
    
    func parseAddress(selectedItem:CLPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
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
        return addressLine
    }
    
    func lookUpSpecifiedLocation(location:CLLocation, completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
       
        let geocoder = CLGeocoder()
                
        // Look up the location and pass it to the completion handler
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // ADD USER ANNOTATION VIEW
        
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
            
        // ADD POPSICLES PINS
        
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
    
}

extension mainViewController: HandleMapSearch {
    
    func dropPinZoomIn (placemark: MKPlacemark) {
        
        // Changes the search bar text to the option selected.
        
        resultSearchController!.searchBar.text = placemark.name
        
        // cache the pin
        
        var region = MKCoordinateRegion()
        
        region.center.latitude = placemark.coordinate.latitude
        
        region.center.longitude = placemark.coordinate.longitude
        
        region.span.latitudeDelta = 0
        
        region.span.longitudeDelta = 0

        mainMapView.setRegion(region, animated: true)
        
    }
    
}

extension UILabel {
    
    func underline() {
           if let textString = text {
                let attributedString = NSMutableAttributedString(string: textString)
       attributedString.addAttribute(   NSAttributedString.Key.underlineStyle,
                 value: NSUnderlineStyle.single.rawValue,
    range: NSRange(location: 0,
    length: attributedString.length))
          attributedText = attributedString
            }
        }
    
}
