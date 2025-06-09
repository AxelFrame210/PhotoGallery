//
//  PhotoLocalDataSource.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//

import Foundation
import SDWebImage
import SDWebImageSwiftUI

class PhotoLocalDataSource {
    private let userDefaults = UserDefaults.standard
    
    func getCachedPhotos() -> [Photo] {
        if let data = userDefaults.data(forKey: "photos") {
            if let photos = try? JSONDecoder().decode([Photo].self, from: data) {
                return photos
            }
        }
        
        return []
    }
    
    func cachePhotos(photos: [Photo]) throws {
        userDefaults.set(try JSONEncoder().encode(photos), forKey: "photos")
    }
}

// Context: Save URLs to userDefaults to avoid extra netowork requests
// WebImage downloads images and loads from cache auto
// Why do I need to cache URL? I don't
