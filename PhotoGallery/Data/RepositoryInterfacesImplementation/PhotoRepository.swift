//
//  PhotoRepository.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation

class PhotoRepository: PhotoRepositoryProtocol {
    let remoteDataSource: PhotoRemoteDataSource
    
    init (remoteDataSource: PhotoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getPhotos(atPage page: Int, perPage: Int) async throws -> [Photo] {
        let photoDTOArray = try await remoteDataSource.getPhotos(atPage: page, perPage: perPage)
    
        return photoDTOArray.map { photoDTO in photoDTO.toDomain() }
    }
    
    func getCachedPhotos(atPage page: Int, perPage: Int) async throws -> [Photo] {
        return []
    }
}
