//
//  NewSearchViewController.swift - View controller managing the view shown to search.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 5/1/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewSearchViewController: UIViewController {
    
    private let searchVerticalEdgeInset: CGFloat = .getPercentageWidth(percentage: 5)
    private let searchHorizontalEdgeInset: CGFloat = .getPercentageWidth(percentage: 5)
    
    lazy private var searchBar: NewSearchBar = {
    
        var mainSearchBar = NewSearchBar(tintColor: UIColor.darkGray)
        mainSearchBar.delegate = self
        return mainSearchBar
        
    }()
    
    lazy private var cancelButton: BouncyButton = {
        
        var cancelButton = BouncyButton(bouncyButtonImage: nil)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel!.textAlignment = .center
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.titleLabel!.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 14.0, maxSize: 19.0))
        cancelButton.addTarget(self, action: #selector(closeSearchBar), for: .touchUpInside)
        return cancelButton
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        /* FOR TRIAL PURPOSES */
        
        modalPresentationStyle = .overFullScreen
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: searchVerticalEdgeInset/2).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -searchHorizontalEdgeInset*0.8).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: cancelButton.intrinsicContentSize.width).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.17*0.62).isActive = true
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalTo: cancelButton.heightAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: searchHorizontalEdgeInset*0.8).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -searchHorizontalEdgeInset*0.8).isActive = true
        
        searchBar.becomeFirstResponder()
        
    }
    
    @objc func closeSearchBar() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension NewSearchViewController: UISearchBarDelegate {
    
    
    
}
