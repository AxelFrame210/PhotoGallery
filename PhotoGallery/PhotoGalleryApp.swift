//
//  PhotoGalleryApp.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

@main
struct PhotoGalleryApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoGalleryView(viewModel: .init())
        }
    }
}
