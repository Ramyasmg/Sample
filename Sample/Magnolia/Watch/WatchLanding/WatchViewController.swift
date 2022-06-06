//
//  WatchViewController.swift
//  Sample
//
//  Created by Ramya K on 23/05/22.
//

import UIKit

final class WatchViewController: UIViewController {
    
    @IBOutlet weak private var headerCollectionView: UICollectionView!
    @IBOutlet weak private var episodesTableView: UITableView!
    
    var watchHomeVM = WatchHomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        fetchHeroCorusalData()
        fetchShelfData()
    }
    
    private func fetchHeroCorusalData() {
        watchHomeVM.fetchHeroCorousalData { [weak self] sucess in
            if sucess {
                DispatchQueue.main.async {
                    self?.headerCollectionView.delegate = self
                    self?.headerCollectionView.dataSource = self
                    self?.headerCollectionView.register(cell: WatchHeaderCVCell.self)
                    self?.headerCollectionView.reloadData()
                }
            }
        }
    }
    
    private func fetchShelfData() {
        watchHomeVM.loadShelfData() {
            [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.episodesTableView.delegate = self
                    self?.episodesTableView.dataSource = self
                    self?.episodesTableView.register(cell: EpisodesTableViewCell.self)
                    self?.episodesTableView.reloadData()
                }
            }
        }
    }
    
}


extension WatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RowHeight.watchHomeShelf.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchHomeVM.shelfs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EpisodesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setTitle(title: watchHomeVM.shelfs[indexPath.row].headerTitle, showsArray: watchHomeVM.shelfs[indexPath.row].shows)
        cell.delegate = self
        return cell
    }
    
}


extension WatchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchHomeVM.heroCorousalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WatchHeaderCVCell = headerCollectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        let data = watchHomeVM.heroCorousalData[indexPath.row]
        cell.setProperties(imageURL: data.heroCorousalImagePath, title: data.title, description: data.description)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 600)
    }
    
}


extension WatchViewController: EpisodeDetails {
    
    func showEpisodeDetails(title: String?) {
        let WatchStoryBoard = UIStoryboard(name: StoryBoardIdentifier.watch.rawValue, bundle: Bundle.main)
        guard let VC = WatchStoryBoard.instantiateViewController(identifier:ViewControllerIdentifier.episodesDetailVC.rawValue) as? EpisodesDetailVC
        else {
            return
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

