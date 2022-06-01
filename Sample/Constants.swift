//
//  Constants.swift
//  Sample
//
//  Created by Ramya K on 31/05/22.
//

import UIKit

enum RowHeight: CGFloat {
    case globalHomeVertical = 200
    case watchHomeShelf = 310
}


enum ViewControllerIdentifier: String {
    case watchTabBarController = "WatchTabBarController"
    case episodesDetailVC = "EpisodesDetailVC"
}

enum StoryBoardIdentifier: String {
    case Main = "Main"
    case shop = "Shop"
    case watch = "Watch"
}

enum UrlString: String {
    case videoUrl = "https://dplus-northamerica-cloudfront-s3.prod-vod.h264.io/158b/3aba/8589/e2389659-27ec-4237-bbb6-2869d83e6664/ts-raw/x-discovery-token=Expires=1654160177&KeyName=primary&Signature=myjORRftUi0EEGLMsqEiNCuhlrI/master.m3u8"
}

enum FontsEnum: String {
    case TimesNewRoman = "Times New Roman"
    case TimesNewRomanBold = "Times New Roman Bold"
}

enum ImageLiteralsEnum: String {
    case shoppingBag = "shoppingbag"
    case closeSymbol = "multiply"
    case pauseSymbol = "pause"
    case playSymbol = "play"
    case goforwardSymbol = "goforward"
    case gobackwardSymbol = "gobackward"
    case enterFullScreenSymbol = "camera.metering.center.weighted.average"
    case thumbImageSymbol = "circlebadge.fill"
    
}

//enum UrlEnum : String {
//    case video = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
//}

enum NavBarTitleEnum: String {
    case title = "M A G N O L I A"
}
