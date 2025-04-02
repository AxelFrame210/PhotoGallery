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
        AsyncImage(url: photo.urls.raw) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .clipped()
                    .cornerRadius(8)

            case .failure:
                ProgressView()
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

