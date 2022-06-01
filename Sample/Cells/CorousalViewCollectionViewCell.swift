//
//  CorousalViewCollectionViewCell.swift
//  Sample
//
//  Created by Ramya K on 19/05/22.
//

import UIKit

final class CorousalViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var heroCorousalImageView: UIImageView!
    @IBOutlet weak private  var titleLabel: UILabel!
    
    func setProperties(title: String, imageURl: String) {
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [.kern: 3.12])
        heroCorousalImageView.sd_setImage(with: URL(string: imageURl), completed: nil)
    }
    
    @IBAction func shopTapped(_ sender: Any) {
        let WatchStoryBoard = UIStoryboard(name: StoryBoardIdentifier.watch.rawValue, bundle: Bundle.main)
        guard let VC = WatchStoryBoard.instantiateViewController(identifier: ViewControllerIdentifier.watchTabBarController.rawValue) as? WatchTabBarController
        else {
            return
        }
        print("ffffffff")
    }
    
}
