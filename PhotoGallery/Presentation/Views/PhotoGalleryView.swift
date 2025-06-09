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
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack (alignment: .leading){
                    Text("Gallery")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    if !photoGalleryVM.showErrorView {
                        ScrollView{
                            gridView
                        }
                        .refreshable {
                           await photoGalleryVM.refresh()
                        }
                    }
                }
                .safeAreaPadding(.top)
                .safeAreaPadding(.horizontal)
                .onAppear {
                    if photoGalleryVM.photos.isEmpty {
                        photoGalleryVM.fetchPhotos()
                    }
                }
            }
        }
    }
    
    var gridView: some View {
        let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
        return LazyVGrid(columns: columns, spacing: 8) {
            ForEach(photoGalleryVM.photos, id: \.photoId) { photo in
                NavigationLink(destination: PhotoDetailView(photo)) {
                    PhotoView(photo: photo)
                }
                .id(photo.photoId)
            }
        }
    }
}


