//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Admin on 11/3/25.
//

import SwiftUI

struct ContentView: View {
        var body: some View {
        VStack(alignment: .leading) {
            
            VStack (){
                
                Text("Gallery").font(.largeTitle).fontWeight(.bold)
                
            }
            ScrollView{
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                    ForEach(0..<10, id: \.self) {_ in
                        image().aspectRatio(contentMode: .fit)
                            .frame(minWidth: 100, minHeight: 100)
                            
                        
                    }
                }
            }
        }
        .padding()
    }
    
    struct image: View {
        var body: some View {
            Image("Image1")
                .cornerRadius(8)
                .scaledToFit()
                
            
        }
        
    }
}

#Preview {
    ContentView()
}
