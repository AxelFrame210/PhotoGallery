//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation

class PhotoGalleryViewModel: ObservableObject {
    @Published private var photoModel = PhotoModel(urls)
    private static var urls: [URL] = {
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
            
            return filteredURLs
        } catch let error {
            print(" Error loading files from the app bundle: \(error)")
            return []
        }
    }()
    
    func getPhotos() -> [Photo] {
        return photoModel.photos
    }
    
    func viewPhoto() {
        
    }
}
