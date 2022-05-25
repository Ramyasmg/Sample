//
//  VerticalsTableViewCell.swift
//  Sample
//
//  Created by Ramya K on 19/05/22.
//

import UIKit

class VerticalsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var verticalImage: UIImageView!
    @IBOutlet weak var verticalButton: UIButton!
    
    func setCell(image: UIImage, buttonTitle: String) {
        verticalImage.image = image
        verticalButton.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func onTapButton(_ sender: Any) {
        print("tapped \(sender)")
    }
    
}
