//
//  NewMapFiltersStackView.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 5/2/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

final class NewMapFiltersStackView: UIStackView {

    private let filterButtonEdgeInset: CGFloat = .getPercentageWidth(percentage: 1.8)
    private let filtersStackViewSpacing: CGFloat = .getPercentageWidth(percentage: 3.0)
    
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
        
        var showHideFiltersButton = BubbleButton(bouncyButtonImage: UIImage(systemSymbol: .arrowtriangleDownFill, withConfiguration: UIImage.SymbolConfiguration(pointSize: 0, weight: .bold)).withTintColor(.mainNAVYBLUE, renderingMode: .alwaysOriginal))
        showHideFiltersButton.backgroundColor = .white
        showHideFiltersButton.contentEdgeInsets = UIEdgeInsets(top: filterButtonEdgeInset, left: filterButtonEdgeInset, bottom: filterButtonEdgeInset, right: filterButtonEdgeInset)
        showHideFiltersButton.addTarget(self, action: #selector(showHideFilters), for: .touchUpInside)
        
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
                newFilterButton.addTarget(self, action: #selector(changeFilterState(sender:)), for: .touchUpInside)
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
    
    @objc func changeFilterState(sender: PopsicleBubbleButton) {
        
        if sender.isActive {
            
            sender.isActive = false
            sender.backgroundColor = .white
            
            if filtersVisibility {
                
                showHideFilters()
                
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
            showHideFilters()
            
        }
        
    }
    
    @objc func showHideFilters() {
        
        if filtersVisibility {
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
                
                self.filtersVisibility = !self.filtersVisibility
                            
            }, completion: nil)
            
        } else {
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
                
                self.filtersVisibility = !self.filtersVisibility
                            
            }, completion: nil)
            
        }
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        showHideFiltersButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.57).isActive = true
        
    }
    
}
