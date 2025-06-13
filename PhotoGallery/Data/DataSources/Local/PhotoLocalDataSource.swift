//
//  PhotoLocalDataSource.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//

import Foundation

class PhotoLocalDataSource {
    private let userDefaults = UserDefaults.standard
    private let cachedKey = "cachedPhotos"
    private let favoriteKey = "favoritePhotos"
    
    func getCachedPhotos() throws -> [Photo] {
        if let data = userDefaults.data(forKey: cachedKey) {
            if let photos = try? JSONDecoder().decode([Photo].self, from: data) {
                return photos
            }
        }
        
        return []
    }
     
    func cachePhotos(photos: [Photo]) throws {
        userDefaults.set(try JSONEncoder().encode(photos), forKey: cachedKey)
    }
    
    func saveFavorite(photoID: String) throws {
        
    }
    
    func removeFavorite(photoID: String) throws {
        
    }
    
    func getFavoritePhotos() throws -> [Photo] {
        return []
    }
}

// Context: Save URLs to userDefaults to avoid extra netowork requests
// WebImage downloads images and loads from cache auto
// Why do I need to cache URL? I don't
