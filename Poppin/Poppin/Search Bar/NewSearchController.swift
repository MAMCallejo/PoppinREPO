//
//  NewSearchController.swift
//  Poppin
//
//  Created by Abdulrahman Ayad on 6/14/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import Foundation
import UIKit

public class NewSearchController: UISearchController {

    private var customSearchBar = NewSearchBar()
    override public var searchBar: UISearchBar {
        get {
            return customSearchBar
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public override init(searchResultsController: UIViewController?){
        super.init(searchResultsController: searchResultsController)
    }
//    public init(searchResultsController: UIViewController?,
//                searchResultsUpdater: UISearchResultsUpdating?,
//                delegate: UISearchControllerDelegate?,
//                dimsBackgroundDuringPresentation: Bool,
//                hidesNavigationBarDuringPresentation: Bool,
//                searchBarDelegate: UISearchBarDelegate?,
//                searchBarFrame: CGRect?,
//                searchBarStyle: UISearchBarStyle,
//                searchBarPlaceHolder: String,
//                searchBarFont: UIFont?,
//                searchBarTextColor: UIColor?,
//                searchBarBarTintColor: UIColor?, // Bar background
//                searchBarTintColor: UIColor) { // Cursor and bottom line
//
//        super.init(searchResultsController: searchResultsController)
//
//        self.searchResultsUpdater = searchResultsUpdater
//        self.delegate = delegate
//        self.dimsBackgroundDuringPresentation = dimsBackgroundDuringPresentation
//        self.hidesNavigationBarDuringPresentation = hidesNavigationBarDuringPresentation
//
//        customSearchBar.setUp(searchBarDelegate,
//                              frame: searchBarFrame,
//                              barStyle: searchBarStyle,
//                              placeholder: searchBarPlaceHolder,
//                              font: searchBarFont,
//                              textColor: searchBarTextColor,
//                              barTintColor: searchBarBarTintColor,
//                              tintColor: searchBarTintColor)
//
//    }
}
