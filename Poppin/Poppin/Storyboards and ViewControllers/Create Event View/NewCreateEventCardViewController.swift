//
//  NewCreateEventCardViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 6/6/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import GeoFire

class NewCreateEventCardViewController : UIViewController, UITextFieldDelegate, UITextViewDelegate, MKMapViewDelegate {
    
    var storage: Storage?
    
    let uid = Auth.auth().currentUser!.uid
    
    var startDateFormatted: String?
    
    var endDateFormatted: String?
    
    var hashtagTyped: Bool?
    
    var hashtagCount: Int?
    
    var address: String?
    
    var location: CLLocationCoordinate2D?
    
    var popsicleImage: UIImage?
    
    var category: String?
    
    var backgroundGradientColors: [CGColor]?
    
    lazy private var cCard: UIView = {
        
        var v = UIView()
        v.backgroundColor = .white
        
        v.layer.masksToBounds = false
        v.layer.cornerRadius = 16
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = 2
        
        var pImage = UIImageView()
        var label = UITextView()
        label.font = UIFont(name: "Octarine-Bold", size: 18)
        label.textColor = .mainDARKPURPLE
        label.textAlignment = .center
        
        switch (backgroundGradientColors![1])   {
        case UIColor.purple.cgColor:
            pImage.image = UIImage(named: "showsButton")
            label.text = "Shows"
        case UIColor.red.cgColor:
            pImage.image = UIImage(named: "educationButton")
            label.text = "Education"
        case UIColor.orange.cgColor:
            pImage.image = UIImage(named: "foodButton")
            label.text = "Food"
        case UIColor.yellow.cgColor:
            pImage.image = UIImage(named: "socialButton")
            label.text = "Social"
        case UIColor.green.cgColor:
            pImage.image = UIImage(named: "sportsButton")
            label.text = "Sports"
        default:
            break
        }
        
        v.addSubview(pImage)
        pImage.translatesAutoresizingMaskIntoConstraints = false
        pImage.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 14)).isActive = true
        pImage.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 6.5)).isActive = true
        pImage.topAnchor.constraint(equalTo: v.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 1.5)).isActive = true
        pImage.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        
        v.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 28)).isActive = true
        label.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 3)).isActive = true
        label.topAnchor.constraint(equalTo: v.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 7.5)).isActive = true
        label.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        
        return v
        
    }()
    
    lazy private var nameCard: UITextField = {
        
        var t = UITextField()
        t.backgroundColor = .white
        let sideIcon = UIImageView(image: UIImage(systemSymbol: .squareAndPencil).withTintColor(.mainDARKPURPLE).imageWithInsets(insets: UIEdgeInsets(top: .getPercentageWidth(percentage: 1.5), left: .getPercentageWidth(percentage: 1.5), bottom: .getPercentageWidth(percentage: 1.5), right: .getPercentageWidth(percentage: 1.5))))
        sideIcon.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        sideIcon.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        t.leftView = sideIcon
        t.leftViewMode = .always
        
        t.layer.masksToBounds = false
        t.layer.cornerRadius = 16
        t.layer.shadowColor = UIColor.black.cgColor
        t.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        t.layer.shadowOpacity = 0.3
        t.layer.shadowRadius = 2
        
        t.font = UIFont(name: "Octarine", size: 20)
        t.textColor = .mainDARKPURPLE
        t.placeholder = "Name"
        
        t.autocorrectionType = .no
        t.keyboardType = .default
        t.returnKeyType = .done
        t.clearButtonMode = .whileEditing
        t.contentVerticalAlignment = .center
        t.delegate = self
        
        t.addTarget(self, action: #selector(nameChanged), for: .valueChanged)
        
        return t
        
    }()
    
    @objc func nameChanged() {
        self.name = nameCard.text!
        print(name)
    }
    
    lazy private var dateCard: UIView = {
        
        var t = UIView()
        t.backgroundColor = .white
        
        let sideIcon = UIImageView(image: UIImage(systemSymbol: .calendar))
        sideIcon.tintColor = .mainDARKPURPLE
        
        t.addSubview(sideIcon)
        sideIcon.translatesAutoresizingMaskIntoConstraints = false
        sideIcon.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 6.5)).isActive = true
        sideIcon.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 6.5)).isActive = true
        sideIcon.leadingAnchor.constraint(equalTo: t.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 1.75)).isActive = true
        sideIcon.centerYAnchor.constraint(equalTo: t.centerYAnchor).isActive = true
        
        t.layer.masksToBounds = false
        t.layer.cornerRadius = 16
        t.layer.shadowColor = UIColor.black.cgColor
        t.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        t.layer.shadowOpacity = 0.3
        t.layer.shadowRadius = 2
        
        return t
        
    }()
    
    lazy private var datePicker: UIDatePicker = {
        
        var d = UIDatePicker()
        
        d.minimumDate = Date()
        d.maximumDate = Date(timeInterval: 86340, since: d.minimumDate!)
        print(backgroundGradientColors!.count)
        d.setValue(UIColor(cgColor: backgroundGradientColors![1]), forKeyPath: "textColor")
        d.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        return d
        
    }()
    
    lazy var mainMapView: MKMapView = {
        
        var mainMapView = MKMapView()
        //mainMapView.addGestureRecognizer(mainMenuOutsideTapGestureRecognizer)
        mainMapView.isPitchEnabled = false
        mainMapView.isRotateEnabled = false
        mainMapView.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: mainMapViewRegion)
        mainMapView.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 0, maxCenterCoordinateDistance: NewMainViewController.defaultMainMapViewRegionRadius)
        mainMapView.setRegion(mainMapViewRegion, animated: true)
        mainMapView.delegate = self
        mainMapView.showsUserLocation = false
        //mainMapView.addShadowAndRoundCorners(cornerRadius: 20)
        var maskedCorners = CACornerMask()
        mainMapView.layer.cornerRadius = 20 - backgroundView.bounds.width * 0.015
        maskedCorners.insert(.layerMaxXMaxYCorner)
        maskedCorners.insert(.layerMinXMaxYCorner)
        mainMapView.layer.maskedCorners = maskedCorners
        return mainMapView
        
    }()
    
    lazy private var purpleMapView: UIView = {
       let purpleMapView = UIView()
        purpleMapView.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        purpleMapView.layer.cornerRadius = 20
        return purpleMapView
    }()
    
    lazy var locationLabel: UILabel = {
       let locationLabel = UILabel()
        locationLabel.textAlignment = .center
        locationLabel.backgroundColor = .clear
        locationLabel.textColor = .white
        //locationLabel.text = "Location"
        locationLabel.font = UIFont.dynamicFont(with: "Octarine-Bold", style: .subheadline)
        return locationLabel
    }()
    
    lazy var editLocationButton: BouncyButton = {
        let editLocationButton = BouncyButton(bouncyButtonImage: nil)
        editLocationButton.setTitle("Edit", for: .normal)
        editLocationButton.titleLabel?.font = UIFont.dynamicFont(with: "Octarine-Bold", style: .subheadline)
        editLocationButton.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        editLocationButton.setTitleColor(.white, for: .normal)
        editLocationButton.titleLabel?.textAlignment = .center
        //editLocationButton.addShadowAndRoundCorners(cornerRadius: 15, topRightMask: false, topLeftMask: false)
        editLocationButton.layer.cornerRadius = 15
        var maskedCorners = CACornerMask()

         maskedCorners.insert(.layerMaxXMaxYCorner)
         maskedCorners.insert(.layerMinXMaxYCorner)
         editLocationButton.layer.maskedCorners = maskedCorners 
        
        editLocationButton.addTarget(self, action: #selector(editLocation), for: .touchUpInside)
        editLocationButton.isUserInteractionEnabled = true
       return editLocationButton
    }()
    
     lazy private var mainUserLocation: CLLocationCoordinate2D = NewMainViewController.defaultMainMapViewCenterLocation
    
    lazy private var mainMapViewRegion: MKCoordinateRegion = {
        
        let mainMapViewRegionCenter = mainUserLocation
        let mainMapViewRegionRadius = NewMainViewController.defaultMainMapViewRegionRadius
        
        var mainMapViewRegion = MKCoordinateRegion(center: mainMapViewRegionCenter, latitudinalMeters: mainMapViewRegionRadius, longitudinalMeters: mainMapViewRegionRadius)
        return mainMapViewRegion
        
    }()
    
    lazy var startDateTextField: UITextField = {
       let startDateTextField = UITextField()
        startDateTextField.delegate = self
        
        let dateToolbar = UIToolbar()
        
        dateToolbar.sizeToFit()
                
        let dateDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneStartActionDate))
        
        let dateFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        dateToolbar.setItems([dateFlexSpace,dateDoneButton], animated: true)
        
        startDateTextField.inputAccessoryView = dateToolbar
        startDateTextField.font = UIFont.dynamicFont(with: "Octarine-LightOblique", style: .subheadline)
        startDateTextField.backgroundColor = .clear
        startDateTextField.textColor = .white
        
        startDateTextField.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        startDateTextField.inputView = datePicker
        startDateTextField.attributedPlaceholder = NSAttributedString(string: "Start Date", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-LightOblique", style: .title3), NSAttributedString.Key.foregroundColor : UIColor.white])
        return startDateTextField
    }()
    
    lazy var endDateTextField: UITextField = {
       let endDateTextField = UITextField()
        endDateTextField.delegate = self
        
        let dateToolbar = UIToolbar()
        
        dateToolbar.sizeToFit()
        
        let dateDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEndActionDate))
        
        let dateFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        dateToolbar.setItems([dateFlexSpace,dateDoneButton], animated: true)
        
        endDateTextField.inputAccessoryView = dateToolbar
        endDateTextField.font = UIFont.dynamicFont(with: "Octarine-LightOblique", style: .subheadline)
        endDateTextField.backgroundColor = .clear
        endDateTextField.textColor = .white
        endDateTextField.textAlignment = .right
        
        endDateTextField.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        endDateTextField.inputView = datePicker
        endDateTextField.attributedPlaceholder = NSAttributedString(string: "End Date", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-LightOblique", style: .title3), NSAttributedString.Key.foregroundColor : UIColor.white])
        return endDateTextField
    }()
    
    lazy var purplePopsicle: UIImageView = {
       let purplePopsicle = UIImageView()
       purplePopsicle.image = UIImage.culturePopsicleIcon256.withTintColor(UIColor(cgColor: backgroundGradientColors![1]))
        purplePopsicle.contentMode = .scaleAspectFit
       return purplePopsicle
    }()
    
    lazy var purpleLineOne: UIView = {
       let purpleLineOne = UIView()
        purpleLineOne.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        return purpleLineOne
    }()
    
    lazy var purpleLineTwo: UIView = {
       let purpleLineTwo = UIView()
        purpleLineTwo.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        return purpleLineTwo
    }()
    
    @objc func dateChanged() {
        self.date = datePicker.date
        print(date)
    }
    
    lazy private var durationCard: UIView = {
        
        var t = UIView()
        t.backgroundColor = .white
        
        let sideIcon = UIImageView(image: UIImage(systemSymbol: .timer))
        sideIcon.tintColor = .mainDARKPURPLE
        
        t.addSubview(sideIcon)
        sideIcon.translatesAutoresizingMaskIntoConstraints = false
        sideIcon.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 6.5)).isActive = true
        sideIcon.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 6.5)).isActive = true
        sideIcon.leadingAnchor.constraint(equalTo: t.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 1.75)).isActive = true
        sideIcon.centerYAnchor.constraint(equalTo: t.centerYAnchor).isActive = true
        
        t.layer.masksToBounds = false
        t.layer.cornerRadius = 16
        t.layer.shadowColor = UIColor.black.cgColor
        t.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        t.layer.shadowOpacity = 0.3
        t.layer.shadowRadius = 2
        
        return t
        
    }()
    
    lazy private var durPicker: UIDatePicker = {
        
        var d = UIDatePicker()
        d.datePickerMode = .countDownTimer
        d.minuteInterval = 5
        d.setValue(UIColor.mainDARKPURPLE, forKeyPath: "textColor")
        
        d.addTarget(self, action: #selector(durChanged), for: .valueChanged)
        
        return d
        
    }()
    
    @objc func durChanged() {
        
        if(durPicker.countDownDuration > 18000) {
            durPicker.countDownDuration = 18000
        }
        
        self.duration = durPicker.countDownDuration
        print(duration)
    }
    
    lazy private var infoCard: UITextField = {
        
        var t = UITextField()
        t.backgroundColor = .white
        
        let sideIcon = UIImageView(image: UIImage(systemSymbol: .textBubble).withTintColor(.mainDARKPURPLE).imageWithInsets(insets: UIEdgeInsets(top: .getPercentageWidth(percentage: 1.5), left: .getPercentageWidth(percentage: 1.5), bottom: .getPercentageWidth(percentage: 1.5), right: .getPercentageWidth(percentage: 1.5))))
        sideIcon.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        sideIcon.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
        t.leftView = sideIcon
        t.leftViewMode = .always
        
        t.layer.masksToBounds = false
        t.layer.cornerRadius = 16
        t.layer.shadowColor = UIColor.black.cgColor
        t.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        t.layer.shadowOpacity = 0.3
        t.layer.shadowRadius = 2
        
        t.font = UIFont(name: "Octarine", size: 20)
        t.textColor = .mainDARKPURPLE
        t.placeholder = "More info"
        
        t.autocorrectionType = .no
        t.keyboardType = .default
        t.returnKeyType = .done
        t.clearButtonMode = .whileEditing
        t.contentVerticalAlignment = .center
        t.delegate = self
        
        t.addTarget(self, action: #selector(infoChanged), for: .valueChanged)
        
        return t
        
    }()
    
    @objc func infoChanged() {
        self.info = infoCard.text!
        print(info)
    }
    
    lazy var eventNameTextField: UITextView = {
        let eventNameTextField = UITextView()
        eventNameTextField.backgroundColor = .clear
        eventNameTextField.textColor = .white
        eventNameTextField.font = .dynamicFont(with: "Octarine-Bold", style: .title1)
        //eventNameTextField.text = "Add Title"

        //eventNameTextField.attributedPlaceholder = NSAttributedString(string: "Add Title", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Bold", style: .title1), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        eventNameTextField.delegate = self
        eventNameTextField.textAlignment = .center
        //eventNameTextField.lineBreakMode = NSLineBreakMode.byWordWrapping
        //eventNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: eventNameTextField.intrinsicContentSize.height))
        //eventNameTextField.leftViewMode = .always
        //eventNameTextField.clearButtonMode = .whileEditing
        //eventNameTextField.returnKeyType = .next
        eventNameTextField.autocapitalizationType = .none
        eventNameTextField.autocorrectionType = .no
        //eventNameTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        return eventNameTextField
    }()
    
    lazy private var cancelButton: BubbleButton = {
        
        var cb = BubbleButton(bouncyButtonImage: UIImage(systemSymbol: .multiply, withConfiguration: UIImage.SymbolConfiguration(pointSize: 0, weight: .medium)).withTintColor(.white, renderingMode: .alwaysOriginal))
        
        cb.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        cb.contentEdgeInsets = UIEdgeInsets(top: .getPercentageWidth(percentage: 2), left: .getPercentageWidth(percentage: 2), bottom: .getPercentageWidth(percentage: 2), right: .getPercentageWidth(percentage: 2))
        
        cb.addTarget(self, action: #selector(dismissCreateCard), for: .touchUpInside)
        
        return cb
        
    }()
    
    @objc func dismissCreateCard() {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy private var createButton: BouncyButton = {
        
        var cb = BouncyButton(bouncyButtonImage: nil)
        cb.backgroundColor = .white
        cb.setTitle("Create", for: .normal)
        cb.titleLabel?.textAlignment = .center
        cb.setTitleColor(UIColor(cgColor: backgroundGradientColors![1]), for: .normal)
        cb.titleLabel?.font = UIFont(name: "Octarine-Bold", size: 18)
        cb.contentEdgeInsets = UIEdgeInsets(top: .getPercentageWidth(percentage: 2), left: .getPercentageWidth(percentage: 2), bottom: .getPercentageWidth(percentage: 2), right: .getPercentageWidth(percentage: 2))
        
        cb.addShadowAndRoundCorners(cornerRadius: 16)
        
        cb.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
        
        return cb
        
    }()
    
    lazy var backButton: ImageBubbleButton = {
           let purpleArrow = UIImage(systemName: "arrow.left")!.withTintColor(.white)
           let backButton = ImageBubbleButton(bouncyButtonImage: purpleArrow)
           backButton.contentMode = .scaleToFill
          // backButton.setTitle("Back", for: .normal)
           //backButton.setTitleColor(.newPurple, for: .normal)
           backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
           return backButton
       }()
    

    
//    lazy var whiteView: UIScrollView = {
//        let whiteView = UIScrollView()
//        whiteView.backgroundColor = .clear
//        //whiteView.addShadowAndRoundCorners(cornerRadius: 30)
//        //whiteView.contentSize = CGSize(width: backgroundView.bounds.width * 0.9, height: backgroundView.bounds.height * 1.5)
//        return whiteView
//    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.addShadowAndRoundCorners(cornerRadius: 30 - backgroundView.bounds.width * 0.05)
        whiteView.isUserInteractionEnabled = true
        //whiteView.contentSize = CGSize(width: backgroundView.bounds.width * 0.9, height: backgroundView.bounds.height * 1.5)
        return whiteView
    }()
    
    lazy var purpleView: UIView = {
        let purpleView = UIView()
        purpleView.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        //purpleView.addShadowAndRoundCorners(cornerRadius: 20)
        purpleView.layer.cornerRadius = 20
        purpleView.isUserInteractionEnabled = true
        //whiteView.contentSize = CGSize(width: backgroundView.bounds.width * 0.9, height: backgroundView.bounds.height * 1.5)
        return purpleView
    }()
    
    lazy var userImage: UIImageView = {
        var userImage = UIImageView()
        userImage.contentMode = .scaleToFill
        userImage.frame = CGRect(x: 0, y: 0, width: purpleView.bounds.height * 0.7, height:  purpleView.bounds.height * 0.7)
        userImage.widthAnchor.constraint(equalToConstant: purpleView.bounds.height * 0.7).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: purpleView.bounds.height * 0.7).isActive = true
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.bounds.height/2
        userImage.isUserInteractionEnabled = true
        
        storage = Storage.storage()
        let uid = Auth.auth().currentUser!.uid

        
        let reference = (self.storage?.reference().child("images/\(uid)/profilepic.jpg"))!
        let placeholderImage = UIImage.defaultUserPicture256
        userImage.sd_setImage(with: reference, placeholderImage: placeholderImage)
        
        return userImage
    }()
    
    lazy var usernameLabel: UILabel = {
           let usernameLabel = UILabel()
           usernameLabel.font = .dynamicFont(with: "Octarine-Light", style: .title3)
           usernameLabel.textColor = UIColor.white
           return usernameLabel
       }()
    
    lazy var createdByLabel: UILabel = {
           let createdByLabel = UILabel()
           createdByLabel.font = .dynamicFont(with: "Octarine-Bold", style: .title3)
           createdByLabel.text = "Created by:"
           createdByLabel.textColor = UIColor.white
           return createdByLabel
       }()
    
    lazy var detailsButton: UILabel = {
        let detailsButton = UILabel()
        //detailsButton.text = "Add details..."
        //detailsButton.setTitle("Add details...", for: .normal)
        detailsButton.font = .dynamicFont(with: "Octarine-Light", style: .title3)
        //detailsButton.setTitleColor(.mainDARKPURPLE, for: .normal)
        detailsButton.textColor = .white
        //detailsButton.titleLabel?.textAlignment = .left
        //detailsButton.contentVerticalAlignment = .top
        detailsButton.textAlignment = .left
        detailsButton.numberOfLines = 5;
        detailsButton.sizeToFit()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toWriteDetails(tapGestureRecognizer:)))
        detailsButton.isUserInteractionEnabled = true
        detailsButton.addGestureRecognizer(tapGestureRecognizer)
        detailsButton.backgroundColor = .clear
        detailsButton.isUserInteractionEnabled = true
        return detailsButton
    }()
    
    
    
    lazy var gLayer : CAGradientLayer = {
        let g = CAGradientLayer()
        // g.type = .radial
        g.colors = backgroundGradientColors
        //g.locations = [ 0 , 1 ]
        // g.startPoint = CGPoint(x: 0.5, y: 0.5)
        //g.endPoint = CGPoint(x: 1.4, y: 1.15)
        g.frame = backgroundView.layer.bounds
        g.cornerRadius = 30
        return g
    }()
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 30
        backgroundView.backgroundColor = UIColor(cgColor: backgroundGradientColors![0])
        return backgroundView
    }()
    
    lazy var hashtagTextView: UITextView = {
        let hashtagTextView = UITextView()
        hashtagTextView.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        hashtagTextView.textColor = .white
        hashtagTextView.font = .dynamicFont(with: "Octarine-Bold", style: .title3)
        //hashtagTextView.text = "Add Hashtags"
        hashtagTextView.sizeToFit()
        //eventNameTextField.attributedPlaceholder = NSAttributedString(string: "Add Title", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-Bold", style: .title1), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        hashtagTextView.delegate = self
        hashtagTextView.textAlignment = .left
        hashtagTextView.layer.cornerRadius = 10
        hashtagTextView.isScrollEnabled = false

        //eventNameTextField.lineBreakMode = NSLineBreakMode.byWordWrapping
        //eventNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: eventNameTextField.intrinsicContentSize.height))
        //eventNameTextField.leftViewMode = .always
        //eventNameTextField.clearButtonMode = .whileEditing
        //eventNameTextField.returnKeyType = .next
        hashtagTextView.autocapitalizationType = .none
        hashtagTextView.autocorrectionType = .no
        //eventNameTextField.setBottomBorder(color: UIColor.mainDARKPURPLE, height: 1.0)
        return hashtagTextView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        /* FOR TRIAL PURPOSES */
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        /* FOR TRIAL PURPOSES */
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    }
    
    //private var category = -1
    private var name = ""
    private var date = Date()
    private var duration = -1.0
    private var info = ""
    
    @objc func detailsWritten(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? String else { return }
        print ("text: \(text)")
        detailsButton.text = text
    }
    
    @objc func locationSelected(_ notification: Notification) {
        guard let street = notification.userInfo?["street"] as? String else { return }
        guard let address = notification.userInfo?["address"] as? String else { return }
        guard let location = notification.userInfo?["location"] as? CLLocationCoordinate2D else { return }
        
        self.address = address
        self.location = location
        
        let allAnnotations = mainMapView.annotations
        mainMapView.removeAnnotations(allAnnotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mainMapView.setRegion(region, animated: true)
        mainMapView.addAnnotation(annotation)
        
        locationLabel.text = street
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        hashtagTyped = true
        hashtagCount = 0
        
        setPopsicleImage()
        

        //view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.detailsWritten(_:)), name: .detailsWritten, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationSelected(_:)), name: .locationSelected, object: nil)

        view.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        // gradient
        transitioningDelegate = self
        
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 90)).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 90)).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundView.frame = CGRect(x: 0, y: 0, width: .getPercentageWidth(percentage: 90), height: .getPercentageHeight(percentage: 90))
       // backgroundView.layer.insertSublayer(gLayer, at: 0)
        
//        backgroundView.addSubview(whiteCurvedView)
//        whiteCurvedView.translatesAutoresizingMaskIntoConstraints = false
//        whiteCurvedView.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.9).isActive = true
//        whiteCurvedView.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height - backgroundView.bounds.width * 0.1).isActive = true
//        whiteCurvedView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        whiteCurvedView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
//        backgroundView.addSubview(whiteView)
//        whiteView.translatesAutoresizingMaskIntoConstraints = false
//        whiteView.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.9).isActive = true
//        whiteView.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height - backgroundView.bounds.width * 0.1).isActive = true
//        whiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        whiteView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        backgroundView.addSubview(purplePopsicle)
        purplePopsicle.translatesAutoresizingMaskIntoConstraints = false
        purplePopsicle.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.05).isActive = true
        purplePopsicle.heightAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.05).isActive = true
        purplePopsicle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        purplePopsicle.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: backgroundView.bounds.height * 0.1).isActive = true
        
        backgroundView.addSubview(purpleLineOne)
        purpleLineOne.translatesAutoresizingMaskIntoConstraints = false
        purpleLineOne.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.35).isActive = true
        purpleLineOne.heightAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.005).isActive = true
        purpleLineOne.leadingAnchor.constraint(equalTo: purplePopsicle.trailingAnchor, constant: backgroundView.bounds.width * 0.01).isActive = true
        purpleLineOne.topAnchor.constraint(equalTo: purplePopsicle.centerYAnchor).isActive = true
        
        backgroundView.addSubview(purpleLineTwo)
        purpleLineTwo.translatesAutoresizingMaskIntoConstraints = false
        purpleLineTwo.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.35).isActive = true
        purpleLineTwo.heightAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.005).isActive = true
        purpleLineTwo.trailingAnchor.constraint(equalTo: purplePopsicle.leadingAnchor, constant: -backgroundView.bounds.width * 0.01).isActive = true
        purpleLineTwo.topAnchor.constraint(equalTo: purplePopsicle.centerYAnchor).isActive = true

        
        
        backgroundView.addSubview(eventNameTextField)
        eventNameTextField.translatesAutoresizingMaskIntoConstraints = false
        eventNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventNameTextField.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.8).isActive = true
        eventNameTextField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: backgroundView.bounds.height * 0.03).isActive = true
        eventNameTextField.bottomAnchor.constraint(equalTo: purplePopsicle.topAnchor, constant: backgroundView.bounds.height * 0.015).isActive = true
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 7)).isActive = true
        backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: view.bounds.height * 0.02).isActive = true
        backButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: view.bounds.height * 0.02).isActive = true
        
        backgroundView.addSubview(startDateTextField)
        startDateTextField.translatesAutoresizingMaskIntoConstraints = false
        startDateTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: backgroundView.bounds.width * 0.02).isActive = true
        startDateTextField.topAnchor.constraint(equalTo: purplePopsicle.bottomAnchor, constant: backgroundView.bounds.height * 0).isActive = true
        startDateTextField.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.43).isActive = true
        startDateTextField.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height * 0.04).isActive = true
        
        backgroundView.addSubview(endDateTextField)
        endDateTextField.translatesAutoresizingMaskIntoConstraints = false
        endDateTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -backgroundView.bounds.width * 0.02).isActive = true
        endDateTextField.topAnchor.constraint(equalTo: purplePopsicle.bottomAnchor, constant: backgroundView.bounds.height * 0).isActive = true
        endDateTextField.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.43).isActive = true
        endDateTextField.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height * 0.04).isActive = true


        backgroundView.addSubview(purpleView)
        purpleView.translatesAutoresizingMaskIntoConstraints = false
        purpleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        purpleView.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.8).isActive = true
        purpleView.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height * 0.085).isActive = true
        purpleView.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor, constant: backgroundView.bounds.height * 0.03).isActive = true
        purpleView.frame = CGRect(x: 0, y: 0, width: backgroundView.bounds.width * 0.8, height: backgroundView.bounds.height * 0.085)
        
        purpleView.addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor).isActive = true
        userImage.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -purpleView.bounds.width * 0.04).isActive = true
        
        purpleView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: purpleView.bounds.width * 0.04).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: -purpleView.bounds.height * 0.1).isActive = true
        
        purpleView.addSubview(createdByLabel)
        createdByLabel.translatesAutoresizingMaskIntoConstraints = false
        createdByLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: purpleView.bounds.width * 0.04).isActive = true
        //createdByLabel.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: purpleView.bounds.height * 0.05).isActive = true
        createdByLabel.bottomAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: -purpleView.bounds.height * 0.07).isActive = true
        
        backgroundView.addSubview(detailsButton)
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        detailsButton.topAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: backgroundView.bounds.height * 0.03).isActive = true
        detailsButton.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.8).isActive = true
        //detailsButton.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height * 0.2).isActive = true

        backgroundView.addSubview(hashtagTextView)
        hashtagTextView.translatesAutoresizingMaskIntoConstraints = false
        hashtagTextView.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor).isActive = true
        hashtagTextView.topAnchor.constraint(equalTo: detailsButton.bottomAnchor, constant: backgroundView.bounds.height * 0.03).isActive = true
        hashtagTextView.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.8).isActive = true
        //hashtagTextView.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height * 0.2).isActive = true
        //resize(textView: hashtagTextView)
        
        backgroundView.addSubview(purpleMapView)
               purpleMapView.translatesAutoresizingMaskIntoConstraints = false
               purpleMapView.topAnchor.constraint(equalTo: hashtagTextView.bottomAnchor, constant: backgroundView.bounds.height * 0.03).isActive = true
               purpleMapView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
               purpleMapView.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.8).isActive = true
               purpleMapView.heightAnchor.constraint(equalToConstant: backgroundView.bounds.height * 0.2).isActive = true

        purpleMapView.addSubview(mainMapView)
        mainMapView.translatesAutoresizingMaskIntoConstraints = false
        mainMapView.topAnchor.constraint(equalTo: purpleMapView.topAnchor, constant: backgroundView.bounds.height * 0.05).isActive = true
        mainMapView.bottomAnchor.constraint(equalTo: purpleMapView.bottomAnchor, constant: -backgroundView.bounds.width * 0.015).isActive = true
        mainMapView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        mainMapView.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.77).isActive = true
        
        purpleMapView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: purpleMapView.topAnchor).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: mainMapView.topAnchor).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.77).isActive = true
        
        backgroundView.addSubview(editLocationButton)
        editLocationButton.translatesAutoresizingMaskIntoConstraints = false
        editLocationButton.topAnchor.constraint(equalTo: purpleMapView.bottomAnchor).isActive = true
        //editLocationButton.bottomAnchor.constraint(equalTo: mainMapView.topAnchor).isActive = true
        editLocationButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        editLocationButton.widthAnchor.constraint(equalToConstant: backgroundView.bounds.width * 0.2).isActive = true

        
        // cancel button
//        backgroundView.addSubview(cancelButton)
//        cancelButton.translatesAutoresizingMaskIntoConstraints = false
//        cancelButton.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 10)).isActive = true
//        cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
//        cancelButton.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: backgroundView.bounds.height * 0.01).isActive = true
//        cancelButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: backgroundView.bounds.height * 0.01).isActive = true
        //
        //        backgroundView.addSubview(cCard)
        //        cCard.translatesAutoresizingMaskIntoConstraints = false
        //        cCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        //        cCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 12)).isActive = true
        //        cCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 15)).isActive = true
        //        cCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //
        //        backgroundView.addSubview(nameCard)
        //        nameCard.translatesAutoresizingMaskIntoConstraints = false
        //        nameCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        //        nameCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 7)).isActive = true
        //        nameCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 30)).isActive = true
        //        nameCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //
        //        backgroundView.addSubview(dateCard)
        //        dateCard.translatesAutoresizingMaskIntoConstraints = false
        //        dateCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        //        dateCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 7)).isActive = true
        //        dateCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 40)).isActive = true
        //        dateCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //
        //        dateCard.addSubview(datePicker)
        //        datePicker.translatesAutoresizingMaskIntoConstraints = false
        //        datePicker.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 60)).isActive = true
        //        datePicker.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 6)).isActive = true
        //        datePicker.leadingAnchor.constraint(equalTo: dateCard.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 13)).isActive = true
        //        datePicker.centerYAnchor.constraint(equalTo: dateCard.centerYAnchor).isActive = true
        //
        //        backgroundView.addSubview(durationCard)
        //        durationCard.translatesAutoresizingMaskIntoConstraints = false
        //        durationCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        //        durationCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 7)).isActive = true
        //        durationCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 50)).isActive = true
        //        durationCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //
        //        durationCard.addSubview(durPicker)
        //        durPicker.translatesAutoresizingMaskIntoConstraints = false
        //        durPicker.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 60)).isActive = true
        //        durPicker.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 6)).isActive = true
        //        durPicker.leadingAnchor.constraint(equalTo: durationCard.safeAreaLayoutGuide.leadingAnchor, constant: .getPercentageWidth(percentage: 13)).isActive = true
        //        durPicker.centerYAnchor.constraint(equalTo: durationCard.centerYAnchor).isActive = true
        //
        //        backgroundView.addSubview(infoCard)
        //        infoCard.translatesAutoresizingMaskIntoConstraints = false
        //        infoCard.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 80)).isActive = true
        //        infoCard.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 7)).isActive = true
        //        infoCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 60)).isActive = true
        //        infoCard.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //
        backgroundView.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 24)).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 4.5)).isActive = true
        //createButton.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 1000).isActive = true
        createButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10).isActive = true
        createButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
    }
//
//        fileprivate func resize(textView: UITextView) {
//            var newFrame = textView.frame
//            let width = newFrame.size.width
//            let newSize = textView.sizeThatFits(CGSize(width: view.bounds.width * 0.8,
//                                                       height: view.bounds.height * 0.1))
//            newFrame.size = CGSize(width: newSize.width, height: newSize.height)
//            textView.frame = newFrame
//        }
    
    @objc func goBack() {
        
        let textInfo = ["location": locationLabel.text!, "eventName": eventNameTextField.text!, "eventInfo": detailsButton.text!, "eventStartDate": startDateTextField.text!, "eventEndDate": endDateTextField.text!, "hashtags": hashtagTextView.text!, "coordinates": location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)] as [String : Any]
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .switchCategory, object: nil, userInfo: textInfo)

        
    }

    @objc func toWriteDetails(tapGestureRecognizer: UITapGestureRecognizer){
        let vc = writeDetailsViewController()
        vc.modalPresentationStyle = .overCurrentContext
        if(detailsButton.text == "Add details..."){
            vc.detailsTextField.text = ""
        }else{
            vc.detailsTextField.text = detailsButton.text
        }
        vc.purpleTab.backgroundColor = UIColor(cgColor: backgroundGradientColors![1])
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func editLocation(){
        let vc = EditLocationViewController()
        if(locationLabel.text != "Location"){
            let annotation = MKPointAnnotation()
            annotation.coordinate = location!
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            vc.mainMapView.setRegion(region, animated: true)
            vc.mainMapView.addAnnotation(annotation)
        }
        vc.modalPresentationStyle = .overCurrentContext
        //vc.modalTransitionStyle = .flipHorizontal
        vc.popsicleImage = popsicleImage
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    private func getStartDateFromPicker() {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, yyyy, h:mm a"

        startDateTextField.text = formatter.string(from: datePicker.date)
        //startDateTextField.attributedPlaceholder = NSAttributedString(string: "Start Date", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-LightOblique", style: .title3), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        startDateFormatted = formatter.string(from: datePicker.date)
        
    }
    
    private func getEndDateFromPicker() {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, yyyy, h:mm a"

        endDateTextField.text = formatter.string(from: datePicker.date)
        //startDateTextField.attributedPlaceholder = NSAttributedString(string: "Start Date", attributes: [NSAttributedString.Key.font : UIFont.dynamicFont(with: "Octarine-LightOblique", style: .title3), NSAttributedString.Key.foregroundColor : UIColor.mainDARKPURPLE])
        
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        
        endDateFormatted = formatter.string(from: datePicker.date)
        
    }
    
    @objc func doneStartActionDate() {
        
        getStartDateFromPicker()
        
        view.endEditing(true)
        
    }
    
    @objc func doneEndActionDate() {
        
        getEndDateFromPicker()
        
        view.endEditing(true)
        
    }
    
    
    //MARK: Textfield Delegate
    // When user press the return key in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        //textField.resignFirstResponder()
        return true
    }
    
    // It is called before text field become active
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = UIColor.clear
        return true
    }
    
    // It is called when text field activated
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    // It is called when text field going to inactive
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = UIColor.clear
        return true
    }
    
    // It is called when text field is inactive
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    // It is called each time user type a character by keyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under a specific number characters according to the appropriate text field
        if(textField == nameCard) {
            return updatedText.count <= 30
        } else {
            return updatedText.count <= 250
        }
    }
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if(textView == eventNameTextField){
        if  eventNameTextField.text == "Add Title" && eventNameTextField.isFirstResponder {
            eventNameTextField.text = nil
            //eventNameTextField.textColor = .white
        }
        let newPosition = eventNameTextField.endOfDocument
        eventNameTextField.selectedTextRange = eventNameTextField.textRange(from: newPosition, to: newPosition)
        }
        
        if(textView == hashtagTextView){
               if  hashtagTextView.text == "Add Hashtags" && hashtagTextView.isFirstResponder {
                   hashtagTextView.text = "#"
                   hashtagCount = 1
                   //eventNameTextField.textColor = .white
               }
               let newPosition = hashtagTextView.endOfDocument
               hashtagTextView.selectedTextRange = hashtagTextView.textRange(from: newPosition, to: newPosition)
               }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if(textView == eventNameTextField){
        if eventNameTextField.text.isEmpty || eventNameTextField.text == "" {
            eventNameTextField.textColor = .mainDARKPURPLE
            eventNameTextField.text = "Add Title"
        }
        }
        
        if(textView == hashtagTextView){
            if hashtagTextView.text.isEmpty || hashtagTextView.text == "#" {
                hashtagTextView.textColor = .white
                hashtagTextView.text = "Add Hashtags"
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        if(textView == eventNameTextField){
            if text == "\n" {
                eventNameTextField.resignFirstResponder()
                return false
            }
        let newText = (eventNameTextField.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        if(numberOfChars >= 10 && numberOfChars < 20){
            eventNameTextField.font = .dynamicFont(with: "Octarine-Bold", style: .title2)

        }
        if(numberOfChars >= 20 && numberOfChars <= 30){
            eventNameTextField.font = .dynamicFont(with: "Octarine-Bold", style: .title3)

        }
        if(numberOfChars < 10){
            eventNameTextField.font = .dynamicFont(with: "Octarine-Bold", style: .title1)

        }
            return numberOfChars <= 30

        }
        
        if(textView == hashtagTextView){
            
            let newText = (hashtagTextView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            
            let regex = try! NSRegularExpression(pattern: "\\s")
            let numberOfWhitespaceCharacters = regex.numberOfMatches(in: newText, range: NSRange(location: 0, length: newText.utf16.count))
                        
            let substring = (hashtagTextView.text as NSString).substring(with: range)

            if(hashtagTextView.text == ""){
                hashtagTyped = false
                hashtagTextView.text = "#"
            }
            
            if text == "\n" {
                hashtagTextView.resignFirstResponder()
                return false
            }
            
            if(substring == "#"){
                hashtagTextView.text.removeLast()
                //return true
            }
            
            
            if(!hashtagTyped!){
                if(text == " "){
                    return false
                }else{
                    hashtagTyped = true
                    return numberOfWhitespaceCharacters < 5 && numberOfChars < 60
                }
            }
            if(text == " " && numberOfWhitespaceCharacters < 5){
                hashtagTyped = false
                hashtagCount! += 1
                hashtagTextView.text = hashtagTextView.text + " #"
                return false
            }
            
            print(substring)
            
            return numberOfWhitespaceCharacters < 5 && numberOfChars < 60
            
        }
        
        return false
    }
    
    func setPopsicleImage(){
        if(backgroundGradientColors![0] == UIColor.cultureLIGHTPURPLE.cgColor){
            popsicleImage = .culturePopsicleIcon128
            category = "culture"
        }
        
        if(backgroundGradientColors![0] == UIColor.educationLIGHTBLUE.cgColor){
            popsicleImage = .educationPopsicleIcon128
            category = "education"
        }
        
        if(backgroundGradientColors![0] == UIColor.socialLIGHTRED.cgColor){
            popsicleImage = .socialPopsicleIcon128
            category = "social"
        }
        
        if(backgroundGradientColors![0] == UIColor.foodLIGHTORANGE.cgColor){
            popsicleImage = .foodPopsicleIcon128
            category = "food"
        }
        
        if(backgroundGradientColors![0] == UIColor.sportsLIGHTGREEN.cgColor){
            popsicleImage = .sportsPopsicleIcon128
            category = "sports"
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           let identifier = "MyPin"

           if annotation is MKUserLocation {
               return nil
           }

           var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

           if annotationView == nil {
               annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               annotationView?.canShowCallout = true
               annotationView?.image = popsicleImage

               // if you want a disclosure button, you'd might do something like:
               //
               // let detailButton = UIButton(type: .detailDisclosure)
               // annotationView?.rightCalloutAccessoryView = detailButton
           } else {
               annotationView?.annotation = annotation
           }

           return annotationView
       }
    
    @objc func createEvent() {
        let ref = Database.database().reference()

        let geoFireRef = Database.database().reference().child("Geolocs")
               
        let geoFire = GeoFire(firebaseRef: geoFireRef)
        
        let identifier = UUID()

            
        ref.child("currentPopsicles/\(identifier.uuidString)/latitude").setValue(location?.latitude)
             
            ref.child("currentPopsicles/\(identifier.uuidString)/longitude").setValue(mainMapView.centerCoordinate.longitude)
            
        geoFire.setLocation(CLLocation(latitude: mainMapView.centerCoordinate.latitude , longitude: mainMapView.centerCoordinate.longitude), forKey: (identifier.uuidString))

             
           // let en = newPopsicle.popsicleData.eventName
            
        ref.child("currentPopsicles/\(identifier.uuidString)/eventName").setValue(eventNameTextField.text)
            
        ref.child("currentPopsicles/\(identifier.uuidString)/eventInfo").setValue(detailsButton.text)
            
        ref.child("currentPopsicles/\(identifier.uuidString)/eventStartDate").setValue(startDateFormatted)
        
        ref.child("currentPopsicles/\(identifier.uuidString)/eventEndDate").setValue(endDateFormatted)
                        
            ref.child("currentPopsicles/\(identifier.uuidString)/eventCategory").setValue(category)
            
        ref.child("currentPopsicles/\(identifier.uuidString)/hashtags").setValue(hashtagTextView.text)
            
            ref.child("currentPopsicles/\(identifier.uuidString)/createdBy").setValue(uid)
        
        let textInfo = ["location": location!, "eventName": eventNameTextField.text!, "eventInfo": detailsButton.text!, "eventStartDate": startDateFormatted!, "eventEndDate": endDateFormatted!, "eventCategory": category!, "hashtags": hashtagTextView.text!, "createdBy": uid ] as [String : Any]
        
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .eventCreated, object: nil, userInfo: textInfo)
        
            
//
//            newPopsicle.popsicleData.eventLocation = mainMapView.centerCoordinate
//
//                   newPopsicle.coordinate = newPopsicle.popsicleData.eventLocation
//
//                   let popsicleToAdd = pinPopsicle()
//
//            popsicleToAdd.popsicleData = pinData(eventName: newPopsicle.popsicleData.eventName, eventInfo: newPopsicle.popsicleData.eventInfo, eventDate: newPopsicle.popsicleData.eventDate, eventDuration: newPopsicle.popsicleData.eventDuration, eventCategory: newPopsicle.popsicleData.eventCategory, eventCategoryDetails: newPopsicle.popsicleData.eventCategoryDetails, eventSubcategory1: newPopsicle.popsicleData.eventSubcategory1, eventSubcategory1Details: newPopsicle.popsicleData.eventSubcategory1Details, eventSubcategory2: newPopsicle.popsicleData.eventSubcategory2, eventSubcategory2Details: newPopsicle.popsicleData.eventSubcategory2Details, eventLocation: newPopsicle.popsicleData.eventLocation, eventPopsicle: newPopsicle.popsicleData.eventPopsicle, whosGoing: newPopsicle.popsicleData.whosGoing)
//
//                   popsicleToAdd.coordinate = popsicleToAdd.popsicleData.eventLocation
            
            //mapPopsicles?.append(popsicleToAdd)
    }
    
    
    
    
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
extension Notification.Name {
    public static let myNotificationKey = Notification.Name(rawValue: "myNotificationKey")
}

extension NewCreateEventCardViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
    return FlipPresentAnimationController(originFrame: backgroundView.frame)
  }
    
    func animationController(forDismissed dismissed: UIViewController)
      -> UIViewControllerAnimatedTransitioning? {
      guard let _ = dismissed as? EditLocationViewController else {
        return nil
      }
        return FlipDismissAnimationController(destinationFrame: backgroundView.frame) 
    }
}
