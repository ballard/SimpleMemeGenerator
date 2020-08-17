//
//  PhotoCaptureView.swift
//  SimpleMemeGenerator
//
//  Created by Иван Лазарев on 17.08.2020.
//  Copyright © 2020 Cloudike. All rights reserved.
//

import SwiftUI

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var image: Image?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
}

struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), image: .constant(Image("")))
    }
}
