//
//  EpisodesCVCell.swift
//  Sample
//
//  Created by Ramya K on 29/05/22.
//

import UIKit

class SeasonsCVCell: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var episodeNameLabel: UILabel!
    @IBOutlet weak  private var durationLabel: UILabel!
    
    func setProperties(imageURL: String, episodeName: String, duration: String) {
        imageView.sd_setImage(with: URL(string: imageURL))
        
        episodeNameLabel.text = episodeName
        if duration == "1" {
            durationLabel.text = "\(duration) min"
        }
        else {
            durationLabel.text = "\(duration) mins"
        }
        
    }
    
}
