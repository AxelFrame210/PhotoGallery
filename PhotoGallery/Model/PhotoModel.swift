//
//  PhotoModel.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.


import Foundation

struct Photo: Hashable {
    let url: URL
}

struct PhotoModel {
    private(set) var photos: [Photo] = []
    
    init(_ photos: [Photo]) {
        self.photos = photos
    }

    func viewPhoto() {
      
    }
}



   
