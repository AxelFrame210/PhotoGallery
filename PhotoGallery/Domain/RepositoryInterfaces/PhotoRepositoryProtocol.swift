//
//  PhotoRepositoryProtocol.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation


protocol PhotoRepositoryProtocol {
    func getPhotos(atPage page: Int, perPage: Int) async throws -> [Photo]
    func getCachedPhotos(atPage page: Int, perPage: Int) async throws -> [Photo]
}
