//
//  PhotoUIModel.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.


import Foundation

struct PhotoUIModel: Hashable, Identifiable, Codable, Equatable {
    let id: String
    let urls: PhotoURLS
}

struct PhotoURLS: Codable, Equatable, Hashable {
    let raw: URL
    let small: URL
    let thumb: URL
    let regular: URL
}
