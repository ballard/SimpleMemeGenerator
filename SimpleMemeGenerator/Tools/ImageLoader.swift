//
//  ImageLoader.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 12.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image = Image(systemName: "eye.slash")
    
    var cache: MemeFeedCache

    init(name: String, cache: MemeFeedCache) {
        self.cache = cache
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let cachedImage = self?.cache.object(forKey: name as NSString) {
                DispatchQueue.main.async {
                    self?.image = Image(uiImage: cachedImage)
                }
            } else {
                NetworkManager().generateMeme(name) {data in
                    if let data = data,
                        let uiImage = UIImage(data: data) {
                        self?.cache.setObject(uiImage, forKey: name as NSString)
                        DispatchQueue.main.async {
                            self?.image = Image(uiImage: uiImage)
                        }
                    }
                }
            }
        }
    }
}
