//
//  Photo.swift
//  PhotoGallery
//
//  Created by Admin on 11/4/25.
//

import Foundation

struct Photo: Codable {
    let photoId : String
    let photoUrl : URL
    let authorName : String
    let authorProfileUrl : URL
}
