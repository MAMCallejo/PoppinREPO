//
//  NewRefreshButtonView.swift - Abstraction of the refresh button/counter.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 1/30/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewRefreshButtonView: BubbleView {
    
    private let edgeInset: CGFloat = .getPercentageWidth(percentage: 1.5)
    
    private(set) var refreshButtonCount: Int = 0 {
        
        willSet(newCount) {
            
            if newCount != refreshButtonCount {
                
                refreshCountLabel.text = String(newCount)
                
                if newCount == 0 { // Hide Counter
                    
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                                   options: .curveEaseOut, animations: {
                                    
                                    self.refreshButtonBubbleView.backgroundColor = .white
                                    self.refreshButtonIconImageView.alpha = 1.0
                                    self.refreshCountLabel.alpha = 0.0
                                    
                    }, completion: nil)
                    
                } else if refreshButtonCount == 0 { // Show Counter
                    
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                                   options: .curveEaseOut, animations: {
                                    
                                    self.refreshButtonBubbleView.backgroundColor = .mainNAVYBLUE
                                    self.refreshButtonIconImageView.alpha = 0.0
                                    self.refreshCountLabel.alpha = 1.0
                                    
                    }, completion: nil)
                    
                }
                
            }
            
        }
        
    }
    
    lazy private var refreshButton: UIButton = {
        
        var refreshButton = UIButton()
        refreshButton.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        refreshButton.addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpOutside])
        refreshButton.addTarget(self, action: #selector(resetCounter), for: .touchUpInside)
        return refreshButton
        
    }()
    
    lazy private var refreshButtonBubbleView: BubbleView = {
        
        var refreshButtonBubbleView = BubbleView()
        refreshButtonBubbleView.backgroundColor = .white
        
        refreshButtonBubbleView.addSubview(refreshButtonIconImageView)
        refreshButtonIconImageView.translatesAutoresizingMaskIntoConstraints = false
        refreshButtonIconImageView.topAnchor.constraint(equalTo: refreshButtonBubbleView.topAnchor, constant: edgeInset*1.2).isActive = true
        refreshButtonIconImageView.bottomAnchor.constraint(equalTo: refreshButtonBubbleView.bottomAnchor, constant: -edgeInset).isActive = true
        refreshButtonIconImageView.leadingAnchor.constraint(equalTo: refreshButtonBubbleView.leadingAnchor, constant: edgeInset).isActive = true
        refreshButtonIconImageView.trailingAnchor.constraint(equalTo: refreshButtonBubbleView.trailingAnchor, constant: -edgeInset*1.2).isActive = true
        
        refreshButtonBubbleView.addSubview(refreshCountLabel)
        refreshCountLabel.translatesAutoresizingMaskIntoConstraints = false
        refreshCountLabel.centerYAnchor.constraint(equalTo: refreshButtonBubbleView.centerYAnchor).isActive = true
        refreshCountLabel.centerXAnchor.constraint(equalTo: refreshButtonBubbleView.centerXAnchor).isActive = true
        
        refreshCountLabel.alpha = 0.0
        
        return refreshButtonBubbleView
        
    }()
    
    lazy private var refreshButtonIconImageView: UIImageView = {
        
        let refreshButtonIconImageView = UIImageView()
        refreshButtonIconImageView.image = UIImage(systemSymbol: .checkmark, withConfiguration: UIImage.SymbolConfiguration(pointSize: 0, weight: .semibold)).withTintColor(.mainNAVYBLUE, renderingMode: .alwaysOriginal)
        refreshButtonIconImageView.contentMode = .scaleAspectFit
        return refreshButtonIconImageView
        
    }()
    
    lazy private var refreshCountLabel: UILabel = {
        
        var refreshCountLabel = UILabel()
        refreshCountLabel.textAlignment = .center
        refreshCountLabel.text = String(refreshButtonCount)
        refreshCountLabel.numberOfLines = 1
        refreshCountLabel.textColor = .white
        refreshCountLabel.font = UIFont(name: "Octarine-Bold", size: .getWidthFitSize(minSize: 13.0, maxSize: 15.0))
        return refreshCountLabel
        
    }()
    
    init() {
        
        super.init(frame: .zero)
        
        configureView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configureView()
        
    }
    
    private func configureView() {
        
        addSubview(refreshButtonBubbleView)
        refreshButtonBubbleView.translatesAutoresizingMaskIntoConstraints = false
        refreshButtonBubbleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        refreshButtonBubbleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        refreshButtonBubbleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        refreshButtonBubbleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    @objc private func animateDown(sender: UIButton) {
        
        let transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        
                        if self.refreshButtonCount == 0 {
                            
                            self.refreshButtonBubbleView.transform = transform
                            self.refreshButtonBubbleView.layer.opacity = 0.5
                            
                        } else {
                        
                            self.refreshButtonBubbleView.transform = transform
                            self.refreshButtonBubbleView.layer.opacity = 0.5
                            
                        }
                        
        }, completion: nil)
        
    }
    
    @objc private func animateUp(sender: UIButton) {
        
        let transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        
                        if self.refreshButtonCount == 0 {
                            
                            self.refreshButtonBubbleView.transform = transform
                            self.refreshButtonBubbleView.layer.opacity = 1.0
                            
                        } else {
                        
                            self.refreshButtonBubbleView.transform = transform
                            self.refreshButtonBubbleView.layer.opacity = 1
                            
                        }
                        
        }, completion: nil)
        
    }
    
    @objc private func resetCounter() {
        
        refreshButtonCount = 0
        animateUp(sender: refreshButton)
        
    }
    
    public func increaseCounter(by step: Int?) {
        
        if let newStep = step {
            
            if refreshButtonCount + newStep > 999 {
                
                refreshButtonCount = 999
                print("ERROR: Refresh Counter has reached max. Setting it to 999.")
                
            } else {
                
                refreshButtonCount += newStep
                
            }
            
        }
        
    }
    
    public func decreaseCounter(by step: Int?) {
        
        if let newStep = step {
            
            if refreshButtonCount - newStep < 0 {
                
                refreshButtonCount = 0
                print("ERROR: Refresh Counter is negative. Setting it to 0.")
                
            } else {
                
                refreshButtonCount -= newStep
                
            }
            
        }
        
    }
    
}

class BubbleView: UIView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        addShadowAndRoundCorners(cornerRadius: min(bounds.width, bounds.height) / 2)
        
    }
    
}
