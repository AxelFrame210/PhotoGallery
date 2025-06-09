//
//  PhotoRepository.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation

class PhotoRepository: PhotoRepositoryProtocol {
    private let remoteDataSource: PhotoRemoteDataSource
    private let localDataSource: PhotoLocalDataSource

    init (remoteDataSource: PhotoRemoteDataSource, localDataSource: PhotoLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getFreshPhotos() async throws -> [Photo] {
        let photoDTOArray = try await remoteDataSource.fetchPhotos()
    
        return photoDTOArray.map { photoDTO in photoDTO.toDomain() }
    }
    
    func getLocalPhotos() -> [Photo] {
        var cachedPhotos: [Photo] = []
        
        for photo in localDataSource.getCachedPhotos() {
            cachedPhotos.append(photo)
        }
        
        return cachedPhotos
    }
    
    func cachePhotosToLocal(photos: [Photo]) throws {
        try localDataSource.cachePhotos(photos: photos)
    }
    
}

