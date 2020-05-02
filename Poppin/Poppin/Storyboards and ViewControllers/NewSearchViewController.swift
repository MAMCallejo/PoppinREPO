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
    private let searchHorizontalEdgeInset: CGFloat = .getPercentageWidth(percentage: 3)
    
    lazy private var searchTopStackView: UIStackView = {
        
        let searchBar = NewSearchBar(tintColor: UIColor.darkGray)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        
        let cancelButton = BouncyButton(bouncyButtonImage: nil)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel!.textAlignment = .center
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.titleLabel!.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 15.0, maxSize: 20.0))
        cancelButton.addTarget(self, action: #selector(closeSearchBar), for: .touchUpInside)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalToConstant: cancelButton.intrinsicContentSize.width).isActive = true
        
        var searchTopStackView = UIStackView(arrangedSubviews: [searchBar, cancelButton])
        searchTopStackView.axis = .horizontal
        searchTopStackView.alignment = .fill
        searchTopStackView.distribution = .fill
        searchTopStackView.spacing = searchHorizontalEdgeInset
        
        searchTopStackView.translatesAutoresizingMaskIntoConstraints = false
        searchTopStackView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 90)).isActive = true
        searchTopStackView.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 11)).isActive = true
        
        return searchTopStackView
        
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
        
        view.addSubview(searchTopStackView)
        searchTopStackView.translatesAutoresizingMaskIntoConstraints = false
        searchTopStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: searchVerticalEdgeInset).isActive = true
        searchTopStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    @objc func closeSearchBar() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension NewSearchViewController: UISearchBarDelegate {
    
    
    
}
