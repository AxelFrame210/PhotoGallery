//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation

class PhotoGalleryViewModel: ObservableObject{
    @Published private var photoModel = PhotoModel(urls)
    private static var urls: [URL] = {
        let imageExtensions = ["jpg", "jpeg", "png"]
        guard let bundlePath = Bundle.main.resourcePath else {
            print("Error: Cannot access app bundle resource path!")
            return []
        }

        do {
            let filePaths = try FileManager.default.contentsOfDirectory(atPath: bundlePath)

            let filteredURLs = filePaths.compactMap { fileName -> URL? in
                let fileURL = URL(fileURLWithPath: bundlePath).appendingPathComponent(fileName)
                return imageExtensions.contains(fileURL.pathExtension.lowercased()) ? fileURL : nil
            }
            print("Found \(filteredURLs.count) image files in the app bundle")
            return filteredURLs
        } catch {
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
