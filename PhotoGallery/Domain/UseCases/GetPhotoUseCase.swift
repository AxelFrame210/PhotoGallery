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
        
        func execute(forceFresh: Bool = false) async throws -> [Photo] {
            if forceFresh == false {
                if let cachedTime = try await photoRepository.getCachedTime() {
                    if Date().timeIntervalSince(cachedTime) < 3600 {
                        return try await photoRepository.getCachedPhotos().compactMap { $0 }
                    }
                }
            }
            
            let freshPhotos = try await photoRepository.getPhotos()
            try await photoRepository.savePhoto(freshPhotos, at: Date())
            return freshPhotos
        }
    }

