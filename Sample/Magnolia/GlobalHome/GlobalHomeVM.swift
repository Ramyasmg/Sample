//
//  GlobalHomeVM.swift
//  Sample
//
//  Created by Ramya K on 27/05/22.
//

import Foundation
import UIKit

class GlobalHomeVM {
    
    let networkManager = NetworkManager()
    
    var heroCorousalData: [HeroCorousalData] = []
    
    var verticalsDataArray: [verticalsData] = []
    
    var verticalsTitle = ["S H O P", "W A T C H", "W O R K S H O P", "V I S I T", "B L O G"]
    
    private var heroCorousalImagesDictionary = NSCache<NSString, NSData>()
    private var verticalsImagesDictionary = NSCache<NSString, NSData>()
    
    private func readJsonFile() -> GlobalHomeData? {
        guard  let data = networkManager.readLocalFile(forName: JsonFiles.GlobalHomeJsonData.rawValue) else { return nil }
        let decodedData = try? JSONDecoder().decode(GlobalHomeData.self,
                                                    from: data)
        if let decodedData = decodedData {
            return decodedData
        }
        else {
            return nil
        }
    }
    
    func fetchHeroCorousalData(completion: @escaping(_ sucess: Bool)-> Void) {
        guard let decodedData = readJsonFile() else  { return }
        
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
    
    func fetchVerticalsData(completion: @escaping(_ sucess: Bool)-> Void) {
        guard let decodedData = readJsonFile()  else { return }
        let packages = decodedData.data.curation.packages
        for pkg in packages {
            if pkg.packageType == "subNav" {
                for item in pkg.items {
                    verticalsDataArray.append(verticalsData(title: item.source.title, imagePath: item.source.image.url))
                    print(self.verticalsDataArray)
                    print(pkg.items.count)
                }
            }
        }
        completion(true)
    }
}













//    func fetchImages(imageURL: String,completion: @escaping(_ image: UIImage)-> Void) {
//guard let imageURL = URL(string: imageURL) else { return }
//
//if let imageData = heroCorousalImagesDictionary.object(forKey: imageURL.absoluteString as NSString) {
//    print("using cached images")
//    if let image = UIImage(data: imageData as Data) {
//        completion(image)
//    }
//    return
//}
//
//networkManager.getImage(from: imageURL) { data in
//    self.heroCorousalImagesDictionary.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
//    print("cache-- \(self.heroCorousalImagesDictionary)")
//    if let image = UIImage(data: data) {
//        completion(image)
//    }
//}
//}
