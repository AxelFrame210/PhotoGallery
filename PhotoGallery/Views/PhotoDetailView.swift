//
//  PhotoDetailView.swift
//  PhotoGallery
//
//  Created by Admin on 20/3/25.
//

import SwiftUI

struct PhotoDetailView: View {
    var photo: Photo
    @Binding var isViewingPhoto: Bool
    
    init(_ photo: Photo, _ isViewingPhoto: Binding<Bool>) {
        self.photo = photo
        self._isViewingPhoto = isViewingPhoto
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack() {
                    dismissButton
                    Spacer()
                }
                
                selectedPhoto
            }
            .safeAreaPadding(.vertical)
        }
    }
    
    var dismissButton: some View {
        return Button(action: {
            withAnimation(.smooth(duration: 0.3)) {
                isViewingPhoto = false
            }
        }) {
            Image(systemName: "arrow.left")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
    }
    
    var selectedPhoto: some View {
        let uiImage = UIImage(contentsOfFile: photo.url.path)!
        
        return GeometryReader { geometry in
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

