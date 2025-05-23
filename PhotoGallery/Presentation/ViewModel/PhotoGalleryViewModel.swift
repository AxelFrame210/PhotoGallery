//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation

@MainActor
class PhotoGalleryViewModel: ObservableObject {
    private let getPhotoUseCase: GetPhotoUseCase
    @Published var photos: [Photo] = []
    
    init(getPhotoUseCase: GetPhotoUseCase) {
        self.getPhotoUseCase = getPhotoUseCase
    }
    
    func fetchPhotos() {
        // weak self to prevent retain cycle()
        // Background queue for network calls
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
            guard let self = self else { return }
        
            Task {
                do {
                    let results = try await self.getPhotoUseCase.execute()
                    //Main queue for UI update
                    DispatchQueue.main.async {
                        self.photos = results
                    }
                    
                } catch {
                    return
                }
            }
        }
    }
}

// State Obejct vs Observered Object? Can StateObject replace ObservedObject - 
// Swift Package Manager
// SDWebImage
// Favorite Photos Tab: Local Folder, Local Database

// DispatchQueue, weak self, strong self, Multithreading - In Progress
// Combine: Alt for async/await
// Error Handling

