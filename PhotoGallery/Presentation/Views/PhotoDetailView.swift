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
    
    @State private var currentIndex: Int
    @State private var scale: CGFloat = 1
    @State private var currentScale: CGFloat = 1
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var isZoomedIn: Bool = false
    @GestureState private var isDragging = false
    
    private var minimumScale: CGFloat = 1
    private var maximumScale: CGFloat = 5
    
    
    init(currentIndex: Int) {
        self.currentIndex = currentIndex
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                selectedPhoto
            }
            .safeAreaPadding()
        }.navigationBarTitleDisplayMode(.inline)
    }
    
    var tapMagnification: some Gesture {
        TapGesture(count: 2)
            .onEnded { _ in
                if currentScale == 1 {
                    scale = 2.5
                    isZoomedIn = true
                } else {
                    scale = 1
                }
                
                currentScale = scale
            }
    }
    
    var pinchMagnification: some Gesture {
        MagnifyGesture()
            .onChanged { state in
                scale = currentScale * state.magnification
                isZoomedIn = true
            }
            .onEnded { state in
                scale = max(scale, minimumScale)
                scale = min(scale, maximumScale)
                currentScale = scale
                
                if currentScale == 1 {
                    isZoomedIn = false
                }
            }
    }
    
    func swipeGesture(geometry: GeometryProxy) -> some Gesture {
        return DragGesture()
            .onEnded() { value in
                let horizontalAmount = value.translation.width
                
                let contentWidth = geometry.size.width * currentScale
                let isZoomedIn = currentScale > 1
                let maxOffsetX = (contentWidth - geometry.size.width) / 2
                
                let atLeftEdge = offset.width >= maxOffsetX - 10
                let atRightEdge = offset.width <= -maxOffsetX + 10
                
                if !isZoomedIn || atRightEdge || atLeftEdge {
                    if horizontalAmount < -50 {
                        goToNextPhoto()
                    } else if horizontalAmount > 50 {
                        goToPreviousPhoto()
                    }
                }
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
            GeometryReader { geometry in
                let photo = self.photoGalleryVM.photos[self.currentIndex]
                
                WebImage(url: photo.photoUrl) { image in
                    image.image?.resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .offset(offset)
                        .frame(minWidth: geometry.size.width, minHeight: geometry.size.height - 50, maxHeight: geometry.size.height)
                        .applyGestures(tapMagnification, pinchMagnification)
                        .simultaneousGesture(dragMagnification)
                        .simultaneousGesture(swipeGesture(geometry: geometry))
                        .animation(.easeInOut(duration: 0.2), value: scale)
                        .animation(.easeInOut(duration: 0.2), value: offset)
                    
                }.favoriteOverlay(isFavorite: photo.isFavorite, action: { photoGalleryVM.togglePhotoFavorite(photo.photoId)
                })
                .id(photo.photoId)
            }
        }
    }
    
    func goToNextPhoto() {
        if currentIndex < photoGalleryVM.photos.count - 1 {
            currentIndex += 1
            resetTransform()
        }
    }
    
    func goToPreviousPhoto() {
        if currentIndex > 0 {
            currentIndex -= 1
            resetTransform()
        }
    }
    
    func resetTransform() {
        scale = 1
        offset = .zero
    }
}

extension View {
    func applyGestures(_ tapMagnification: some Gesture, _ pinchMagnification: some Gesture) -> some View {
        self.gesture(tapMagnification)
            .simultaneousGesture(pinchMagnification)
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


