//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation

class PhotoGalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    
    init() {
        getPhotos()
    }
    
    private func loadPhotos() -> [Photo] {
        let imageExtensions = ["jpg", "jpeg", "png"]
        guard let bundlePath = Bundle.main.resourcePath else {
            print("Failed to get Bundle path")
            return []
        }

        do {
            let filePaths = try FileManager.default.contentsOfDirectory(atPath: bundlePath)
            let filteredURLs = filePaths.compactMap { file in
                let fileURL = URL(fileURLWithPath: bundlePath).appendingPathComponent(file)
                return imageExtensions.contains(fileURL.pathExtension) ? fileURL : nil
            }
            
            return filteredURLs.map { Photo(url: $0) }
        } catch let error {
            print("\(error)")
            return []
        }
    }
    
    func getPhotos() {
        self.photos = loadPhotos()
    }
}
