//
//  MemeView.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 15.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import SwiftUI
import SwiftUINavigation

struct MemeView: View {
    
    @EnvironmentObject var imageLoader: ImageLoader
    
    @State private var topText = " "
    @State private var bottomText = " "
    @State private var image = Image(systemName: "eye.slash")
    @State private var showShareSheet = false
    @State var uiImage: UIImage?
    
    var imageName: String
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text("Top text")
                        .padding()
                    
                    TextField("Top text", text: $topText, onEditingChanged: { (success) in
                        //
                    }, onCommit: {
                        print("commit top \(self.topText)")
                        self.loadImage()
                    })
                    .padding()
                }
                
                Divider()
                
                self.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .padding()
                
                Divider()
                
                HStack(alignment: .center) {
                    TextField("Bottom text", text: $bottomText, onEditingChanged: { (success) in
                        //
                    }, onCommit: {
                        print("commit bottom")
                        self.loadImage()
                        })
                    .padding()
                }
                Spacer()
            }
            .navigationBarTitle(imageName)
            .navigationBarItems(leading: BackNavigationItem(), trailing: Button(action: {
                self.showShareSheet = true
            }, label: {
                Image(systemName: "square.and.arrow.up")
            }))
        }
        .onAppear {
            self.loadImage()
            
            
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [self.uiImage ?? UIImage()])
        }
    }
    
    private func loadImage() {
        NetworkManager().generateMeme(self.imageName, topText: self.topText, bottomText: self.bottomText) { data in
            if let data = data,
                let uiImage = UIImage(data: data)
            {
                self.uiImage = uiImage
                self.image = Image(uiImage: uiImage)
            }
        }
    }
    
    private func share() {
        self.showShareSheet = true
    }
}
