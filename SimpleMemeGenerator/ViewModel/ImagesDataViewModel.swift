//
//  ImagesDataViewModel.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 12.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import Foundation

class ImagesDataViewModel: ObservableObject {
    
    @Published private(set) var images = [String]()
    
    func getImages() {
        DispatchQueue.global(qos: .userInitiated).async {
            NetworkManager().getImages { [weak self] names in
                print(names ?? [])
                if let names = names {
                    DispatchQueue.main.async {
                        self?.images = names
                    }
                }
            }
        }
    }
    
}
