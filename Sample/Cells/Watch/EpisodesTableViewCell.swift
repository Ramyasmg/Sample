//
//  EpisodesTableViewCell.swift
//  Sample
//
//  Created by Ramya K on 23/05/22.
//

import UIKit

final class EpisodesTableViewCell: UITableViewCell{
    
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    var delegate: EpisodeDetails?
    
    var shows: [Show] = [] {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(cell: EpisodeCollectionViewCell.self)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitle(title: String, showsArray: [Show]) {
        titleLabel.text = title
        self.shows = showsArray
    }
    
}

extension EpisodesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: EpisodeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setView(imageURL: shows[indexPath.row].imagePath, title: shows[indexPath.row].showTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.frame.size.width - 30)/2.5
        let height = width * 16/9
        return CGSize(width: width, height: height+20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showEpisodeDetails(title: shows[indexPath.row].showTitle)
    }
    
}
