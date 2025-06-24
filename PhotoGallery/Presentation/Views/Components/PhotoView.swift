//
//  SwiftUIView.swift
//  PhotoGallery
//
//  Created by Admin on 21/3/25.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct PhotoView: View {
    let photo: Photo
    
    var body: some View {
        WebImage(url: photo.photoUrl) { image in
            image.image?
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .clipped()
                .cornerRadius(8)
        }
        .onSuccess { _,_,_ in
            
        }
        .onFailure { error in
            print(error)
        }
    }
}

//struct CustomProgressview: View {
//    var body: some View {
//        let rec = Rectangle().clipShape(RoundedRectangle(cornerRadius: 8))
//        rec.scaledToFill().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//            .foregroundStyle(.gray)
//    }
//}

