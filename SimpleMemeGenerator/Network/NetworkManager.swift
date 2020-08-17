//
//  NetworkManager.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 12.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct NetworkManager {
    
    private let headers = [
        "x-rapidapi-host": "ronreiter-meme-generator.p.rapidapi.com",
        "x-rapidapi-key": "826a856e3emshf09de96a03bd8cdp16c10ejsn55d26b22ec97"
    ]
    
    func getImages(_ completion: @escaping ([String]?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://ronreiter-meme-generator.p.rapidapi.com/images")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            var result: [String]?
            if let error = error {
                print("NetworkManager getImages error: \(error.localizedDescription)")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("NetworkManager getImages response: \(httpResponse.debugDescription)")
                if let data = data,
                    let names = JSON(data).object as? [String] {
                    result = names
                }
            }
            completion(result)
        })
        dataTask.resume()
    }
    
    func generateMeme(_ name: String, topText: String? = " ", bottomText: String? = " ", with completion: @escaping (Data?) -> Void ) {
        
        
        guard var components = URLComponents(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?font=Impact&font_size=20") else { return }
        
        var queryItems = [URLQueryItem(name: "meme", value: name)]
        
        if let topText = topText,
            !topText.isEmpty {
            queryItems.append(URLQueryItem(name: "top", value: topText))
        }
        
        if let bottomText = bottomText,
            !bottomText.isEmpty {
            queryItems.append(URLQueryItem(name: "bottom", value: bottomText))
        }
        
        components.queryItems = queryItems
        
        /*
        let request = NSMutableURLRequest(url: NSURL(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?font=Impact&font_size=50&meme=\(name)&top=\(topText ?? "Top%20text")&bottom=Bottom%20text")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)*/
        
        guard let url = components.url else { return }
        
        print("generateMeme url: \(url.absoluteString)")
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            var result: Data?
            if let error = error {
                print("NetworkManager generateMeme error: \(error.localizedDescription)")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("NetworkManager generateMeme response: \(httpResponse.debugDescription)")
                result = data
//                if let data = data,
//                    let image = UIImage(data: data) {
//                    result = Image(uiImage: image)
//                    print("image: \(image.size)")
//                }
            }
            
            completion(result)
        })
        
        dataTask.resume()
    }
    
    
    
}
