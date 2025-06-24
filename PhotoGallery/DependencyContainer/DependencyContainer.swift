//
//  DependencyContainer.swift
//  PhotoGallery
//
//  Created by Admin on 7/5/25.
//

import Foundation

class DependencyContainer {
    lazy var photoRemoteDataSource = PhotoRemoteDataSource()
    lazy var photoLocalDataSource = PhotoLocalDataSource()
    
    // MARK: - Repository
    lazy var photoRepository: PhotoRepositoryProtocol = PhotoRepository(
        remoteDataSource: photoRemoteDataSource,
        localDataSource: photoLocalDataSource
    )
    
    // MARK: - UseCase
    lazy var getPhotoUseCase = GetPhotoUseCase(
        photoRepository: photoRepository
    )
    
    lazy var toggleFavoriteUseCase = ToggleFavoriteUseCase(
        photoRepository: photoRepository
    )
    
    // MARK: - ViewModel
    @MainActor func makePhotoGalleryViewModel() -> PhotoGalleryViewModel {
        return PhotoGalleryViewModel(getPhotoUseCase: getPhotoUseCase, toggleFavoriteUseCase: toggleFavoriteUseCase)
    }
}
