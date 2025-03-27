//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject var photoGalleryVM: PhotoGalleryViewModel
    
    var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack (alignment: .leading){
                    if photoGalleryVM.isViewingPhoto == false {
                        Text("Gallery")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        ScrollView{
                            gridView
                        }
                    }
                    else {
                        if let photo = photoGalleryVM.photoToView {
                            PhotoDetailView(photo, $photoGalleryVM.isViewingPhoto)
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
            ForEach(photoGalleryVM.photos.indices, id: \.self) { index in
                let photo = photoGalleryVM.photos[index]
                PhotoView(photo)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.3)) {
                            photoGalleryVM.viewPhoto(photo)
                        }
                    }
            }
        }
    }
}

#Preview {
    PhotoGalleryView(photoGalleryVM: .init())
}
