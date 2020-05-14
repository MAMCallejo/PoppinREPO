//
//  NewCreateEventViewController.swift
//  Poppin
//
//  Created by Josiah Aklilu on 5/13/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit

class NewCreateEventViewController : UIViewController {
    
    private let collViewVerticalEdgeInset: CGFloat = .getPercentageWidth(percentage: 5)
    private let collViewHorizontalEdgeInset: CGFloat = .getPercentageWidth(percentage: 3)
    
    lazy private var collectionView: UICollectionView = {

        let collectionDataSource = CollectionDataSource()
        let flowLayout = ZoomAndSnapFlowLayout()

        var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.dataSource = collectionDataSource
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 90)).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: .getPercentageWidth(percentage: 20)).isActive = true

        return collectionView

    }()
    
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
        
        view.backgroundColor = .red

        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collViewVerticalEdgeInset).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.backgroundColor = .white
        
    }
    
}

class ZoomAndSnapFlowLayout: UICollectionViewFlowLayout {

    let activeDistance: CGFloat = 50
    let zoomFactor: CGFloat = 0.3

    override init() {
        super.init()

        scrollDirection = .horizontal
        minimumLineSpacing = 30
        itemSize = CGSize(width: 50, height: 50)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)

        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / activeDistance

            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }

        return rectAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

}

class CollectionDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        return cell
    }

}

class CollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .green
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

