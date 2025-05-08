//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation


class PhotoGalleryViewModel: ObservableObject {
    private let getPhotoUseCase: GetPhotoUseCase
   @Published var photos: [Photo] = []
    
    init(getPhotoUseCase: GetPhotoUseCase) {
        self.getPhotoUseCase = getPhotoUseCase
    }
    
    @MainActor
    func fetchtPhotos() {
        Task {
            do {
            
                let result = try await getPhotoUseCase.execute()
                photos = Array(Set(result))
            } catch {
                print(error)
            }
        }
    }
}

