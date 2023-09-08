//
//  CenterAlignment.swift
//  Ani
//
//  Created by Raghu on 25/08/23.
//

import UIKit

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        let availableWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right
        let totalItemWidth = itemSize.width * CGFloat(collectionView.numberOfItems(inSection: 0))
        let spacingWidth = minimumInteritemSpacing * CGFloat(max(0, collectionView.numberOfItems(inSection: 0) - 1))
        let xOffset = (availableWidth - totalItemWidth - spacingWidth) / 2.0

        sectionInset.left = xOffset
        sectionInset.right = xOffset
    }
}
