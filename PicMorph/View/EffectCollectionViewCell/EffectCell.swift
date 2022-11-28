//
//  EffectCell.swift
//  PicMorph
//
//  Created by Alina Sitsko on 25.11.22.
//

import UIKit

class EffectCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var effectLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var effect: Effect? {
        didSet {
            backView.backgroundColor = UIColor.systemGray3
            backView.layer.cornerRadius = 30
            imageView.layer.cornerRadius = 30
            effectLabel.text = effect?.name
            if let image = effect?.image {
                imageView.image = UIImage(named: image)
            }
        }
    }
}
