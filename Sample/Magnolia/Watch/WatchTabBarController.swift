//
//  WatchTabBarController.swift
//  Sample
//
//  Created by Ramya K on 23/05/22.
//

import UIKit

 class WatchTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
    }
    
    private func setUpNavBar() {
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = NavBarTitleEnum.title.rawValue
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: FontsEnum.TimesNewRoman.rawValue, size: 18)!
        ]
    }
    
 
}
