//
//  PhotoRepositoryProtocol.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation

protocol PhotoRepositoryProtocol {
    func getFreshPhotos() async throws -> [Photo]
    
    func getLocalPhotos() throws -> [Photo]

    func cachePhotosToLocal( photos: [Photo]) throws
    
    func addPhotoToFavorite(photo: Photo) throws
}
