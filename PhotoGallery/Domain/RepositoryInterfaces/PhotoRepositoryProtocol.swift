//
//  PhotoRepositoryProtocol.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation


protocol PhotoRepositoryProtocol {
    func getPhotos() async throws -> [Photo]
    
    func getCachedPhotos() async throws -> [Photo?]
    
    func savePhoto(_ photos: [Photo], at cachedTime: Date?) async throws
    
    func getCachedTime() async throws -> Date?
}
