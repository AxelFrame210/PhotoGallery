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
        AsyncImage(url: photo.urls.regular) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .clipped()
                    .cornerRadius(8)

            case .failure:
                CustomProgressview()
            case .empty:
                CustomProgressview()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct CustomProgressview: View {
    var body: some View {
        let rec = Rectangle().clipShape(RoundedRectangle(cornerRadius: 8))
        rec.scaledToFill().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .foregroundStyle(.gray)
    }
}

