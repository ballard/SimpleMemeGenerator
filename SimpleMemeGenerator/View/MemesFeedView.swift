//
//  ContentView.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 12.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import SwiftUI
import SwiftUINavigation

// TODO: search memes
// TODO: upload own meme from callery
// TODO: take a shot from camera

typealias MemeFeedCache = NSCache<NSString, UIImage>

struct MemesFeedView: View {
    
    @EnvironmentObject var viewModel: ImagesDataViewModel
    @State private var searchText : String = ""
    
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = nil
    
    let memeCache = MemeFeedCache()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBar(text: self.$searchText, placeholder: "Search memes")
                    List(self.viewModel.images.filter({
                        self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
                    })) { image in
                        MemeRowView(imageName: image)
                            .environmentObject(ImageLoader(name: image, cache: self.memeCache))
                            .frame(height: 60)
                    }
                    .id(UUID())
                }
                PhotoPickerButtonView(didTapButton: {
                    self.showImagePicker = true
                })
                    .frame(width: 60, height: 60, alignment: .trailing)
                    .offset(x: 150, y: 300)
            }
            .navigationBarTitle("Simple Meme Generator")
            .sheet(isPresented: self.$showImagePicker){
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
            }
        }.onAppear {
            print("MemesFeedView: on appear")
            self.viewModel.getImages()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemesFeedView()
    }
}
