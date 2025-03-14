//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject var viewModel: PhotoGalleryViewModel
    
        var body: some View {
        VStack (alignment: .leading){
            VStack() {
                Text("Gallery")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            ScrollView{
                let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.getPhotos(), id: \.self) { photo in
                        PhotoView(photo.url)
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
}

struct PhotoView: View {
    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let uiImage = UIImage(contentsOfFile: url.path) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            Text("Failed to load image")
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    PhotoGalleryView(viewModel: .init())
}
