//
//  PhotoRemoteDataSource.swift
//  PhotoGallery
//
//  Created by Admin on 9/4/25.
//
import Foundation

class PhotoRemoteDataSource {
    private let apiKey = "t7q1TcFc5gW33gFnwVBV626jorD2E4kRuK_YxRwuqKA"
    private let baseURL = "https://api.unsplash.com/photos"
    
    func getPhotos(atPage pageNumber: Int, perPage: Int) async throws -> [PhotoResponseDTO] {
        let endpoint = "\(baseURL)?page=\(pageNumber)&per_page=\(perPage)&client_id=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            throw ImageError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw ImageError.httpError(statusCode: statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let photos = try decoder.decode([PhotoResponseDTO].self, from: data)
            return photos
        } catch {
            throw ImageError.decodingError
        }
    }
}

enum ImageError: Error {
    case urlError
    case decodingError
    case httpError(statusCode: Int)
}
