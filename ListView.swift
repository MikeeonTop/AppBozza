//
//  ListView.swift
//  App bozza
//
//  Created by Damiano Rosario  on 03/02/25.
//  Updated by Michele Vassallo on 06/02/25.

import SwiftUI

struct ListView: View {
    @Binding var photos: [Photo]
    
    var body: some View {
        NavigationStack{
            List {
                ForEach($photos, id: \.id) { $photo in
                    NavigationLink(destination: DetailView(photo: $photo, photos: $photos)) {
                        
                        
                        HStack {
                            Image(photo.file)
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 90, height: 90)
                            Text(photo.title)
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Photos")
            .navigationBarTitleDisplayMode(.large)
            .scrollContentBackground(.hidden)
        }
    }
    
    func deleteItem(at offsets: IndexSet){
        photos.remove(atOffsets: offsets)
        save()
    }
    
    func save(){
        do {
            let data = try JSONEncoder().encode(photos)
            UserDefaults.standard.set(data, forKey: "photos")
        } catch {
            print("Unable to save(\(error))")
        }
    }
}
#Preview {
    ListView(photos: .constant([Photo(title: "City Name", file: "city")]))
}
