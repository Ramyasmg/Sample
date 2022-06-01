//
//  EpisodeDetailsVM.swift
//  Sample
//
//  Created by Ramya K on 30/05/22.
//


import Foundation
import UIKit
import AVFoundation

class EpisodeDetailVM {
    
    let networkManager = NetworkManager()
    var episodeHeaderData: [EpisodeDetilasHeaderData] = []
    var episodesShelfData: [EpisodeDetailShelfData] = []
    
    private func readEpisodeDetailsJson() -> EpisodeDetailsData? {
        guard  let data = networkManager.readLocalFile(forName: "EpisodeDetailsJsonData") else {
            print("error in reading json")
            return  nil }
        let decodedData = try? JSONDecoder().decode(EpisodeDetailsData.self,
                                                    from: data)
        if let decodedData = decodedData {
            
            return decodedData
        }
        else {
            return nil
        }
        
    }
    
    func fetchData(completion: @escaping(_ sucess: Bool)-> Void) {
        
        guard let data = readEpisodeDetailsJson() else { return
            print("error in parsing data")
        }
        let pkg = data.data.curation.packages[0]
        let item = pkg.items[0].source
        let imageUrl = item.image.url
        let showTitle = item.show.title
        let episodeTitle = item.title
        let seasonEpisodeNumber = "S\(item.seasonNumber) E \(item.number)"
        let description = item.description
        let duration = item.duration.formatted
        let durationInSeconds = item.duration.seconds
        
        episodeHeaderData.append(EpisodeDetilasHeaderData(videoUrl: nil, imageUrl: imageUrl, showTitle: showTitle, episodeTitle: episodeTitle, seasonEpisodeNumber: seasonEpisodeNumber, description: description, duration: duration))
        
        let seasons = item.show.seasons[0]
        let episodes = seasons.episodes
        
        for episode in episodes {
            let imageUrl = episode.image.url
            let seasonEpisodeNumber = "S\(episode.seasonNumber) E\(episode.number)"
            let episodeTitle = episode.title
            let duration = episode.video.duration.seconds
            let showTitle = item.show.title
            let description = episode.description
            
            episodesShelfData.append(EpisodeDetailShelfData(imageURL: imageUrl, seasonEpisodeNumber: seasonEpisodeNumber, episodeTitle: episodeTitle, duration: duration, showTitle: showTitle, description: episode.description))
        }
        completion(true)
    }
    
}
