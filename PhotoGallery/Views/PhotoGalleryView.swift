//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct PhotoGalleryView: View {
    var model: PhotoModel
    
        var body: some View {
        VStack(alignment: .leading) {
            
            VStack (){
                
                Text("Gallery")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
            }
            ScrollView{
                
                let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(model.Gallery().indices, id: \.self) {index in
                        PhotoView(model.Gallery()[index]) // type Photo
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .clipped()
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .background(.black)
    }
    
    struct PhotoView: View {
        let photo: PhotoModel.Photo // Type PhotoModel.Photo
        init(_ photo: PhotoModel.Photo) {
            self.photo = photo
        }
        var body: some View {
            Image(photo.name)
                .resizable()
        }
        
    }
}

#Preview {
    PhotoGalleryView(model: PhotoModel.init())
}
