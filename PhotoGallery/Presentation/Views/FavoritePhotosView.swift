//
//  FavoritePhotosView.swift
//  PhotoGallery
//
//  Created by Admin on 9/6/25.
//

import SwiftUI

struct FavoritePhotosView: View {
    @EnvironmentObject var photoGalleryVM: PhotoGalleryViewModel
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Favorites")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView{
                GridView(photoList: photoGalleryVM.favoritePhotos)
            }
        }
        .background(Color(.black))
        .safeAreaPadding(.top)
        .safeAreaPadding(.horizontal)
        .onAppear {
                photoGalleryVM.getFavoritePhotos()
        }
    }
}
