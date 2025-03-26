//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject var photoModel: PhotoGalleryViewModel
    
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack (alignment: .leading){
                    if photoModel.isViewingPhoto == false {
                        Text("Gallery")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        ScrollView{
                            gridView
                        }
                    }
                    else {
                        if let photo = photoModel.photoToView {
                            PhotoDetailView(photo, $photoModel.isViewingPhoto)
                           }
                    }
                }
                .safeAreaPadding(.top)
                .safeAreaPadding(.horizontal)
            }
        }
    
    var gridView: some View {
        let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
        return LazyVGrid(columns: columns, spacing: 8) {
            ForEach(photoModel.getPhotos().indices, id: \.self) { index in
                let photo = photoModel.getPhotos()[index]
                PhotoView(photo)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.3)) {
                            photoModel.viewPhoto(photo)
                        }
                    }
            }
        }
    }
}

#Preview {
    PhotoGalleryView(photoModel: .init())
}
