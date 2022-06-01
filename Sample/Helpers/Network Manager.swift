//
//  ReadJSON.swift
//  Sample
//
//  Created by Ramya K on 27/05/22.
//

import Foundation
import UIKit

class NetworkManager  {
    
    
    func readLocalFile(forName name: String) -> Data? {
        //do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try! String(contentsOfFile: bundlePath).data(using: .utf8) {
                print("\(type(of: jsonData))")
                return jsonData
            }
//        } catch {
//            print("fail")
//            print(error)
//        }
        return nil
    }
    
}
