//
//  NewRefreshButtonView.swift - Abstraction of the refresh button/counter.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 1/30/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewRefreshButtonView: BubbleView {
    
    private let edgeInset: CGFloat = Scaling.getPercentageWidth(percentage: 1)
    
    private(set) var refreshButtonCount: Int = 0 {
        
        willSet(newCount) {
            
            if newCount != refreshButtonCount {
                
                refreshCountLabel.text = String(newCount)
                
                if newCount == 0 { // Hide Counter
                    
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                                   options: .curveEaseOut, animations: {
                                    
                                    self.refreshCountBubbleView.alpha = 0
                                    self.refreshCountBubbleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                                    self.refreshButtonIconView.alpha = 1.0
                                    self.refreshButtonIconView.transform = .identity
                                    
                    }, completion: nil)
                    
                } else if refreshButtonCount == 0 { // Show Counter
                    
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                                   options: .curveEaseOut, animations: {
                                    
                                    self.refreshCountBubbleView.alpha = 1.0
                                    self.refreshCountBubbleView.transform = .identity
                                    self.refreshButtonIconView.alpha = 0.0
                                    self.refreshButtonIconView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                                    
                    }, completion: nil)
                    
                } else { // Change Counter
                    
                    refreshCountBubbleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
                                   options: .curveEaseOut, animations: {
                                    
                                    self.refreshCountBubbleView.transform = .identity
                                    
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
    
    lazy private var refreshButtonIconView: BubbleView = {
        
        var refreshButtonIconView = BubbleView()
        refreshButtonIconView.backgroundColor = .mainNAVYBLUE
        
        let refreshButtonIconImageView = UIImageView()
        refreshButtonIconImageView.image = UIImage(systemName: "checkmark.circle.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        refreshButtonIconImageView.contentMode = .scaleAspectFit
        
        let edgeInset = Scaling.getWidthFitSize(minSize: 3.5, maxSize: 4.5)
        
        refreshButtonIconView.addSubview(refreshButtonIconImageView)
        refreshButtonIconImageView.translatesAutoresizingMaskIntoConstraints = false
        refreshButtonIconImageView.topAnchor.constraint(equalTo: refreshButtonIconView.topAnchor, constant: -edgeInset).isActive = true
        refreshButtonIconImageView.bottomAnchor.constraint(equalTo: refreshButtonIconView.bottomAnchor, constant: edgeInset).isActive = true
        refreshButtonIconImageView.leadingAnchor.constraint(equalTo: refreshButtonIconView.leadingAnchor, constant: -edgeInset).isActive = true
        refreshButtonIconImageView.trailingAnchor.constraint(equalTo: refreshButtonIconView.trailingAnchor, constant: edgeInset).isActive = true
        
        return refreshButtonIconView
        
    }()
    
    lazy private var refreshCountBubbleView: BubbleView = {
        
        var refreshCountBubbleView = BubbleView()
        refreshCountBubbleView.backgroundColor = .mainNAVYBLUE
        refreshCountBubbleView.clipsToBounds = true
        
        refreshCountBubbleView.addSubview(refreshCountLabel)
        refreshCountLabel.translatesAutoresizingMaskIntoConstraints = false
        refreshCountLabel.centerYAnchor.constraint(equalTo: refreshCountBubbleView.centerYAnchor).isActive = true
        refreshCountLabel.centerXAnchor.constraint(equalTo: refreshCountBubbleView.centerXAnchor).isActive = true
        
        refreshCountBubbleView.alpha = 0.0
        
        return refreshCountBubbleView
        
    }()
    
    lazy private var refreshCountLabel: UILabel = {
        
        var refreshCountLabel = UILabel()
        refreshCountLabel.textAlignment = .center
        refreshCountLabel.text = String(refreshButtonCount)
        refreshCountLabel.numberOfLines = 1
        refreshCountLabel.textColor = .white
        refreshCountLabel.font = UIFont(name: "Octarine-Bold", size: Scaling.getWidthFitSize(minSize: 13.0, maxSize: 15.0))
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
        
        addSubview(refreshButtonIconView)
        refreshButtonIconView.translatesAutoresizingMaskIntoConstraints = false
        refreshButtonIconView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        refreshButtonIconView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        refreshButtonIconView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        refreshButtonIconView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(refreshCountBubbleView)
        refreshCountBubbleView.translatesAutoresizingMaskIntoConstraints = false
        refreshCountBubbleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        refreshCountBubbleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        refreshCountBubbleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        refreshCountBubbleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
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
                            
                            self.refreshButtonIconView.transform = transform
                            self.refreshButtonIconView.layer.opacity = 0.5
                            
                        } else {
                        
                            self.refreshCountBubbleView.transform = transform
                            self.refreshCountBubbleView.layer.opacity = 0.5
                            
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
                            
                            self.refreshButtonIconView.transform = transform
                            self.refreshButtonIconView.layer.opacity = 1.0
                            
                        } else {
                        
                            self.refreshCountBubbleView.transform = transform
                            self.refreshCountBubbleView.layer.opacity = 1
                            
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
