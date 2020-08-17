//
//  ContentView.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 15.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import SwiftUI
import SwiftUINavigation

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ImagesDataViewModel
    @State private var selection: Int = 0
    
    var body: some View {
        NavControllerView(transition: .custom(.moveAndFadeIn, .moveAndFafeOut)) {
            MemesFeedView()
//            TabView(selection: self.$selection) {
//                MemesFeedView()
//                    .tag(0)
//                    .tabItem {
//                        VStack {
//                            Text("Store")
//                            Image(systemName: "flame.fill")
//                        }
//                }
//
//                MemesFeedView()
//                    .tag(1)
//                    .tabItem {
//                        VStack {
//                            Text("Upload")
//                            Image(systemName: "flame")
//                        }
//                }
//            }
        }
    }
}
