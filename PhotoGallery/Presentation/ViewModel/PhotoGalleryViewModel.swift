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
    @Published var error: Error? = nil
    @Published var isRefreshing = false
    @Published var favoritePhotos: [Photo] = []
    
    init(getPhotoUseCase: GetPhotoUseCase) {
        self.getPhotoUseCase = getPhotoUseCase
    }
    
    func fetchPhotos() {
        //Checks object value preventing crash
        //On background
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard self != nil else { return }
        }
        
        Task {
            do {
                let results = try await self.getPhotoUseCase.execute(forceFresh: isRefreshing)
                await MainActor.run {
                    self.photos = results
                }
            } catch {
                print("Failed to fetch photos: \(error)")
            }
        }
    }
    
    func refresh() async {
        isRefreshing = true
        fetchPhotos()
        isRefreshing = false
    }
    
    func saveToFavorites(_ photo: Photo) {
        
    }
}

// State Obejct vs Observered Object? Can StateObject replace ObservedObject - 
// Swift Package Manager
// SDWebImage
// Favorite Photos Tab: Local Folder, Local Database

// DispatchQueue, weak self, strong self, Multithreading - In Progress
// Combine: Alt for async/await
// Error Handling

