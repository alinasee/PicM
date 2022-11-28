//
//  HomeVC.swift
//  PicMorph
//
//  Created by Alina Sitsko on 25.11.22.
//

import UIKit

final class HomeVC: UIViewController {
    
    private let effectsArray: [Effect] = {
        var effectModel = EffectModel()
        return effectModel.effects
    }()
    private let heightToWidtCellConst = 0.6
    @IBOutlet weak var effectsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effectsCollectionView.dataSource = self
        effectsCollectionView.delegate = self
        effectsCollectionView.register(UINib(nibName: String(describing: EffectCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: EffectCell.self))
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return effectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = effectsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EffectCell.self), for: indexPath) as! EffectCell
        cell.effect = effectsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = effectsCollectionView.frame
        let widthCell = frameCV.width - 32
        let heightCell = widthCell * CGFloat(heightToWidtCellConst)
        return CGSize(width: widthCell, height: heightCell )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoVC(nibName: String(describing: PhotoVC.self), bundle: nil)
        photoVC.effect = effectsArray[indexPath.row]
        present(photoVC, animated: true)
    }
}
