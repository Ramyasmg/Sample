//
//  EpisodeCollectionViewCell.swift
//  Sample
//
//  Created by Ramya K on 23/05/22.
//

import UIKit

final class EpisodeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var ShowTitleLabel: UILabel!
    
    func setView(imageURL: String, title: String) {
        imageView.sd_setImage(with: URL(string: imageURL))
        ShowTitleLabel.text = title
    }
}
