//
//  UICollectionView.swift
//  Sample
//
//  Created by Ramya K on 29/05/22.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(cell.nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
}
