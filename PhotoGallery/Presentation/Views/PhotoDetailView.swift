//
//  PhotoDetailView.swift
//  PhotoGallery
//
//  Created by Admin on 20/3/25.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImage

struct PhotoDetailView: View {
    @State private var scale: CGFloat = 1
    @State private var currentScale: CGFloat = 1
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    private var photo: Photo
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

    var dragMagnification: some Gesture {
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
        return GeometryReader { geometry in
            WebImage(url: photo.photoUrl) { image in
                image.image?.resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .gesture(tapMagnification)
                    .gesture(pinchMagnification)
                    .gesture(dragMagnification)
            }
        }
    }
}

