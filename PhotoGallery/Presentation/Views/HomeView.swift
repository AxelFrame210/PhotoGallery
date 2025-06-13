//
//  HomeView.swift
//  PhotoGallery
//
//  Created by Admin on 10/6/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var photoGalleryVM: PhotoGalleryViewModel
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Gallery")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView{
                gridView
            }
            .refreshable {
                await photoGalleryVM.refresh()
                print(photoGalleryVM.isRefreshing)
            }
        }
        .background(Color(.black))
        .safeAreaPadding(.top)
        .safeAreaPadding(.horizontal)
        .onAppear {
            if photoGalleryVM.photos.isEmpty {
                photoGalleryVM.fetchPhotos()
            }
        }
    }
    
    var gridView: some View {
        let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
        return LazyVGrid(columns: columns, spacing: 8) {
            ForEach(photoGalleryVM.photos, id: \.photoId) { photo in
                NavigationLink(destination: PhotoDetailView(photo)) {
                    PhotoView(photo: photo)
                }.id(photo.photoId)
            }
        }
    }
}

