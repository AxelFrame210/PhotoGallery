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
    @Published var errorMessage: String? = nil
    @Published var showErrorView = false
    
    init(getPhotoUseCase: GetPhotoUseCase) {
        self.getPhotoUseCase = getPhotoUseCase
    }
    
    func fetchPhotos() {
        // weak self to prevent retain cycle
        // Background queue for network calls
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            Task {
                do {
                    let results = try await self.getPhotoUseCase.execute()
                    //Main queue for UI update
                    DispatchQueue.main.async {
                        self.photos = results
                    }
                } catch {
                    // All property mutations must happen on main actor if marked
                    await MainActor.run {
                        self.didFailWithError(error)
                        self.showErrorView = true
                    }
                }
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
        self.errorMessage = "Failed to fetch photos: \(error)"
    }
}

// State Obejct vs Observered Object? Can StateObject replace ObservedObject - 
// Swift Package Manager
// SDWebImage
// Favorite Photos Tab: Local Folder, Local Database

// DispatchQueue, weak self, strong self, Multithreading - In Progress
// Combine: Alt for async/await
// Error Handling

