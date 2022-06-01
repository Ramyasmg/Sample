//
//  WatchHeaderCVCell.swift
//  Sample
//
//  Created by Ramya K on 23/05/22.
//


protocol EpisodeDetails {
    func showEpisodeDetails(title: String?)
}

import UIKit

final class WatchHeaderCVCell: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    var delegate: EpisodeDetails?
    
    @IBAction private func startWatchingTapped(_ sender: Any) {
        delegate?.showEpisodeDetails(title: nil)
    }
    
    func setProperties(imageURL: String, title: String, description: String) {
        imageView.sd_setImage(with: URL(string: imageURL))
        descriptionLabel.text = description
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [.kern: 3.12])
    }
    
}
