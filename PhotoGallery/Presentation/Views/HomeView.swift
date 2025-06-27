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
                GridView(photoList: photoGalleryVM.photos)
            }
            .refreshable {
                await photoGalleryVM.refresh()
                print(photoGalleryVM.isRefreshing)
            }
        }
        .background(Color(.black))
        .safeAreaPadding()
        .onAppear {
            if self.photoGalleryVM.photos.isEmpty {
                self.photoGalleryVM.fetchPhotos()
            }
        }
    }
}

