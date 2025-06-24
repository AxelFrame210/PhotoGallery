//
//  GridView.swift
//  PhotoGallery
//
//  Created by Admin on 16/6/25.
//

import SwiftUI

struct GridView: View {
    var photoList: [Photo]

    var body: some View {
        let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
        return LazyVGrid(columns: columns, spacing: 8) {
            ForEach(photoList, id: \.photoId) { photo in
                NavigationLink(destination: PhotoDetailView(photo.photoId)) {
                    PhotoView(photo: photo)
                }
            }
        }
    }
}
