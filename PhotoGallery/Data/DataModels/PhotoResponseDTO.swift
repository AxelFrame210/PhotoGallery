//
//  PhotoResponseDTO.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation

struct PhotoResponseDTO: Decodable {
    let id: String
    let imageUrls: URLSDTO
    let user: AuthorDTO
    let links: LinksDTO
    
    struct URLSDTO: Decodable {
        let regularImage: URL
        let small: URL
        let thumb: URL
        
        enum CodingKeys: String, CodingKey {
            case regularImage = "regular"
            case small
            case thumb
        }
    }
    
    struct AuthorDTO: Decodable {
        let id: String
        let username: String
        let name: String
    }
    
    struct LinksDTO: Decodable {
        let html: URL
    }
    
    func toDomain() -> Photo {
        return Photo(
            photoId: id,
            photoUrl: imageUrls.regularImage,
            authorName: user.name,
            authorProfileUrl: links.html
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrls = "urls"
        case user
        case links
        
    }
}


