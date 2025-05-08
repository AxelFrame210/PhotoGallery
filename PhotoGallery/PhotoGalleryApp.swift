//
//  PhotoGalleryApp.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

@main
struct PhotoGalleryApp: App {
    let dependencies: DependencyContainer = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            PhotoGalleryView(photoGalleryVM: dependencies.makePhotoGalleryViewModel())
        }
    }
}
