//
//  ViewController.swift
//  Sample
//
//  Created by Ramya K on 19/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var verticalsTableView: UITableView!
    @IBOutlet weak var corousalviewCollectionView: UICollectionView!
    var buttonTitleData = ["SHOP", "WATCH", "WORKSHOPS","VISIT", "READ"]
    var timer: Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        verticalsTableView.delegate = self
        verticalsTableView.dataSource = self
        verticalsTableView.register(UINib(nibName: "VerticalsTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalsTableViewCell")
        corousalviewCollectionView.delegate = self
        corousalviewCollectionView.dataSource = self
        corousalviewCollectionView.register(UINib(nibName: "CorousalViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CorousalViewCollectionViewCell")
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavBar()
    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "MAGNOLIA"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        setUpLeftBarItems()
        setUpRightBarItems()
    }
    
    func setUpLeftBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style:.done, target: self, action: nil)
    }
    
    func setUpRightBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bag"), style:.done, target: self, action: nil)
    }
    
    @objc func slideToNext() {
        if currentCellIndex < 3 {
            currentCellIndex = currentCellIndex + 1
        }
        else {
            currentCellIndex = 0
        }
        corousalviewCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonTitleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalsTableViewCell") as! VerticalsTableViewCell
        cell.setCell(image:#imageLiteral(resourceName: "shop") ,buttonTitle: buttonTitleData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        switch indexPath.row {
            
        case 0:
            let ShopStoryBoard = UIStoryboard(name: "Shop", bundle: Bundle.main)
            guard let VC = ShopStoryBoard.instantiateViewController(identifier:"ShopTabBarController") as? ShopTabBarController
            else {
                print("Coudn't find the view controller")
                return
            }
            self.navigationController?.pushViewController(VC, animated: true)
            
        case 1:
            let WatchStoryBoard = UIStoryboard(name: "Watch", bundle: Bundle.main)
            guard let VC = WatchStoryBoard.instantiateViewController(identifier:"WatchTabBarController") as? WatchTabBarController
            else {
                print("Coudn't find the view controller")
                return
            }
            self.navigationController?.pushViewController(VC, animated: true)
            
        default:
            return
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = corousalviewCollectionView.dequeueReusableCell(withReuseIdentifier: "CorousalViewCollectionViewCell", for: indexPath) as! CorousalViewCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 600)
    }
    
}
