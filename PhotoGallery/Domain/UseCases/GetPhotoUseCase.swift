//
//  GetPhotoUseCase.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//

import Foundation

class GetPhotoUseCase {
    private let photoRepository: PhotoRepositoryProtocol
    
    init(photoRepository: PhotoRepositoryProtocol) {
        self.photoRepository = photoRepository
    }
    
    func execute(forceFresh: Bool) async throws -> [Photo] {
        //if user refresh, get fresh photos
        if forceFresh == true {
            let freshPhotos =  try await photoRepository.getFreshPhotos()
            
            // save fresh photos to local
            do {
                try photoRepository.cachePhotosToLocal(photos: freshPhotos)
            } catch {
                print("Error saving fresh photos to cache: \(error)")
            }
            
            return freshPhotos
        }
        
        if let localPhotos = try? photoRepository.getLocalPhotos() {
            return localPhotos
        }
        
        return []
    }
    
}

// SDWeb cache images auto
// Fetch image logic: Fetch 20 images from 1 page, page is updated with new images
// Current fetch new images logic(temp): user reloads gallery view --> udpate
