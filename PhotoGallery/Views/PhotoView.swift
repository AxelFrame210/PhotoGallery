//
//  SwiftUIView.swift
//  PhotoGallery
//
//  Created by Admin on 21/3/25.
//

import SwiftUI

struct PhotoView: View {
    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let uiImage = UIImage(contentsOfFile: url.path) {
            
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .clipped()
                .cornerRadius(8)
        }
    }
}
