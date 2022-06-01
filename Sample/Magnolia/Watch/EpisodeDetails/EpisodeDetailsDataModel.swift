//
//  EpisodeDetailsDataModel.swift
//  Sample
//
//  Created by Ramya K on 30/05/22.
//

import UIKit

struct EpisodeDetailsData: Codable {
    let data: SubEpisodeDetailsData
}

struct SubEpisodeDetailsData: Codable {
    let curation : EpisodeDetailsCuration
}

struct EpisodeDetailsCuration: Codable {
    let id: String
    let title: String
    let packages: [EpisodeDetailsPackage]
}

struct EpisodeDetailsPackage: Codable {
    let packageType: String
    let items: [EpisodeDetailsItems]
}

struct EpisodeDetailsItems: Codable {
    let id: String
    let contentType: String
    let source: EpisodeDetailsSource
}

struct EpisodeDetailsSource: Codable {
    let id: String
    let type: String
    let title: String
    let description: String
    let image: EpisodeDetailsImage
    let number: String
    let seasonNumber: String
    let tvRating: String
    //let nextEpisode: NextEpisode
    let show: ShowDetails
    let duration: Duration
}

struct ShowDetails: Codable {
    let id: String
    let title: String
    let seasons: [Seasons]
}

struct Seasons: Codable {
    let id: String
    let number: String
    let episodes: [Episode]
}


struct Episode: Codable {
    let id : String
    let title: String
    let description: String
    let image: SeasonEpisodeImage
    let number: String
    let seasonNumber: String
    let tvRating: String
    let video: EpisodeVideo
    //let duration: EpisodesDuration
}

struct EpisodeVideo: Codable {
    let duration: VideoDuration
}

struct VideoDuration: Codable {
    let seconds: Int
    let formatted: String
}

struct SeasonEpisodeImage: Codable {
    let url: String
}


struct Duration: Codable {
    let seconds: Int
    let formatted: String
}

struct EpisodeDetailsImage: Codable {
    let url: String
}

struct NextEpisode: Codable {
    let id: String
    let type: String
    let title: String
    let description: String
    let number: String
    let seasonNumber: String
    let tvRating: String
    let duration: String?
    let image: String?
}


struct EpisodeDetilasHeaderData {
    let videoUrl: String?
    let imageUrl: String?
    let showTitle: String
    let episodeTitle: String
    let seasonEpisodeNumber: String
    let description: String
    let duration: String
    
}

struct EpisodeDetailShelfData {
    let imageURL: String
    let seasonEpisodeNumber: String
    let episodeTitle: String
    let duration: Int
    let showTitle: String
    let description: String
}


