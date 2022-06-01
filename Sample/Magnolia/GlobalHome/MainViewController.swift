//
//  ViewController.swift
//  Sample
//
//  Created by Ramya K on 19/05/22.
//
import SDWebImage
import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak private var verticalsTableView: UITableView!
    @IBOutlet weak private var corousalviewCollectionView: UICollectionView!
    
    var globalHomeVM = GlobalHomeVM()
    var timer: Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        fetchHeroCorousalsData()
        fetchVerticalsData()
    }
    
    func fetchHeroCorousalsData() {
        globalHomeVM.fetchHeroCorousalData { sucess in
            if sucess {
                DispatchQueue.main.async {
                    self.corousalviewCollectionView.delegate = self
                    self.corousalviewCollectionView.dataSource = self
                    self.corousalviewCollectionView.register(cell: CorousalViewCollectionViewCell.self)
                    self.corousalviewCollectionView.reloadData()
                    self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.slideToNext), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    func fetchVerticalsData() {
        print("pppppp")
        globalHomeVM.fetchVerticalsData { sucess in
            if sucess {
                DispatchQueue.main.async {
                    print("pppppp")
                    self.verticalsTableView.delegate = self
                    self.verticalsTableView.dataSource = self
                    self.verticalsTableView.register(cell: VerticalsTableViewCell.self)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavBar()
    }
    
    private func setUpNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = NavBarTitleEnum.title.rawValue
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontsEnum.TimesNewRoman.rawValue, size: 18)!]
        setUpLeftBarItems()
        setUpRightBarItems()
    }
    
    private func setUpLeftBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ImageLiteralsEnum.closeSymbol.rawValue), style:.done, target: self, action: nil)
    }
    
    private func setUpRightBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageLiteralsEnum.shoppingBag.rawValue), style:.done, target: self, action: nil)
    }
    
    @objc private func slideToNext() {
        if currentCellIndex < globalHomeVM.heroCorousalData.count - 1 {
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
        return RowHeight.globalHomeVertical.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalHomeVM.verticalsDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VerticalsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setCell(imageURL: globalHomeVM.verticalsDataArray[indexPath.row].imagePath, buttonTitle: globalHomeVM.verticalsTitle[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalHomeVM.heroCorousalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CorousalViewCollectionViewCell = corousalviewCollectionView.dequeueReusableCell(for: indexPath)
        
        cell.setProperties(title: self.globalHomeVM.heroCorousalData[indexPath.row].title, imageURl: globalHomeVM.heroCorousalData[indexPath.row].heroCorousalImagePath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 630)
    }
    
}


extension ViewController: verticalsButtonTap {
    
    func verticalsTappedAt(index: Int) {
        switch index {
        case 1:
            let WatchStoryBoard = UIStoryboard(name: StoryBoardIdentifier.watch.rawValue, bundle: Bundle.main)
            guard let VC = WatchStoryBoard.instantiateViewController(identifier: ViewControllerIdentifier.watchTabBarController.rawValue) as? WatchTabBarController
            else {
                return
            }
            self.navigationController?.pushViewController(VC, animated: true)
            
        default:
            return
        }
    }
    
    
}
