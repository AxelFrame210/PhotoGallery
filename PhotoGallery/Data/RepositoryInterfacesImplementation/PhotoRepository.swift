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
    
    func getPhotos() async throws -> [Photo] {
        let photoDTOArray = try await remoteDataSource.getPhotos()
    
        return photoDTOArray.map { photoDTO in photoDTO.toDomain() }
    }
    
    func getCachedPhotos() async throws -> [Photo?] {
        var cachedPhotos: [Photo?] = []
        
        for photo in try localDataSource.getPhotos() {
            cachedPhotos.append(photo?.toDomain())
        }
        
        return cachedPhotos
    }
    
    func savePhoto(_ photos: [Photo], at cachedTime: Date?) async throws {
        try localDataSource.savePhotos(photos.map { PhotoLocal.fromDomain($0) }, at: cachedTime)
    }
    
    func getCachedTime() async throws -> Date? {
        return try localDataSource.getCachedTime()
    }
}

