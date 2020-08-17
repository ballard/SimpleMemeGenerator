//
//  MemeRowView.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 15.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import SwiftUI
import SwiftUINavigation

struct MemeRowView: View {
    
    @EnvironmentObject var imageLoader: ImageLoader
    
    let imageName: String
    
    var body: some View {
        NavPushButton(destination: MemeView(imageName: imageName).environmentObject(imageLoader)) {
            VStack {
                HStack {
                    self.imageLoader.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    Text(self.imageName)
                }
            }
        }
    }
}
