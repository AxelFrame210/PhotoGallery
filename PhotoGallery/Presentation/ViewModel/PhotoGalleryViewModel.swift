//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation

@MainActor
class PhotoGalleryViewModel: ObservableObject {
    private let getPhotoUseCase: GetPhotoUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    
    @Published var photos: [Photo] = []
    @Published var error: Error? = nil
    @Published var isRefreshing = true
    @Published var favoritePhotos: [Photo] = []
    
    init(getPhotoUseCase: GetPhotoUseCase, toggleFavoriteUseCase: ToggleFavoriteUseCase) {
        self.getPhotoUseCase = getPhotoUseCase
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
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
    
    func togglePhotoFavorite(_ photoID: String) {
        do {
               try toggleFavoriteUseCase.toggleFavorite(for: photoID)
               
               // Update in-memory copy so UI reacts
               if let index = photos.firstIndex(where: { $0.photoId == photoID }) {
                   photos[index].isFavorite.toggle()
               }
           } catch {
               print("Toggle favorite failed: \(error)")
           }
    }
    
    func getFavoritePhotos() {
        if photos.isEmpty == false {
            self.favoritePhotos = photos.filter{ $0.isFavorite == true }
            
            print("Get Favs")
        }
    }
}


