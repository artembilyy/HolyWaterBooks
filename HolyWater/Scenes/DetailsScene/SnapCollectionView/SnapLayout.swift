//
//  SnapLayout.swift
//  HolyWater
//
//  Created by Артем Билый on 22.11.2023.
//

import UIKit

final class SnapLayout: UICollectionViewFlowLayout {

    private let style = Style.defaultStyle()

    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = style.spacing
        minimumInteritemSpacing = style.spacing
        itemSize = style.itemSize
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {

        guard let collectionView else { return }

        let verticalInsets = (collectionView.frame.height
            - collectionView.adjustedContentInset.top
            - collectionView.adjustedContentInset.bottom
            - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width
            - collectionView.adjustedContentInset.right
            - collectionView.adjustedContentInset.left
            - itemSize.width) / 2

        sectionInset = UIEdgeInsets(
            top: verticalInsets,
            left: horizontalInsets,
            bottom: verticalInsets,
            right: horizontalInsets)

        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let collectionView,
              let superAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        let rectAttributes = superAttributes.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }

        let visibleRect = CGRect(
            origin: collectionView.contentOffset,
            size: collectionView.frame.size)

        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / style.activeDistance

            if distance.magnitude < style.activeDistance {
                let zoom = 1 + style.zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }

        return rectAttributes
    }

    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView else { return .zero }

        let targetRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: collectionView.frame.width,
            height: collectionView.frame.height)

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

    override func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {

        guard
            let superContext = super.invalidationContext(
                forBoundsChange: newBounds
            ) as? UICollectionViewFlowLayoutInvalidationContext
        else {
            return super.invalidationContext(forBoundsChange: newBounds)
        }

        let context = superContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }

    func indexPathForItem(at center: CGPoint) -> IndexPath? {
        guard let collectionView else { return nil }

        let visibleRect = CGRect(
            origin: collectionView.contentOffset,
            size: collectionView.frame.size)

        guard let visibleAttributes = super.layoutAttributesForElements(in: visibleRect) else {
            return nil
        }

        for attributes in visibleAttributes {
            if attributes.frame.contains(center) {
                return attributes.indexPath
            }
        }

        return nil
    }
}
