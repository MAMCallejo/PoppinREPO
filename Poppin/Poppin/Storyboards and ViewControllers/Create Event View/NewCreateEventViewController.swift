//
//  NewCreateEventViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 5/13/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewCreateEventViewController : UIViewController {
    
    lazy var coverCollectionView : UICollectionView = {
        
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
        
        view.backgroundColor = .black
        
        view.addSubview(coverCollectionView)
        
        // collection view constraints
        coverCollectionView.translatesAutoresizingMaskIntoConstraints = false
        coverCollectionView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 100)).isActive = true
        coverCollectionView.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 25)).isActive = true
        coverCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 35)).isActive = true
        coverCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
}

extension NewCreateEventViewController : UICollectionViewDataSource {
    // hardcode to show 10 cells, you can use array for this if you want
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell
        return cell
    }
}

// Cell height is equal to the collection view's height
// Cell width = cell height = collection view's height
extension NewCreateEventViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: .getPercentageWidth(percentage: 45), height: collectionView.frame.size.height)
    }
}

extension NewCreateEventViewController : UIScrollViewDelegate {
    
    // perform scaling whenever the collection view is being scrolled
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // center X of collection View
        let centerX = self.coverCollectionView.center.x
    
        // only perform the scaling on cells that are visible on screen
        for cell in self.coverCollectionView.visibleCells {
            
            // coordinate of the cell in the viewcontroller's root view coordinate space
            let basePosition = cell.convert(CGPoint.zero, to: self.view)
            let cellCenterX = basePosition.x + self.coverCollectionView.frame.size.height / 2.0
            
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
        
        for cell in self.coverCollectionView.visibleCells {
            if cell.frame.size.width > largestWidth {
                largestWidth = cell.frame.size.width
                if let indexPath = self.coverCollectionView.indexPath(for: cell) {
                    indexOfCellWithLargestWidth = indexPath.item
                }
            }
        }
        
        coverCollectionView.scrollToItem(at: IndexPath(item: indexOfCellWithLargestWidth, section: 0), at: .centeredHorizontally, animated: true)
    }

}

class CollectionViewCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        //contentView.backgroundColor = .brown
        contentView.backgroundColor = .white
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
