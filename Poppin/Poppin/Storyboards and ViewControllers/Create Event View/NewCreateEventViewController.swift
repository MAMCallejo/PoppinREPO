//
//  NewCreateEventViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 5/13/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewCreateEventViewController : UIViewController {
    
//    lazy var category : UIView = {
//        let card = UIView()
//        card.backgroundColor = .white
//        card.layer.masksToBounds = false
//        card.layer.cornerRadius = 16
//        return card
//    }()
    
    lazy var categoryCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .getPercentageWidth(percentage: 5)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = UIColor(white: 1, alpha: 0.0)
        cv.dataSource = self
        cv.delegate = self
        //cv.isPagingEnabled = true
        cv.contentInsetAdjustmentBehavior = .always
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // padding space = collection view width - cell width
        let leftPadding = (cv.frame.size.width - cv.frame.size.height) / 2.0
        let rightPadding = leftPadding
        
        cv.contentInset = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        
        // hide the scroll indicator
        cv.showsHorizontalScrollIndicator = false
        return cv
        
    }()
    
    let cellReuseIdentifier = "cell"
    
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
        
        //UIGraphicsGetCurrentContext()?.setPatternPhase(CGSize(width: 2, height: 3))
        view.backgroundColor = .white
        let l = CAGradientLayer()
        l.type = .radial
        l.colors = [ UIColor.white.cgColor,
            UIColor.purple.cgColor]
        l.locations = [ 0.45 , 1 ]
        l.startPoint = CGPoint(x: 0.5, y: 0.5)
        l.endPoint = CGPoint(x: 1.3, y: 1.05)
        l.frame = view.layer.bounds
        view.layer.addSublayer(l)
        
//        view.addSubview(category)
//        // card-to-be-made view constraints
//        category.translatesAutoresizingMaskIntoConstraints = false
//        category.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 65)).isActive = true
//        category.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 15)).isActive = true
//        category.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 20)).isActive = true
//        category.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(categoryCollectionView)
        // collection view constraints
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 100)).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 30)).isActive = true
        categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 30)).isActive = true
        categoryCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
}

extension NewCreateEventViewController : UICollectionViewDataSource {
    // hardcode to show 10 cells, you can use array for this if you want
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell
        switch (indexPath.row)   {
          case 0:
            //
            cell.contentView.backgroundColor = .white
            cell.contentView.alpha = 0.0
          case 1:
            cell.contentView.backgroundColor = .purple
          case 2:
            cell.contentView.backgroundColor = .red
          case 3:
            cell.contentView.backgroundColor = .orange
          case 4:
            cell.contentView.backgroundColor = .yellow
          case 5:
            cell.contentView.backgroundColor = .green
          case 6:
            //
            cell.contentView.backgroundColor = .white
            cell.contentView.alpha = 0.0
        default:
           break
         }
        return cell
    }
}

// Cell height is equal to the collection view's height
// Cell width = cell height = collection view's height
extension NewCreateEventViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: .getPercentageWidth(percentage: 50), height: collectionView.frame.size.height)
    }
    
}

extension NewCreateEventViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

     switch (indexPath.row)   {
         case 0:
            print("0")
         case 1:
            print("1")
         case 2:
            print("2")
         case 3:
            print("3")
         case 4:
            print("4")
         case 5:
            print("5")
         case 6:
            print("6")
       default:
          break
        }

    }
    
}

extension NewCreateEventViewController : UIScrollViewDelegate {
    
    // perform scaling whenever the collection view is being scrolled
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // center X of collection View
        let centerX = self.categoryCollectionView.center.x
    
        // only perform the scaling on cells that are visible on screen
        for cell in self.categoryCollectionView.visibleCells {
            
            // coordinate of the cell in the viewcontroller's root view coordinate space
            let basePosition = cell.convert(CGPoint.zero, to: self.view)
            let cellCenterX = basePosition.x + self.categoryCollectionView.frame.size.height / 2.0
            
            let distance = abs(cellCenterX - centerX)
            
            let tolerance : CGFloat = 0.02
            var scale = 1.00 + tolerance - (( distance / centerX ) * 0.105)
            if(scale > 1.0){
                scale = 1.0
            }
            
            // set minimum scale so the previous and next album art will have the same size
            if(scale < 0.860091){
                scale = 0.860091
            }
            
            // Transform the cell size based on the scale
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            // change the alpha of the image view
            let coverCell = cell as! CollectionViewCell
            coverCell.contentView.alpha = changeSizeScaleToAlphaScale(scale)
        }
    }
    
    // map the scale of cell size to alpha of image view using formula below
    // https://stackoverflow.com/questions/5294955/how-to-scale-down-a-range-of-numbers-with-a-known-min-and-max-value
    func changeSizeScaleToAlphaScale(_ x : CGFloat) -> CGFloat {
        let minScale : CGFloat = 0.86
        let maxScale : CGFloat = 1.0
        
        let minAlpha : CGFloat = 0.25
        let maxAlpha : CGFloat = 1.0
        
        return ((maxAlpha - minAlpha) * (x - minScale)) / (maxScale - minScale) + minAlpha
    }
    
    // for custom snap-to paging, when user stop scrolling
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        var indexOfCellWithLargestWidth = 0
        var largestWidth : CGFloat = 1
        
        for cell in self.categoryCollectionView.visibleCells {
            if cell.frame.size.width > largestWidth {
                largestWidth = cell.frame.size.width
                if let indexPath = self.categoryCollectionView.indexPath(for: cell) {
                    indexOfCellWithLargestWidth = indexPath.item
                }
            }
        }
        
        categoryCollectionView.scrollToItem(at: IndexPath(item: indexOfCellWithLargestWidth, section: 0), at: .centeredHorizontally, animated: true)
    }

}

class CollectionViewCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        //contentView.backgroundColor = .white
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 16
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowRadius = 2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
