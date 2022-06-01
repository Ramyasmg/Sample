//
//  UITableView.swift
//  Sample
//
//  Created by Ramya K on 29/05/22.
//

import Foundation

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cell: T.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
}

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
