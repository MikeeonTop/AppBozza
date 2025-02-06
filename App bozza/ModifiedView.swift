//
//  ModifiedView.swift
//  App bozza
//
//  Created by Damiano Rosario  on 03/02/25.
//  Updated by Michele Vassallo on 06/02/25.

import SwiftUI

struct ModifiedView: View {
    @Binding var photos: [Photo]
    
    var body: some View {
        
        
        NavigationStack{
            List($photos, id: \.id) { $photo in
                if !photo.original {
                    
                    NavigationLink(destination: DetailView(photo: $photo, photos: $photos)) {
                        
                        HStack {
                            Image(photo.file)
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 90, height: 90)
                                .colorMultiply(Color(red: photo.multiplyRed, green: photo.multiplyGreen, blue: photo.multiplyBlue))
                                .saturation(photo.saturation!)
                                .contrast(photo.contrast!)

                            Text(photo.title)
                            
                        }
                    }
                }
            }
            
            .navigationTitle("Modified")
            .navigationBarTitleDisplayMode(.large)
            .scrollContentBackground(.hidden)
        }
    }
}
#Preview {
    ModifiedView(photos: .constant([Photo(title: "City Name", file: "city")]))
}
