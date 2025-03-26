//
//  SwiftUIView.swift
//  PhotoGallery
//
//  Created by Admin on 21/3/25.
//

import SwiftUI

struct PhotoView: View {
    let photo: Photo
    
    init(_ photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        if let uiImage = UIImage(contentsOfFile: photo.url.path) {
            
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .clipped()
                .cornerRadius(8)
        }
    }
}

