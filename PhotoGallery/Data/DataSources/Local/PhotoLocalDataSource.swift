//
//  PhotoLocalDataSource.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//

import Foundation

class PhotoLocalDataSource {
    private let userDefaults = UserDefaults.standard
    private var cacheKeys: [String] = []

    func getPhotos() throws -> [PhotoLocal?] {
       return try cacheKeys.map { key in
           guard let data = userDefaults.data(forKey: key) else { return nil }
           
           return try JSONDecoder().decode(PhotoLocal?.self, from: data)
        }
    }
    
    func savePhotos(_ photos: [PhotoLocal], at cachedTime: Date?) throws {
        // cache photos
        for photo in photos {
            cacheKeys.append("photo_\(photo.photoId)")
            let data = try JSONEncoder().encode(photo)
            userDefaults.set(data, forKey: "photo_\(photo.photoId)")
        }
        
        //cache time
        userDefaults.set(cachedTime, forKey: "lastCachedTime")
    }
    
    func getCachedTime() throws -> Date? {
        guard let cachedTime =  userDefaults.data(forKey: "lastCachedTime") else { return nil }
        return try JSONDecoder().decode(Date?.self, from: cachedTime)
    }
}
