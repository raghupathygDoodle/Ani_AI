//
//  HomeCategoriesViewModel.swift
//  StarMaker
//
//  Created by Raghu on 01/08/23.
//

import UIKit

class HomeCategoriesViewModel: NSObject {

    func registerCollectionViewNib(collectionView: UICollectionView,completion: @escaping()->()){
        collectionView.register(UINib(nibName: "MainCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCategoriesCollectionViewCell")
        completion()
        
        
    }
}
