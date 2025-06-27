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
                if let index = photoList.firstIndex(of: photo) {
                    NavigationLink(destination: PhotoDetailView(currentIndex: index)) {
                        PhotoView(photo: photo)
                    }
                }
            }
        }
    }
}
