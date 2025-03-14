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
    
    init(_ urls: [URL]) {
        self.photos = {() -> [Photo] in for url in urls {
            photos.append(Photo(url: url))
        }
            return photos
        }()
    }

    func viewPhoto() {
      
    }
}






   
