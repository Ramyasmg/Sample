//
//  GlobalHomeDataModel.swift
//  Sample
//
//  Created by Ramya K on 27/05/22.
//

import Foundation

struct GlobalHomeData: Codable {
    let meta: Meta
    let data: Data1
}

struct Meta: Codable {
    let apiVersion: String
    let runtimeEnv: String
    let servedFromCache: Bool
}

struct Data1: Codable {
    let curation : Curation
    
}

struct Curation: Codable {
    let id: String
    let title: String
    let description: String
    let packages: [Package]
}

struct Package: Codable {
    let packageType: String
    let items: [Items]
}

struct Items: Codable {
    let contentType: String
    let source: Source
}

struct Source: Codable {
    //let id: String
    let type: String
    let title: String
    let description: String
    let image: Image
}

struct Image: Codable {
    let url: String
}

struct HeroCorousalData {
    let title: String
    let description: String
    let heroCorousalImagePath: String
}

struct verticalsData {
    let title: String
    let imagePath: String
}
