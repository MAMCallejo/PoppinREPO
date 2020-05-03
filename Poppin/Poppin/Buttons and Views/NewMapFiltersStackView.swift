//
//  NewMapFiltersStackView.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 5/3/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

final class NewMapFiltersStackView: UIStackView {

    private let filterButtonEdgeInset: CGFloat = .getPercentageWidth(percentage: 1.8)
    private let filtersStackViewSpacing: CGFloat = .getPercentageWidth(percentage: 3.0)
    
    private var firstTimeLoading = true
    
    private(set) var filtersVisibility: Bool = false {
        
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
        showHideFiltersButton.addTarget(self, action: #selector(toggleFilters), for: .touchUpInside)
        
        showHideFiltersButton.translatesAutoresizingMaskIntoConstraints = false
        showHideFiltersButton.heightAnchor.constraint(equalTo: showHideFiltersButton.widthAnchor).isActive = true
        
        return showHideFiltersButton
        
    }()
    
    lazy private(set) var filterLabels: [UILabel] = []
    
    convenience init () {
        
        self.init(popsicleFilters: [.Education, .Food, .Social, .Sports, .Shows, .Poppin])
        
    }
    
    init(popsicleFilters: [PopsicleCategory]?) {
        
        super.init(frame: .zero)
        
        if let newPopsicleFilters = popsicleFilters {
            
            for popsicleFilter in newPopsicleFilters {
                
                let newFilterButton: PopsicleBubbleButton
                let newFilterLabel: UILabel = UILabel()
                
                switch popsicleFilter {
                    
                case .Education:
                    
                    newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Education)
                    newFilterLabel.text = "Filter " + PopsicleCategory.Education.rawValue
                    
                case .Food:
                    
                    newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Food)
                    newFilterLabel.text = "Filter " + PopsicleCategory.Food.rawValue
                    
                case .Social:
                    
                    newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Social)
                    newFilterLabel.text = "Filter " + PopsicleCategory.Social.rawValue
                    
                case .Sports:
                    
                    newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Sports)
                    newFilterLabel.text = "Filter " + PopsicleCategory.Sports.rawValue
                    
                case .Shows:
                    
                    newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Shows)
                    newFilterLabel.text = "Filter " + PopsicleCategory.Shows.rawValue
                    
                case .Poppin:
                    
                    newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Poppin)
                    newFilterLabel.text = "Filter " + PopsicleCategory.Poppin.rawValue
                    
                case .Default:
                    
                    newFilterButton = PopsicleBubbleButton(popsicleCategory: PopsicleCategory.Default)
                    newFilterLabel.text = "Filter " + PopsicleCategory.Default.rawValue
                    
                }
                
                newFilterButton.backgroundColor = .white
                newFilterButton.contentEdgeInsets = UIEdgeInsets(top: filterButtonEdgeInset, left: filterButtonEdgeInset, bottom: filterButtonEdgeInset, right: filterButtonEdgeInset)
                newFilterButton.addTarget(self, action: #selector(changeFilterState(sender:)), for: .touchUpInside)
                newFilterButton.isHidden = true
                
                newFilterButton.translatesAutoresizingMaskIntoConstraints = false
                newFilterButton.heightAnchor.constraint(equalTo: newFilterButton.widthAnchor).isActive = true
                
                addArrangedSubview(newFilterButton)
                
                newFilterLabel.textAlignment = .center
                newFilterLabel.textColor = .white
                newFilterLabel.addShadowAndRoundCorners(shadowColor: UIColor.darkGray, shadowOffset: CGSize(width: 0.0, height: 1.0), shadowOpacity: 0.3, shadowRadius: 8.0)
                newFilterLabel.numberOfLines = 1
                newFilterLabel.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 15, maxSize: 20))
                newFilterLabel.translatesAutoresizingMaskIntoConstraints = false
                newFilterLabel.alpha = 0.0
                filterLabels.append(newFilterLabel)
                
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
    
    @objc func changeFilterState(sender: PopsicleBubbleButton) {
        
        if sender.isActive {
            
            sender.isActive = false
            sender.backgroundColor = .white
            
            if filtersVisibility {
                
                toggleFilters()
                
            } else {
                
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                    
                    sender.isHidden = true
                                
                }, completion: nil)
                
            }
            
        } else {
            
            for view in arrangedSubviews {
                
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
        
        if filtersVisibility {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                
                for filterLabel in self.filterLabels {
                    
                    filterLabel.alpha = 0.0
                    
                }
                            
            }, completion: nil)
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                
                self.filtersVisibility = !self.filtersVisibility
                            
            }, completion: nil)
            
        } else {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                
                for filterLabel in self.filterLabels {
                    
                    filterLabel.alpha = 1.0
                    
                }
                            
            }, completion: nil)
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                
                self.filtersVisibility = !self.filtersVisibility
                            
            }, completion: nil)
            
        }
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if firstTimeLoading {
            
            showHideFiltersButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.57).isActive = true
            
            if let superview = superview {
                
                var index = 0
                
                while index < filterLabels.count {
                    
                    superview.addSubview(filterLabels[index])
                    filterLabels[index].centerYAnchor.constraint(equalTo: arrangedSubviews[index].centerYAnchor).isActive = true
                    filterLabels[index].trailingAnchor.constraint(equalTo: arrangedSubviews[index].leadingAnchor, constant: -filtersStackViewSpacing).isActive = true
                    
                    index+=1
                    
                }
                
            }
            
            firstTimeLoading = false
            
        }
        
    }
    
}
