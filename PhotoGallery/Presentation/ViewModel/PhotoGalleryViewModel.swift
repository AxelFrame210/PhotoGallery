//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation


class PhotoGalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private let getPhotoUseCase: GetPhotoUseCase
    
    
    init(getPhotoUseCase: GetPhotoUseCase) {
        self.getPhotoUseCase = getPhotoUseCase
    }

    func getPhotos() {
        Task { @MainActor in
            do {
                photos = try await loadPhotos()
            } catch {
                throw error
            }
        }
    }
}

