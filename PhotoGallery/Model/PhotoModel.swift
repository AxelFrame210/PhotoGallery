//
//  PhotoModel.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.


import Foundation

struct Photo: Hashable, Identifiable {
    let url: URL
    let id: UUID = UUID()
}


