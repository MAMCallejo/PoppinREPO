//
//  NewMapFiltersView.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 5/3/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

final class NewMapFiltersView: UIView {
    
    lazy private(set) var mapFiltersStackView: NewMapFiltersStackView = NewMapFiltersStackView()
    private let filterRowSize: CGFloat = .getPercentageWidth(percentage: 11)
    
    lazy private(set) var mapFilterLabelsStackView: UIStackView = {
        
        var mapFilterLabelsStackView = UIStackView()
        mapFilterLabelsStackView.axis = .vertical
        mapFilterLabelsStackView.alignment = .fill
        mapFilterLabelsStackView.distribution = .fill
        mapFilterLabelsStackView.spacing = mapFiltersStackView.filtersStackViewSpacing
        return mapFilterLabelsStackView
        
    }()
    
    convenience init() {
        
        self.init(popsicleFilters: nil)
        
    }
    
    init(popsicleFilters: [PopsicleCategory]?) {
        
        super.init(frame: .zero)
        
        if let newPopsicleFilters = popsicleFilters {
            
            mapFiltersStackView = NewMapFiltersStackView(popsicleFilters: newPopsicleFilters)
            
            for popsicleFilter in newPopsicleFilters {
                
                let newFilterLabel: UILabel = UILabel()
                
                switch popsicleFilter {
                    
                case .Education: newFilterLabel.text = "Filter " + PopsicleCategory.Education.rawValue
                case .Food: newFilterLabel.text = "Filter " + PopsicleCategory.Food.rawValue
                case .Social: newFilterLabel.text = "Filter " + PopsicleCategory.Social.rawValue
                case .Sports: newFilterLabel.text = "Filter " + PopsicleCategory.Sports.rawValue
                case .Shows: newFilterLabel.text = "Filter " + PopsicleCategory.Shows.rawValue
                case .Poppin: newFilterLabel.text = "Filter " + PopsicleCategory.Poppin.rawValue
                case .Default: newFilterLabel.text = "Filter " + PopsicleCategory.Default.rawValue
                    
                }
                
                newFilterLabel.textAlignment = .center
                newFilterLabel.textColor = .white
                newFilterLabel.addShadowAndRoundCorners(shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.3, shadowRadius: 8.0)
                newFilterLabel.numberOfLines = 1
                newFilterLabel.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 15, maxSize: 20))
                newFilterLabel.isHidden = true
                
                newFilterLabel.translatesAutoresizingMaskIntoConstraints = false
                newFilterLabel.heightAnchor.constraint(equalToConstant: filterRowSize).isActive = true
                
                mapFilterLabelsStackView.addArrangedSubview(newFilterLabel)
                
            }
            
        } else {
            
            let defaultPopsicleFilters: [PopsicleCategory] = [.Education, .Food, .Social, .Sports, .Shows, .Poppin]
            
            for popsicleFilter in defaultPopsicleFilters {
                
                let newFilterLabel: UILabel = UILabel()
                
                switch popsicleFilter {
                    
                case .Education: newFilterLabel.text = "Filter " + PopsicleCategory.Education.rawValue
                case .Food: newFilterLabel.text = "Filter " + PopsicleCategory.Food.rawValue
                case .Social: newFilterLabel.text = "Filter " + PopsicleCategory.Social.rawValue
                case .Sports: newFilterLabel.text = "Filter " + PopsicleCategory.Sports.rawValue
                case .Shows: newFilterLabel.text = "Filter " + PopsicleCategory.Shows.rawValue
                case .Poppin: newFilterLabel.text = "Filter " + PopsicleCategory.Poppin.rawValue
                case .Default: newFilterLabel.text = "Filter " + PopsicleCategory.Default.rawValue
                    
                }
                
                newFilterLabel.textAlignment = .right
                newFilterLabel.textColor = .white
                newFilterLabel.addShadowAndRoundCorners(shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.3, shadowRadius: 8.0)
                newFilterLabel.numberOfLines = 1
                newFilterLabel.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 15, maxSize: 20))
                newFilterLabel.isHidden = true
                
                newFilterLabel.translatesAutoresizingMaskIntoConstraints = false
                newFilterLabel.heightAnchor.constraint(equalToConstant: filterRowSize).isActive = true
                
                mapFilterLabelsStackView.addArrangedSubview(newFilterLabel)
                
            }
            
        }
        
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        let defaultPopsicleFilters: [PopsicleCategory] = [.Education, .Food, .Social, .Sports, .Shows, .Poppin]
        
        for popsicleFilter in defaultPopsicleFilters {
            
            let newFilterLabel: UILabel = UILabel()
            
            switch popsicleFilter {
                
            case .Education: newFilterLabel.text = "Filter " + PopsicleCategory.Education.rawValue
            case .Food: newFilterLabel.text = "Filter " + PopsicleCategory.Food.rawValue
            case .Social: newFilterLabel.text = "Filter " + PopsicleCategory.Social.rawValue
            case .Sports: newFilterLabel.text = "Filter " + PopsicleCategory.Sports.rawValue
            case .Shows: newFilterLabel.text = "Filter " + PopsicleCategory.Shows.rawValue
            case .Poppin: newFilterLabel.text = "Filter " + PopsicleCategory.Poppin.rawValue
            case .Default: newFilterLabel.text = "Filter " + PopsicleCategory.Default.rawValue
                
            }
            
            newFilterLabel.textAlignment = .center
            newFilterLabel.textColor = .white
            newFilterLabel.addShadowAndRoundCorners(shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.3, shadowRadius: 8.0)
            newFilterLabel.numberOfLines = 1
            newFilterLabel.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 15, maxSize: 20))
            newFilterLabel.isHidden = true
            
            newFilterLabel.translatesAutoresizingMaskIntoConstraints = false
            newFilterLabel.heightAnchor.constraint(equalToConstant: filterRowSize).isActive = true
            
            mapFilterLabelsStackView.addArrangedSubview(newFilterLabel)
            
        }
        
        configureView()
        
    }
    
    private func configureView() {
        
        backgroundColor = .clear
        
        for view in mapFiltersStackView.arrangedSubviews {
            
            if let filterButton = view as? PopsicleBubbleButton {
                
                filterButton.addTarget(self, action: #selector(changeFilterState(sender:)), for: .touchUpInside)
                
            } else if let showHideFiltersButton = view as? BubbleButton {
                
                showHideFiltersButton.addTarget(self, action: #selector(toggleFilters), for: .touchUpInside)
                
            }
            
        }
        
        addSubview(mapFiltersStackView)
        mapFiltersStackView.translatesAutoresizingMaskIntoConstraints = false
        mapFiltersStackView.widthAnchor.constraint(equalToConstant: filterRowSize).isActive = true
        mapFiltersStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapFiltersStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mapFiltersStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(mapFilterLabelsStackView)
        mapFilterLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        mapFilterLabelsStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapFilterLabelsStackView.trailingAnchor.constraint(equalTo: mapFiltersStackView.leadingAnchor, constant: -mapFiltersStackView.filtersStackViewSpacing).isActive = true
        mapFilterLabelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
    }
    
    @objc func changeFilterState(sender: PopsicleBubbleButton) {
        
        if sender.isActive {
            
            sender.isActive = false
            sender.backgroundColor = .white
            
            if mapFiltersStackView.filtersVisibility {
                
                toggleFilters()
                
            } else {
                
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                    
                    sender.isHidden = true
                                
                }, completion: nil)
                
            }
            
        } else {
            
            for view in mapFiltersStackView.arrangedSubviews {
                
                if let filterButton = view as? PopsicleBubbleButton, filterButton.isActive {
                    
                    filterButton.isActive = false
                    filterButton.backgroundColor = .white
                    
                }
                
            }
            
            sender.isActive = true
            sender.backgroundColor = .mainNAVYBLUE
            toggleFilters()
            
        }
        
    }
    
    @objc func toggleFilters() {
        
        if mapFiltersStackView.filtersVisibility {
            
            for filterLabel in self.mapFilterLabelsStackView.arrangedSubviews {
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                    
                    filterLabel.alpha = 0.0
                    
                }, completion: { _ in
                
                    filterLabel.isHidden = true
                
                })
                
            }
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                
                self.mapFiltersStackView.filtersVisibility = !self.mapFiltersStackView.filtersVisibility
                            
            }, completion: nil)
            
        } else {
            
            for filterLabel in self.mapFilterLabelsStackView.arrangedSubviews {
                
                filterLabel.isHidden = false
                filterLabel.alpha = 0.0
                
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                    
                    filterLabel.alpha = 1.0
                    
                }, completion: nil)
                
            }
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                
                self.mapFiltersStackView.filtersVisibility = !self.mapFiltersStackView.filtersVisibility
                            
            }, completion: nil)
            
        }
        
    }
    
}

final class NewMapFiltersStackView: UIStackView {

    private let filterButtonEdgeInset: CGFloat = .getPercentageWidth(percentage: 1.8)
    fileprivate let filtersStackViewSpacing: CGFloat = .getPercentageWidth(percentage: 3.0)
    
    private var initialLayout = true
    
    fileprivate var filtersVisibility: Bool = false {
        
        willSet (newVisibility) {
        
            if filtersVisibility != newVisibility {
                
                if newVisibility { // Show Filters
                        
                    self.showHideFiltersButton.transform = CGAffineTransform(rotationAngle: .pi)
                    
                    for view in arrangedSubviews {
                        
                        if view.isHidden {
                            
                            view.isHidden = false
                            
                        }
                        
                    }
        
                } else { // Hide Filters

                    self.showHideFiltersButton.transform = .identity
                    
                    for view in arrangedSubviews {
                        
                        if let filterButton = view as? PopsicleBubbleButton, !filterButton.isActive {
                            
                            filterButton.isHidden = true
                            
                        }
                        
                    }
                    
                }
                
            }
        
        }
        
    }
    
    lazy private(set) var showHideFiltersButton: BubbleButton = {
        
        var showHideFiltersButton = BubbleButton(bouncyButtonImage: UIImage.showMoreOptionsButton64)
        showHideFiltersButton.backgroundColor = .white
        showHideFiltersButton.contentEdgeInsets = UIEdgeInsets(top: filterButtonEdgeInset, left: filterButtonEdgeInset, bottom: filterButtonEdgeInset, right: filterButtonEdgeInset)
        
        showHideFiltersButton.translatesAutoresizingMaskIntoConstraints = false
        showHideFiltersButton.heightAnchor.constraint(equalTo: showHideFiltersButton.widthAnchor).isActive = true
        
        return showHideFiltersButton
        
    }()
    
    convenience init () {
        
        self.init(popsicleFilters: [.Education, .Food, .Social, .Sports, .Shows, .Poppin])
        
    }
    
    init(popsicleFilters: [PopsicleCategory]?) {
        
        super.init(frame: .zero)
        
        if let newPopsicleFilters = popsicleFilters {
            
            for popsicleFilter in newPopsicleFilters {
                
                let newFilterButton: PopsicleBubbleButton
                
                switch popsicleFilter {
                    
                case .Education: newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Education)
                case .Food: newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Food)
                case .Social: newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Social)
                case .Sports: newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Sports)
                case .Shows: newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Shows)
                case .Poppin: newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Poppin)
                case .Default: newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Default)
                    
                }
                
                newFilterButton.backgroundColor = .white
                newFilterButton.contentEdgeInsets = UIEdgeInsets(top: filterButtonEdgeInset, left: filterButtonEdgeInset, bottom: filterButtonEdgeInset, right: filterButtonEdgeInset)
                newFilterButton.isHidden = true
                
                newFilterButton.translatesAutoresizingMaskIntoConstraints = false
                newFilterButton.heightAnchor.constraint(equalTo: newFilterButton.widthAnchor).isActive = true
                
                addArrangedSubview(newFilterButton)
                
            }
            
        }
        
        configureStackView()
        
    }
    
    required init(coder: NSCoder) {
        
        super.init(coder: coder)
        
        configureStackView()
        
    }
    
    private func configureStackView() {

        axis = .vertical
        alignment = .center
        distribution = .fill
        spacing = filtersStackViewSpacing
        addArrangedSubview(showHideFiltersButton)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if initialLayout {
            
            showHideFiltersButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.57).isActive = true
            initialLayout = false
            
        }
        
    }
    
}

final class PopsicleBubbleButton: BubbleButton {
    
    private(set) var popsicleCategory: PopsicleCategory = .Default
    
    fileprivate var isActive: Bool = false
    
    init(popsicleCategory: PopsicleCategory?) {
        
        if let newPopsicleCategory = popsicleCategory {
            
            self.popsicleCategory = newPopsicleCategory
            
            switch newPopsicleCategory {
                
            case .Education: super.init(bouncyButtonImage: UIImage.educationPopsicleIcon)
                
            case .Food: super.init(bouncyButtonImage: UIImage.foodPopsicleIcon)
                
            case .Social: super.init(bouncyButtonImage: UIImage.socialPopsicleIcon)
                
            case .Sports: super.init(bouncyButtonImage: UIImage.sportsPopsicleIcon)
                
            case .Shows: super.init(bouncyButtonImage: UIImage.showsPopsicleIcon)
                
            case .Poppin: super.init(bouncyButtonImage: UIImage.poppinPopsicleIcon)
                
            case .Default: super.init(bouncyButtonImage: UIImage.defaultPopsicleIcon)
                
            }
            
        } else {
            
            super.init(bouncyButtonImage: UIImage.defaultPopsicleIcon)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
}
