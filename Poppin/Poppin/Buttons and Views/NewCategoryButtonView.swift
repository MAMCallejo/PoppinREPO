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
    
    lazy private(set) var category: PopsicleCategory = NewCategoryButtonView.defaultCategory
    private let horizontalEdgeInset: CGFloat = .getPercentageWidth(percentage: 0.5)
    private let verticalEdgeInset: CGFloat = .getPercentageWidth(percentage: 1)
    
    private(set) var isSelected: Bool = false {
        
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
    
    lazy public var categoryIconImageView: UIImageView = {
        
        var categoryIconImageView = UIImageView()
        categoryIconImageView.contentMode = .scaleAspectFit
        categoryIconImageView.backgroundColor = .clear
        return categoryIconImageView
        
    }()
    
    lazy public var categoryNameLabel: UILabel = {
        
        var categoryNameLabel = UILabel()
        categoryNameLabel.textAlignment = .left
        categoryNameLabel.numberOfLines = 1
        categoryNameLabel.textColor = .mainNAVYBLUE
        categoryNameLabel.backgroundColor = .clear
        categoryNameLabel.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 18.0, maxSize: 20.0))
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
            
            categoryNameLabel.text = PopsicleCategory.Education.rawValue
            categoryIconImageView.image = .educationPopsicleIcon
            
        case .Food:
            
            categoryNameLabel.text = PopsicleCategory.Food.rawValue
            categoryIconImageView.image = .foodPopsicleIcon
            
        case .Social:
            
            categoryNameLabel.text = PopsicleCategory.Social.rawValue
            categoryIconImageView.image = .socialPopsicleIcon
            
        case .Sports:
            
            categoryNameLabel.text = PopsicleCategory.Sports.rawValue
            categoryIconImageView.image = .sportsPopsicleIcon
            
        case .Shows:
            
            categoryNameLabel.text = PopsicleCategory.Shows.rawValue
            categoryIconImageView.image = .showsPopsicleIcon
            
        case .Default:
            
            categoryNameLabel.text = PopsicleCategory.Default.rawValue
            categoryIconImageView.image = .defaultPopsicleIcon
            
        }
        
        categoryButton.addTarget(self, action: #selector(animateCategoryButton), for: .touchUpInside)
        
        backgroundColor = .white
        addShadowAndRoundCorners(shadowOpacity: 0.0)
        
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
    
    override func layoutSubviews() {
        
        layer.cornerRadius = getCornerRadiusFit(percentage: 40)
        
    }
    
}
