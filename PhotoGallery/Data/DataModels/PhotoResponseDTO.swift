//
//  PhotoResponseDTO.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation

struct PhotoResponseDTO: Decodable {
    let id: String
    let urls: URLSDTO
    let user: AuthorDTO
    let links: LinksDTO
    
    struct URLSDTO: Codable {
        let regular: URL
        let small: URL
        let thumb: URL
    }
    
    struct AuthorDTO: Codable {
        let id: String
        let username: String
        let name: String
    }
    
    struct LinksDTO: Codable {
        let html: URL
    }
    
    func toDomain() -> Photo {
        return Photo(
            photoId: id,
            photoUrl: urls.regular,
            authorName: user.name,
            authorProfileUrl: links.html
        )
    }
}
