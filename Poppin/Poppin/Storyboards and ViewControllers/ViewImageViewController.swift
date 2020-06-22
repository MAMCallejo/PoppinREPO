//
//  ViewImageViewController.swift
//  Poppin
//
//  Created by Abdulrahman Ayad on 6/19/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import Firebase

class ViewImageViewController: UIViewController {

    var uid: String?
    var storage: Storage?

    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * 0.8, height: view.bounds.width * 0.8)
        // userImage.addShadowAndRoundCorners(cornerRadius: userImage.bounds.height/2)
         imageView.layer.cornerRadius = imageView.bounds.height/2
        return imageView
    }()
    
    lazy var backButton: ImageBubbleButton = {
         let purpleArrow = UIImage(systemName: "arrow.left.circle.fill")!.withTintColor(.newPurple)
         let backButton = ImageBubbleButton(bouncyButtonImage: purpleArrow)
         backButton.contentMode = .scaleToFill
        // backButton.setTitle("Back", for: .normal)
         //backButton.setTitleColor(.newPurple, for: .normal)
         backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
         return backButton
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage = Storage.storage()
        

        
        let reference = (self.storage?.reference().child("images/\(uid!)/profilepic.jpg"))!


        // Placeholder image
        let placeholderImage = UIImage.defaultUserPicture256

        // Load the image using SDWebImage
        //cell.userImageHolder.sd_setImage(with: reference, placeholderImage: placeholderImage)
        imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.9)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))

        
        view.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.04).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.04).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: view.bounds.height * 0.04).isActive = true


        // Do any additional setup after loading the view.
    }
    
    @objc func goBack() {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    var viewTranslation = CGPoint(x: 0, y: 0)

    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
          case .changed:
              viewTranslation = sender.translation(in: view)
              UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                  self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
              })
          case .ended:
              if viewTranslation.y < 200 {
                  UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                      self.view.transform = .identity
                  })
              } else {
                  dismiss(animated: true, completion: nil)
              }
          default:
              break
          }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
