//
//  PhotoDetailView.swift
//  PhotoGallery
//
//  Created by Admin on 20/3/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotoDetailView: View {
    @EnvironmentObject var photoGalleryVM: PhotoGalleryViewModel
    
    @State private var scale: CGFloat = 1
    @State private var currentScale: CGFloat = 1
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    private var photoId: String
    private var minimumScale: CGFloat = 1
    private var maximumScale: CGFloat = 5
    
    init(_ photoId: String) {
        self.photoId = photoId
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                selectedPhoto
            }
            .safeAreaPadding(.vertical)
        }.navigationTitle(Text("Gallery"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var tapMagnification: some Gesture {
        TapGesture(count: 2)
            .onEnded { _ in
                scale = currentScale == 1 ? 2.5 : 1
                currentScale = scale
            }
    }
    
    var pinchMagnification: some Gesture {
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

   public var dragMagnification: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = CGSize(
                    width: lastOffset.width + value.translation.width,
                    height: lastOffset.height + value.translation.height
                )
            }
            .onEnded { _ in
                lastOffset = offset
            }
    }
    
    var selectedPhoto: some View {
        ZStack {
            if let photo = photoGalleryVM.photos.first(where: { $0.photoId == self.photoId}) {
                GeometryReader { geometry in
                    WebImage(url: photo.photoUrl) { image in
                        image.image?.resizable()
                            .scaledToFit()
                            .scaleEffect(scale)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .applyGestures(tapMagnification, pinchMagnification, dragMagnification)
                           
                    }.favoriteOverlay(isFavorite: photo.isFavorite, action: { photoGalleryVM.togglePhotoFavorite(self.photoId)
                        print(photo.isFavorite)
                    }
                        
                    )
                }
            }
            
        }
    }
}

extension View {
    func applyGestures(_ tapMagnification: some Gesture, _ pinchMagnification: some Gesture, _ dragMagnification: some Gesture) -> some View {
        self.gesture(tapMagnification)
            .gesture(pinchMagnification)
            .gesture(dragMagnification)
    }
}

extension View {
    func favoriteOverlay(isFavorite: Bool, action: @escaping () -> Void) -> some View {
        self.overlay(alignment: .topTrailing) {
            Button(action: action) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.yellow)
                    .padding(8)
            }
        }
    }
}


