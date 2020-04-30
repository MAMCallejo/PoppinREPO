//
//  NewUserLocationAnnotationView.swift - View that represents the user's location on the map.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 4/29/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import MapKit

class NewUserLocationAnnotationView: MKAnnotationView {
    
    public static let defaultUserLocationAnnotationViewReuseIdentifier = "UserLocationAnnotationView"
    
    lazy private var userLocationContainerView: UIView = {
        
        var userLocationContainerView = UIView()
        userLocationContainerView.backgroundColor = .clear
        
        userLocationContainerView.addSubview(userLocationIconBackgroundImageView)
        userLocationIconBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        userLocationIconBackgroundImageView.topAnchor.constraint(equalTo: userLocationContainerView.topAnchor).isActive = true
        userLocationIconBackgroundImageView.leadingAnchor.constraint(equalTo: userLocationContainerView.leadingAnchor).isActive = true
        userLocationIconBackgroundImageView.trailingAnchor.constraint(equalTo: userLocationContainerView.trailingAnchor).isActive = true
        userLocationIconBackgroundImageView.bottomAnchor.constraint(equalTo: userLocationContainerView.bottomAnchor).isActive = true
        
        userLocationContainerView.addSubview(userLocationIconImageView)
        userLocationIconImageView.translatesAutoresizingMaskIntoConstraints = false
        userLocationIconImageView.topAnchor.constraint(equalTo: userLocationContainerView.topAnchor).isActive = true
        userLocationIconImageView.leadingAnchor.constraint(equalTo: userLocationContainerView.leadingAnchor).isActive = true
        userLocationIconImageView.trailingAnchor.constraint(equalTo: userLocationContainerView.trailingAnchor).isActive = true
        userLocationIconImageView.bottomAnchor.constraint(equalTo: userLocationContainerView.bottomAnchor).isActive = true
        
        return userLocationContainerView
        
    }()
    
    lazy private var userLocationIconBackgroundImageView: UIImageView = {
        
        var userLocationIconBackgroundImageView = UIImageView()
        userLocationIconBackgroundImageView.image = .appBackground
        userLocationIconBackgroundImageView.contentMode = .scaleToFill
        return userLocationIconBackgroundImageView
        
    }()
    
    lazy private var userLocationIconImageView: UIImageView = {
        
        var userLocationIconImageView = UIImageView()
        userLocationIconImageView.image = UIImage(systemSymbol: .personFill).withTintColor(.mainNAVYBLUE, renderingMode: .alwaysOriginal)
        userLocationIconImageView.contentMode = .scaleAspectFit
        return userLocationIconImageView
        
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        configureView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configureView()
        
    }
    
    private func configureView() {
        
        canShowCallout = false
        frame.size = CGSize(width: .getPercentageWidth(percentage: 9), height: .getPercentageWidth(percentage: 9))
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.mainNAVYBLUE.cgColor
        layer.borderWidth = .getWidthFitSize(minSize: 2.9, maxSize: 3.5)
        clipsToBounds = true
        displayPriority = .required
        
        addSubview(userLocationContainerView)
        userLocationContainerView.translatesAutoresizingMaskIntoConstraints = false
        userLocationContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        userLocationContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        userLocationContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        userLocationContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    public func setUserLocationIcon(icon: UIImage?) {
        
        if let newIcon = icon { self.userLocationIconImageView.image = newIcon }
        
    }
    
}
