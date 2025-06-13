//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject var photoGalleryVM: PhotoGalleryViewModel
    @State private var selection: GalleryTab = .home
    
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            
            NavigationStack {
                TabView(selection: $selection) {
                    Tab("Home", systemImage: "house.fill", value: .home) {
                        HomeView()
                            .toolbarBackground(.visible, for: .tabBar)
                            .toolbarBackground(Color.black, for: .tabBar)
                    }

                    Tab("Favorite", systemImage: "star.fill", value: .favorite) {
                        FavoritePhotosView()
                            .toolbarBackground(.visible, for: .tabBar)
                            .toolbarBackground(Color.black, for: .tabBar)
                    }
                }
            }.environmentObject(photoGalleryVM)
        }
    }

    enum GalleryTab {
        case home
        case favorite
    }
}

