//
//  ToggleFavoriteUseCase.swift
//  PhotoGallery
//
//  Created by Admin on 13/6/25.
//

import Foundation

class ToggleFavoriteUseCase {
    private let photoRepository: PhotoRepositoryProtocol
    
    init(photoRepository: PhotoRepositoryProtocol) {
        self.photoRepository = photoRepository
    }
    
    func toggleFavorite(for photoID: String) throws {
            try photoRepository.toggleFavorite(for: photoID)
    }
}
