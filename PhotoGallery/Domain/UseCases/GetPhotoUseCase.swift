//
//  GetPhotoUseCase.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//

class GetPhotoUseCase {
    private let photoRepository: PhotoRepository
    
    init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }
}
