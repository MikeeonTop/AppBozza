//
//  ContentView.swift
//  App bozza
//
//  Created by Damiano Rosario  on 03/02/25.
//  Updated by Michele Vassallo on 06/02/25.

import SwiftUI

struct ContentView: View {
    @State var photos = [Photo(title: "Bari", file: "bari"), Photo(title: "Firenze", file: "firenze"), Photo(title: "Genova", file: "genova"),Photo(title: "Palermo", file: "palermo"), Photo(title: "Roma", file: "roma"), Photo(title: "Napoli", file: "napoli")]
    
    @State var selection: Int = 0
    
    var body: some View {
    TabView(selection: $selection) {
                ListView(photos: $photos)
            .tabItem {
                Label("Photos", systemImage: "photo")
                    .accentColor(.primary)
            }
            .tag(0) //Add tag for TabView selection
        
        ModifiedView(photos: $photos)
            .tabItem {
                Label("Modified", systemImage: "camera.filters")
                    .accentColor(.primary)
            }
            .tag(1)
    } .onAppear() {
        if let data = UserDefaults.standard.data(forKey: "photos") {
            do {
                let decoder = JSONDecoder()
                let p = try decoder.decode([Photo].self, from: data)
                photos = p
            } catch {
                print("Unable to decode (\(error))")
            }
        }
    }
        }
    }


struct Photo: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var file: String
    var multiplyRed = 1.0
    var multiplyGreen = 1.0
    var multiplyBlue = 1.0
    var saturation: Double?
    var contrast: Double?
    var original = true
}

#Preview {
    ContentView()
}
