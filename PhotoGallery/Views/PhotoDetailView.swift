//
//  PhotoDetailView.swift
//  PhotoGallery
//
//  Created by Admin on 20/3/25.
//

import SwiftUI

struct PhotoDetailView: View {
    private var photo: Photo
    @State private var scale: CGFloat = 1
    @State private var currentScale: CGFloat = 1
    private var minimumScale: CGFloat = 1
    private var maximumScale: CGFloat = 5
    
    init(_ photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                selectedPhoto
            }
            .safeAreaPadding(.vertical)
        }
    }
    
    var magnification: some Gesture {
        
        MagnifyGesture()
            .onChanged { state in
                scale = currentScale * state.magnification
                
            }
            .onEnded { state in
                scale = max(scale, minimumScale)
                scale = min(scale, maximumScale)
                currentScale = scale
            }
    }
    
    var selectedPhoto: some View {
        let uiImage = UIImage(contentsOfFile: photo.url.path)!
        return GeometryReader { geometry in
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .gesture(magnification)
        }
    }
}

