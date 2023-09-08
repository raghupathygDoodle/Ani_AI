//
//  DescriptionPresentViewController.swift
//  StarMaker
//
//  Created by Raghu on 26/06/23.
//

import UIKit

class DescriptionPresentViewController: UIViewController {

    @IBOutlet weak var hashTagCollectionView: UICollectionView!
    var closureDismiss: (()->())?
    var hashTags = ["Beauty","Skincare","Night-Routine","Serum","Clear-Skin","Acne","Acne-Free"]
    override func viewDidLoad() {
        super.viewDidLoad()

        hashTagCollectionView.delegate = self
        hashTagCollectionView.dataSource = self
        hashTagCollectionView.register(UINib(nibName: "HashTagDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HashTagDetailsCollectionViewCell")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismissButtonAction(_ sender: UIButton) {
        if let action = closureDismiss{
//            self.dismiss(animated: true)
            action()
        }
        
    }
}
extension DescriptionPresentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashTagDetailsCollectionViewCell", for: indexPath) as? HashTagDetailsCollectionViewCell else{return UICollectionViewCell()}
        cell.labelHashTags.text = "#\(hashTags[indexPath.item])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
