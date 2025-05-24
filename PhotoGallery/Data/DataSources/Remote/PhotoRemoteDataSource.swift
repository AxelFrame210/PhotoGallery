//
//  PhotoRemoteDataSource.swift
//  PhotoGallery
//
//  Created by Admin on 9/4/25.
//
import Foundation
import SDWebImage
import SDWebImageSwiftUI

class PhotoRemoteDataSource {
    private let apiKey = "t7q1TcFc5gW33gFnwVBV626jorD2E4kRuK_YxRwuqKA"
    private let baseURL = "https://api.unsplash.com/photos"
    
    func getPhotos() async throws -> [PhotoResponseDTO] {
        let perPage = 20
        let endpoint = "\(baseURL)?per_page=\(perPage)&client_id=\(apiKey)"
         
        
        guard let url = URL(string: endpoint) else {
            throw PhotoError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw PhotoError.httpError(statusCode: statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let photos = try decoder.decode([PhotoResponseDTO].self, from: data)
            return photos
        } catch {
            throw PhotoError.decodingError
        }
    }
}

enum PhotoError: Error {
    case urlError
    case decodingError
    case httpError(statusCode: Int)
}

