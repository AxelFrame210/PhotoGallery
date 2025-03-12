//
//  PhotoModel.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import Foundation


struct PhotoModel {
    
    private(set) var photos: Array<Photo> = []
    
    init() {
        for id in 1...15 {
            self.photos.append(Photo(name: "image\(id)"))
        }
    }
       
    func Gallery() -> Array<Photo> {
        return photos
    }
    
    struct Photo {
        let name: String
    }
    
    func viewPhoto(name: String) {
        print("Viewing photo with name: \(name)")
    }
    
}

   
