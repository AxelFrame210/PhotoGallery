//
//  PhotoLocal.swift
//  PhotoGallery
//
//  Created by Admin on 14/4/25.
//
import Foundation

struct PhotoLocal: Codable {
    let photoId : String
    let photoUrl : URL
    let authorName : String
    let authorProfileUrl : URL
    let isFavorite : Bool
   
    func toDomain() -> Photo {
        return Photo(
            photoId: photoId,
            photoUrl: photoUrl,
            authorName: authorName,
            authorProfileUrl: authorProfileUrl,
            isFavorite: isFavorite
        )
    }
    
    static func fromDomain(_ domain: Photo) -> PhotoLocal {
        return PhotoLocal(
            photoId: domain.photoId,
            photoUrl: domain.photoUrl,
            authorName: domain.authorName,
            authorProfileUrl: domain.authorProfileUrl
            ,isFavorite: domain.isFavorite
        )
    }
}
