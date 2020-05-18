//
//  NewCreateEventViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 5/13/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

//import UIKit
//
//class NewCreateEventViewController : UIViewController {
//
//    private let collViewVerticalEdgeInset: CGFloat = .getPercentageWidth(percentage: 5)
//    private let collViewHorizontalEdgeInset: CGFloat = .getPercentageWidth(percentage: 3)
//
//    lazy private var collectionView: UICollectionView = {
//
//        let collectionDataSource = CollectionDataSource()
//        let flowLayout = ZoomAndSnapFlowLayout()
//
//        var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout.init())
//        collectionView.dataSource = collectionDataSource
//        collectionView.collectionViewLayout = flowLayout
//        collectionView.contentInsetAdjustmentBehavior = .always
//        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//
//        //collectionView.translatesAutoresizingMaskIntoConstraints = false
//        //collectionView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 90)).isActive = true
//        //collectionView.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 20)).isActive = true
//
//        return collectionView
//
//    }()
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//        /* FOR TRIAL PURPOSES */
//        modalPresentationStyle = .overFullScreen
//
//    }
//
//    required init?(coder: NSCoder) {
//
//        super.init(coder: coder)
//
//        /* FOR TRIAL PURPOSES */
//        modalPresentationStyle = .overFullScreen
//
//    }
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        view.backgroundColor = .red
//
//        view.addSubview(collectionView)
//
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.widthAnchor.constraint(equalToConstant: 400).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collViewVerticalEdgeInset).isActive = true
//        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        collectionView.backgroundColor = .white
//
//    }
//
//}
//
//class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {
//
//    let activeDistance: CGFloat = 200
//    let zoomFactor: CGFloat = 0.3
//
//    override init() {
//        super.init()
//
//        print("flow layout initialized")
//
//        scrollDirection = .horizontal
//        minimumLineSpacing = 10
//        itemSize = CGSize(width: 50, height: 100)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func prepare() {
//        guard let collectionView = collectionView else { fatalError() }
//        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
//        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
//        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
//
//        super.prepare()
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let collectionView = collectionView else { return nil }
//        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
//        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
//
//        // Make the cells be zoomed when they reach the center of the screen
//        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
//            let distance = visibleRect.midX - attributes.center.x
//            let normalizedDistance = distance / activeDistance
//
//            if distance.magnitude < activeDistance {
//                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
//                attributes.zIndex = Int(zoom.rounded())
//            }
//        }
//
//        return rectAttributes
//    }
//
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        guard let collectionView = collectionView else { return .zero }
//
//        // Add some snapping behaviour so that the zoomed cell is always centered
//        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
//        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
//
//        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
//        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
//
//        for layoutAttributes in rectAttributes {
//            let itemHorizontalCenter = layoutAttributes.center.x
//            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
//                offsetAdjustment = itemHorizontalCenter - horizontalCenter
//            }
//        }
//
//        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
//    }
//
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
//        return true
//    }
//
//    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
//        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
//        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
//        return context
//    }
//
//}
//
//class CollectionDataSource: NSObject, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 9
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
//        return cell
//    }
//
//}
//
//class CollectionViewCell: UICollectionViewCell {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        //contentView.backgroundColor = .brown
//        contentView.backgroundColor = .green
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

import UIKit

class NewCreateEventViewController : UIViewController {
    
    // initialize empty collection view (i think there's a better way to do this with lazy variables
    var coverCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout.init())
    
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

        coverCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: CustomFlowLayout())
        
        // make collection view background transparent
        coverCollectionView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        coverCollectionView.dataSource = self
        coverCollectionView.delegate = self
        coverCollectionView.contentInsetAdjustmentBehavior = .always
        coverCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // padding space = collection view width - cell width
        let leftPadding = (coverCollectionView.frame.size.width - coverCollectionView.frame.size.height) / 2.0
        let rightPadding = leftPadding
        
        coverCollectionView.contentInset = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        
        // hide the scroll indicator
        coverCollectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(coverCollectionView)
        
        // collection view constraints
        coverCollectionView.translatesAutoresizingMaskIntoConstraints = false
        coverCollectionView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 100)).isActive = true
        coverCollectionView.heightAnchor.constraint(equalToConstant: .getPercentageHeight(percentage: 20)).isActive = true
        coverCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .getPercentageHeight(percentage: 55)).isActive = true
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
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
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
        contentView.layer.cornerRadius = 15
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowRadius = 2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        scrollDirection = .horizontal
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
