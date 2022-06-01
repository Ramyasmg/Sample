//
//  WatchHomeDataModel.swift
//  Sample
//
//  Created by Ramya K on 28/05/22.
//

import Foundation
import UIKit

struct WatchHomeData: Codable {
    let data: SubWatchHomeData
}

struct SubWatchHomeData: Codable {
    let curation : WatchHomeCuration
}

struct WatchHomeCuration: Codable {
    let id: String
    let title: String
    let description: String
    let packages: [WatchHomePackage]
}

struct WatchHomePackage: Codable {
    let packageType: String
    let items: [WatchHomeItems]
    let options: WatchOptions
}

struct WatchHomeItems: Codable {
    let contentType: String
    let source: WatchHomeSource
}

struct WatchHomeSource: Codable {
    let id: String
    let type: String
    let title: String
    let description: String
    let image: WatchHomeImage
    let showImages: ShowImages?
}

struct ShowImages: Codable {
    let chipVertical: ChipVertical
}

struct ChipVertical: Codable {
    let url: String
}

struct WatchHomeNextUserEpisode: Codable {
    let id: String
    let type: String
    let title: String
    let description: String
    let image: WatchHomeNextUserEpisodeImage
    let show: WatchHomeShow
    let number: String
    let seasonNumber: String
    let duration: WatchHomeShowDuration
    let tvRating: String
}
struct WatchHomeShowDuration: Codable {
    let seconds: String
    let formatted: String
}

struct WatchHomeShow: Codable {
    let id: String
    let type: String
    let title: String
}

struct WatchHomeNextUserEpisodeImage: Codable {
    let url: String
}

struct WatchHomeImage: Codable {
    let url: String
}

struct WatchOptions: Codable {
    let title: String
}

struct Shelf {
    let headerTitle: String
    let shows: [Show]
}

struct Show {
    let id: String
    let showTitle: String
    let showDescription: String
    let imagePath: String
    var image: UIImage?
}
