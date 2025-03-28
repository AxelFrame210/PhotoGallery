//
//  PhotoDetailView.swift
//  PhotoGallery
//
//  Created by Admin on 20/3/25.
//

import SwiftUI

struct PhotoDetailView: View {
    var photo: Photo
    
    init(_ photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                selectedPhoto
            }
            .safeAreaPadding(.vertical)
        }
    }
    
    var selectedPhoto: some View {
        let uiImage = UIImage(contentsOfFile: photo.url.path)!
        return GeometryReader { geometry in
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

