//
//  NewMainViewController.swift - Main view of the app. First stop in the view hirearchy.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 4/29/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import Network
import Kronos
import Contacts

class NewMainViewController: UIViewController {
    
    public static let defaultMainMapViewRegionRadius = 3000.0 // 3km
    public static let defaultMainMapViewCenterLocation = CLLocationCoordinate2D(latitude: 39.6766, longitude: -104.9619) // DU Campus
    
    private let mainVerticalEdgeInset: CGFloat = .getPercentageWidth(percentage: 5)
    private let mainHorizontalEdgeInset: CGFloat = .getPercentageWidth(percentage: 3)
    
    lazy private var mainUserPicture: UIImage = .defaultUserPicture64
    
    lazy private var mainMapView: MKMapView = {
        
        var mainMapView = MKMapView()
        mainMapView.addGestureRecognizer(mainMenuOutsideTapGestureRecognizer)
        mainMapView.isPitchEnabled = false
        mainMapView.isRotateEnabled = false
        mainMapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: mainMapViewRegion)
        mainMapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 0, maxCenterCoordinateDistance: NewMainViewController.defaultMainMapViewRegionRadius)
        mainMapView.setRegion(mainMapViewRegion, animated: true)
        mainMapView.delegate = self
        mainMapView.showsUserLocation = false
        return mainMapView
        
    }()
    
    lazy private var mainMenuOutsideTapGestureRecognizer: UITapGestureRecognizer = {
        
        var menuOutsideTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        return menuOutsideTapGestureRecognizer
        
    }()
    
    lazy private var mainMapViewRegion: MKCoordinateRegion = {
        
        let mainMapViewRegionCenter = mainUserLocation
        let mainMapViewRegionRadius = NewMainViewController.defaultMainMapViewRegionRadius
        
        var mainMapViewRegion = MKCoordinateRegion(center: mainMapViewRegionCenter, latitudinalMeters: mainMapViewRegionRadius, longitudinalMeters: mainMapViewRegionRadius)
        return mainMapViewRegion
        
    }()
    
    fileprivate lazy var mainLocationManager: CLLocationManager = {
        
        var mainLocationManager = CLLocationManager()
        mainLocationManager.requestWhenInUseAuthorization()
        mainLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        mainLocationManager.distanceFilter = kCLDistanceFilterNone
        mainLocationManager.startUpdatingLocation()
        mainLocationManager.delegate = self
        return mainLocationManager
        
    }()
    
    lazy private var mainUserLocation: CLLocationCoordinate2D = NewMainViewController.defaultMainMapViewCenterLocation
    
    lazy private var mainCreateEventButton: BubbleButton = {
        
        var mainCreateEventButton = BubbleButton(bouncyButtonImage: UIImage(systemSymbol: .plus, withConfiguration: UIImage.SymbolConfiguration(pointSize: 0, weight: .bold)).withTintColor(.mainNAVYBLUE, renderingMode: .alwaysOriginal))
        mainCreateEventButton.backgroundColor = .white
        mainCreateEventButton.contentEdgeInsets = UIEdgeInsets(top: mainHorizontalEdgeInset, left: mainHorizontalEdgeInset, bottom: mainHorizontalEdgeInset, right: mainHorizontalEdgeInset)
        mainCreateEventButton.addTarget(self, action: #selector(transitionToCreateEvent), for: .touchUpInside)
        
        mainCreateEventButton.translatesAutoresizingMaskIntoConstraints = false
        mainCreateEventButton.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 17)).isActive = true
        mainCreateEventButton.heightAnchor.constraint(equalTo: mainCreateEventButton.widthAnchor).isActive = true
        
        return mainCreateEventButton
        
    }()
    
    lazy private var mainTopStackView: UIStackView = {
        
        let mainSearchBar = NewSearchBar()
        mainSearchBar.delegate = self
        
        let mainMenuButton = ImageBubbleButton(bouncyButtonImage: mainUserPicture)
        mainMenuButton.layer.borderColor = UIColor.white.cgColor
        mainMenuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        
        mainMenuButton.translatesAutoresizingMaskIntoConstraints = false
        mainMenuButton.heightAnchor.constraint(equalTo: mainMenuButton.widthAnchor).isActive = true
        
        let mainRefreshButton = NewRefreshButton()
        
        mainRefreshButton.translatesAutoresizingMaskIntoConstraints = false
        mainRefreshButton.heightAnchor.constraint(equalTo: mainRefreshButton.widthAnchor).isActive = true
        
        var mainTopStackView = UIStackView(arrangedSubviews: [mainMenuButton, mainSearchBar, mainRefreshButton])
        mainTopStackView.axis = .horizontal
        mainTopStackView.alignment = .fill
        mainTopStackView.distribution = .fill
        mainTopStackView.spacing = mainHorizontalEdgeInset
        
        mainTopStackView.translatesAutoresizingMaskIntoConstraints = false
        mainTopStackView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 90)).isActive = true
        mainTopStackView.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 11)).isActive = true
        
        return mainTopStackView
        
    }()
    
    lazy private var mainMapFiltersView: NewMapFiltersView = {
        
        var mainMapFiltersStackView = NewMapFiltersView()
        
        for view in mainMapFiltersStackView.mapFiltersStackView.arrangedSubviews {
            
            if let filterButton = view as? PopsicleBubbleButton {
                
                filterButton.addTarget(self, action: #selector(filterPopsicles), for: .touchUpInside)
                
            } else if let showHideFiltersButton = view as? BubbleButton {
                
                showHideFiltersButton.addTarget(self, action: #selector(toggleMainMapDarkLayerView), for: .touchUpInside)
                
            }
            
        }
        
        return mainMapFiltersStackView
        
    }()
    
    lazy private var mainMapDarkLayerView: NewDarkLayerView = {
    
        var mainMapDarkLayerView = NewDarkLayerView()
        
        let darkLayerViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleFilters))
        let darkLayerViewSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(toggleFilters))
        mainMapDarkLayerView.addGestureRecognizer(darkLayerViewTapRecognizer)
        mainMapDarkLayerView.addGestureRecognizer(darkLayerViewSwipeRecognizer)
        mainMapDarkLayerView.isUserInteractionEnabled = true
        
        mainMapDarkLayerView.toggleDarkLayerView()
        
        return mainMapDarkLayerView
    
    }()
    
    @objc func toggleMainMapDarkLayerView() {
        
        mainMapDarkLayerView.toggleDarkLayerView()
        
    }
    
    @objc func toggleFilters() {
        
        toggleMainMapDarkLayerView()
        mainMapFiltersView.toggleFilters()
        
    }
    
    @objc func filterPopsicles() {
        
        if mainMapDarkLayerView.isVisible {
            
            toggleMainMapDarkLayerView()
            
        }
        
    }
    
    @objc func transitionToCreateEvent() {
        
        if mainMapDarkLayerView.isVisible {
            
            toggleFilters()
            
        }
        
        // For trial purposes, present the new create event view controller modally
        // later, need to change to using navigation controller
        //self.modalPresentationStyle = .overFullScreen
        self.present(NewCreateEventViewController(), animated: true, completion: nil)
        
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        
        
        
    }
    
    @objc func openMenu() {
        
        
        
    }
    
    @objc func zoomToUserLocation(_ sender: UIButton) {
        
        let region = MKCoordinateRegion(center: mainUserLocation, latitudinalMeters: 50.0, longitudinalMeters: 50.0)
        
        MKMapView.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.mainMapView.setRegion(region, animated: true)
            
        }, completion: nil)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .menuCREAM
        
        view.addSubview(mainMapView)
        mainMapView.translatesAutoresizingMaskIntoConstraints = false
        mainMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(mainMapDarkLayerView)
        mainMapDarkLayerView.translatesAutoresizingMaskIntoConstraints = false
        mainMapDarkLayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainMapDarkLayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainMapDarkLayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainMapDarkLayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(mainCreateEventButton)
        mainCreateEventButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -mainVerticalEdgeInset).isActive = true
        mainCreateEventButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(mainTopStackView)
        mainTopStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: mainVerticalEdgeInset).isActive = true
        mainTopStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(mainMapFiltersView)
        mainMapFiltersView.translatesAutoresizingMaskIntoConstraints = false
        mainMapFiltersView.trailingAnchor.constraint(equalTo: mainTopStackView.trailingAnchor).isActive = true
        mainMapFiltersView.topAnchor.constraint(equalTo: mainTopStackView.bottomAnchor, constant: mainHorizontalEdgeInset).isActive = true
        
    }
    
}

extension NewMainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            
            manager.requestLocation()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            mainUserLocation = location.coordinate
            
            if !mainMapView.visibleMapRect.contains(MKMapPoint(mainUserLocation)) {
                
                mainMapViewRegion.center = mainUserLocation
                mainMapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: mainMapViewRegion)
                
            }
            
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if let error = error as? CLError, error.code == .denied {
            
            print("ERROR: LocationManager failed to get user's location.")
            
        }
        
    }
    
}

extension NewMainViewController: MKMapViewDelegate {
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        
        if !mainMapView.showsUserLocation {
        
            mainMapView.showsUserLocation = true
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
       /*
        if placingPin {
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.eventLocationDraggingNotification.alpha = 0.0
                self.view.layoutIfNeeded()
                
            }, completion: nil)
            
        }
        */
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
      /*
        if placingPin {
            
            let centerCoordinate = mapView.centerCoordinate
            
            let centerLocation = CLLocation(latitude: centerCoordinate.latitude - 0.0001, longitude: centerCoordinate.longitude)
            
            lookUpAddress(from: centerLocation) { (address) in
                
                if (address != nil) {
                    
                    self.eventLocationConfirmationAddress.text = address
                    
                    if (!self.confirmationViewIsVisible) {
                        
                        self.eventLocationConfirmationContainerView.transform = CGAffineTransform(translationX: 0, y: +self.eventLocationConfirmationContainerView.frame.height)
                        self.eventLocationConfirmationContainerView.alpha = 1.0
                        self.view.layoutIfNeeded()
                        
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                            
                            self.eventLocationConfirmationContainerView.transform = .identity
                            self.view.layoutIfNeeded()
                            
                        }, completion: nil)
                        
                        self.confirmationViewIsVisible = true
                        
                    }
                    
                } else {
                    
                    print("Error: mainMapView was unable to retrieve the address from the current center location.")
                    
                }
                
            }
            
        }*/
        
    }
    
    private func lookUpAddress(from location: CLLocation, completionHandler: @escaping (String?) -> Void ) {
        
        let geocoder = CLGeocoder()
        let postalAddressFormatter = CNPostalAddressFormatter()
        postalAddressFormatter.style = .mailingAddress
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            
            if error == nil, let addressLocation = placemarks?[0], let address = addressLocation.postalAddress {
                
                completionHandler(postalAddressFormatter.string(from: address))
                
            } else {
                
                print("ERROR: CLGeocoder was unable to retrieve a location.")
                completionHandler(nil)
                
            }
            
        })
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            
            var userLocationAnnotationView = mainMapView.dequeueReusableAnnotationView(withIdentifier: NewUserLocationAnnotationView.defaultUserLocationAnnotationViewReuseIdentifier)
            
            if userLocationAnnotationView == nil {
                
                userLocationAnnotationView = NewUserLocationAnnotationView(annotation: annotation, reuseIdentifier: NewUserLocationAnnotationView.defaultUserLocationAnnotationViewReuseIdentifier)
                
            }
            
            (userLocationAnnotationView as! NewUserLocationAnnotationView).setUserLocationIcon(icon: nil)
            
            return userLocationAnnotationView
            
        } else if annotation is NewPopsicleAnnotation {
            
            var popsicleAnnotationView = mainMapView.dequeueReusableAnnotationView(withIdentifier: NewPopsicleAnnotationView.defaultPopsicleAnnotationViewReuseIdentifier)
            
            if popsicleAnnotationView == nil {
                
                popsicleAnnotationView = NewPopsicleAnnotationView(annotation: annotation, reuseIdentifier: NewPopsicleAnnotationView.defaultPopsicleAnnotationViewReuseIdentifier)
                
            }
            
            return popsicleAnnotationView
            
        } else if annotation is MKClusterAnnotation {
            
            var popsicleGroupAnnotationView = mainMapView.dequeueReusableAnnotationView(withIdentifier: NewPopsicleGroupAnnotationView.defaultPopsicleGroupAnnotationViewReuseIdentifier)
            
            if popsicleGroupAnnotationView == nil {
                
                popsicleGroupAnnotationView = NewPopsicleGroupAnnotationView(annotation: annotation, reuseIdentifier: NewPopsicleGroupAnnotationView.defaultPopsicleGroupAnnotationViewReuseIdentifier)
                
            }
            
            (popsicleGroupAnnotationView as! NewPopsicleGroupAnnotationView).setGroupCount(count: (annotation as! MKClusterAnnotation).memberAnnotations.count)
            
            return popsicleGroupAnnotationView
            
        }
        
        return nil
        
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        for annotationView in views {
            
            if annotationView is NewPopsicleAnnotationView, let annotationCoordinates = annotationView.annotation?.coordinate, mapView.visibleMapRect.contains(MKMapPoint(annotationCoordinates)) {
                
                let endFrame:CGRect = annotationView.frame
                
                annotationView.frame = CGRect(origin: CGPoint(x: annotationView.frame.origin.x, y: annotationView.frame.origin.y - self.view.frame.size.height), size: CGSize(width: annotationView.frame.size.width, height: annotationView.frame.size.height))
                
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations:{() in
                    
                    annotationView.frame = endFrame
                    
                    self.view.layoutIfNeeded()
                    
                }, completion: nil)
                
            } else if annotationView is NewPopsicleGroupAnnotationView || annotationView is NewUserLocationAnnotationView, let annotationCoordinates = annotationView.annotation?.coordinate, mapView.visibleMapRect.contains(MKMapPoint(annotationCoordinates)) {
                
                annotationView.alpha = 0
                annotationView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                               options: .curveEaseOut, animations: {
                                
                                annotationView.transform = .identity
                                annotationView.alpha = 1
                                
                }, completion: nil)
                
            }
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let selectedPopsicle = view.annotation, selectedPopsicle is NewPopsicleAnnotation {
            
            print("Popsicle selected.")
            
        } else if let selectedPopsicle = view.annotation, selectedPopsicle is MKUserLocation {
            
            print("User location selected.")
            
        }
        
        mainMapView.deselectAnnotation(view.annotation, animated: false)
        
    }
    
}

extension NewMainViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        if mainMapDarkLayerView.isVisible {
            
            toggleFilters()
            
        }
        
        let searchVC = NewSearchViewController()
        searchVC.transitioningDelegate = self
        self.present(searchVC, animated: true, completion: nil)
        
        return false
        
    }
    
}

extension NewMainViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ViewControllerFadeTransitionAnimator(presenting: true)
        
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ViewControllerFadeTransitionAnimator(presenting: false)
        
    }
}

