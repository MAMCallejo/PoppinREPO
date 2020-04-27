//
//  NewCategoryButtonView.swift - Abstraction of the category pickers. They simply represent when a category has been picked or not.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 12/1/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit

class NewCategoryButtonView: UIView {
    
    public static let defaultCategory: PopsicleCategory = .Default
    
    lazy private var category: PopsicleCategory = NewCategoryButtonView.defaultCategory
    private let horizontalEdgeInset: CGFloat = Scaling.getPercentageWidth(percentage: 0.5)
    private let verticalEdgeInset: CGFloat = Scaling.getPercentageWidth(percentage: 1)
    
    private var isSelected: Bool = false {
        
        willSet (newState) {
            
            if isSelected != newState {
                
                let categoryNameLabelTextColor = categoryNameLabel.textColor
                
                categoryNameLabel.textColor = self.backgroundColor
                
                self.backgroundColor = categoryNameLabelTextColor
                
                if newState {
                    
                    self.layer.shadowOpacity = 0.3
                    
                } else {
                    
                    self.layer.shadowOpacity = 0
                    
                }
                
            }
            
        }
        
    }
    
    lazy private var categoryIconImageView: UIImageView = {
        
        var categoryIconImageView = UIImageView()
        categoryIconImageView.contentMode = .scaleAspectFit
        categoryIconImageView.backgroundColor = .clear
        return categoryIconImageView
        
    }()
    
    lazy private var categoryNameLabel: UILabel = {
        
        var categoryNameLabel = UILabel()
        categoryNameLabel.textAlignment = .left
        categoryNameLabel.numberOfLines = 1
        categoryNameLabel.textColor = .mainNAVYBLUE
        categoryNameLabel.backgroundColor = .clear
        categoryNameLabel.font = UIFont(name: "Octarine-Bold", size: Scaling.getWidthFitSize(minSize: 18.0, maxSize: 20.0))
        return categoryNameLabel
        
    }()
    
    lazy public var categoryButton: UIButton = UIButton()
    
    convenience init() {
        
        self.init(category: nil)
        
    }
    
    init(category: PopsicleCategory?) {
        
        super.init(frame: .zero)
        
        if let newCategory = category { self.category = newCategory }
        
        configureCategoryButtonView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
      super.init(coder: aDecoder)
        
      configureCategoryButtonView()
        
    }
    
    private func configureCategoryButtonView() {
        
        switch category {
            
        case .Education:
            
            categoryNameLabel.text = "Education"
            categoryIconImageView.image = #imageLiteral(resourceName: "educationButton")
            
        case .Food:
            
            categoryNameLabel.text = "Food"
            categoryIconImageView.image = #imageLiteral(resourceName: "foodButton")
            
        case .Social:
            
            categoryNameLabel.text = "Social"
            categoryIconImageView.image = #imageLiteral(resourceName: "socialButton")
            
        case .Sports:
            
            categoryNameLabel.text = "Sports"
            categoryIconImageView.image = #imageLiteral(resourceName: "sportsButton")
            
        case .Shows:
            
            categoryNameLabel.text = "Shows"
            categoryIconImageView.image = #imageLiteral(resourceName: "showsButton")
            
        case .Default:
            
            categoryNameLabel.text = "Default"
            categoryIconImageView.image = #imageLiteral(resourceName: "defaultCategoryButton")
            
        }
        
        categoryButton.addTarget(self, action: #selector(animateCategoryButton), for: .touchUpInside)
        
        backgroundColor = .white
        addShadowAndRoundCorners(cornerRadius: Scaling.getWidthFitSize(minSize: 8.0, maxSize: 15.0), shadowOpacity: 0.0)
        
        addSubview(categoryIconImageView)
        categoryIconImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: verticalEdgeInset).isActive = true
        categoryIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalEdgeInset).isActive = true
        categoryIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalEdgeInset).isActive = true
        categoryIconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        categoryIconImageView.heightAnchor.constraint(equalTo: categoryIconImageView.widthAnchor).isActive = true
        
        addSubview(categoryNameLabel)
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryNameLabel.heightAnchor.constraint(equalTo: categoryIconImageView.heightAnchor).isActive = true
        categoryNameLabel.leadingAnchor.constraint(equalTo: categoryIconImageView.trailingAnchor, constant: horizontalEdgeInset).isActive = true
        categoryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalEdgeInset).isActive = true
        
        addSubview(categoryButton)
        bringSubviewToFront(categoryButton)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        categoryButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categoryButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    @objc private func animateCategoryButton() {
        
        isSelected = !isSelected
        
    }
    
}
