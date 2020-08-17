//
//  PhotoPickerButtonView.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 17.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import SwiftUI

struct PhotoPickerButtonView: View {
    
    var didTapButton: (() -> Void)?
    
    var body: some View {
        VStack {
            Button(action: {
                self.didTapButton?()
            }) {
                Image(systemName: "camera.circle.fill")
                .resizable()
                .scaledToFit()
            }
        }
    }
}
