//
//  WatchHomeVM.swift
//  Sample
//
//  Created by Ramya K on 28/05/22.
//

import Foundation
import UIKit

class WatchHomeVM {
    
    let networkManager = NetworkManager()
    var heroCorousalData: [HeroCorousalData] = []
    var shows: [Show] = []
    var shelfs: [Shelf] = []
    
    func fetchHeroCorousalData(completion: @escaping(_ sucess: Bool)-> Void) {
        guard let decodedData = readWatchHomeJson() else  { return }
        
        let packages = decodedData.data.curation.packages
        for pkg in packages {
            if pkg.packageType == "heroCarousel" {
                for item in pkg.items {
                    self.heroCorousalData.append(HeroCorousalData(title: item.source.title, description: item.source.description, heroCorousalImagePath: item.source.image.url))
                }
            }
        }
        completion(true)
    }
    
    
    private func readWatchHomeJson() -> WatchHomeData? {
        guard  let data = networkManager.readLocalFile(forName: JsonFiles.WatchHomeJsonFile.rawValue) else { return nil }
        let decodedData = try? JSONDecoder().decode(WatchHomeData.self,
                                                    from: data)
        if let decodedData = decodedData {

            return decodedData
        }
        else {
            return nil
        }
        
    }
    
    
    func loadShelfData(completion: @escaping(_ sucess: Bool)-> Void) {
        guard let watchHomeData = readWatchHomeJson() else  { return }
        for pkg in watchHomeData.data.curation.packages {
            if pkg.packageType == "shelf" {
                for item in pkg.items {
                    self.shows.append(Show(id: item.source.id, showTitle: item.source.title, showDescription: item.source.description, imagePath:
                                            item.source.showImages?.chipVertical.url ??   item.source.image.url, image: nil))
                    
                    print("3333\(item.source.showImages?.chipVertical.url)")
                }
                let shelf = Shelf(headerTitle: pkg.options.title, shows: shows)
                shelfs.append(shelf)
                shows.removeAll()
            }
        }
        if shelfs.count == watchHomeData.data.curation.packages.count-1 {
            completion(true)
        }
    }
    
}




