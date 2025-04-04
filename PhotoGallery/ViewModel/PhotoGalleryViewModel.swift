//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Admin on 12/3/25.


import Foundation

class PhotoGalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private let session: URLSession
    
    init() {
        let memoryCapacity = 4 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, directory: nil)
        URLCache.shared = urlCache
        
        let config = URLSessionConfiguration.default
        config.urlCache = urlCache
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.timeoutIntervalForRequest = 5
        
        self.session = URLSession(configuration: config)
        
        getPhotos()
    }
    
    private func loadPhotos(page: Int = 1, perPage: Int = 20) async throws -> [Photo] {
        let endpoint = "https://api.unsplash.com/photos?page=\(page)&per_page=\(perPage)&client_id=t7q1TcFc5gW33gFnwVBV626jorD2E4kRuK_YxRwuqKA"
        
        guard let url = URL(string: endpoint) else {
            throw ImageError.urlError
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw ImageError.httpError(statusCode: statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let photos = try decoder.decode([Photo].self, from: data)
            return photos
        } catch {
            throw ImageError.decodingError
        }
    }
    
    func getPhotos() {
        Task {
            do {
                self.photos = try await loadPhotos()
            } catch {
                throw error
            }
        }
    }
}

enum ImageError: Error {
    case urlError
    case decodingError
    case httpError(statusCode: Int)
}
