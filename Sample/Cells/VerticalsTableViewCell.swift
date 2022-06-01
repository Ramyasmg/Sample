//
//  VerticalsTableViewCell.swift
//  Sample
//
//  Created by Ramya K on 19/05/22.
//



import UIKit

protocol verticalsButtonTap {
    func verticalsTappedAt(index: Int)
}

final class VerticalsTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var verticalImage: UIImageView!
    @IBOutlet weak private var verticalButton: UIButton!
    
    var index = 0
    var delegate: verticalsButtonTap?
    
    func setCell(imageURL: String, buttonTitle: String, index: Int) {
        verticalImage.sd_setImage(with: URL(string: imageURL), completed: nil)
        verticalButton.setTitle(buttonTitle.uppercased(), for: .normal)
        self.index = index
    }
    
    @IBAction func onTapButton(_ sender: Any) {
        delegate?.verticalsTappedAt(index: index)
    }
    
}
