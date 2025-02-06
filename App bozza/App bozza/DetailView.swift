//
//  DetailView.swift
//  App bozza
//
//  Created by Damiano Rosario  on 03/02/25.
//  Updated by Michele Vassallo on 06/02/25.

import SwiftUI

struct DetailView: View {
    @Binding var photo: Photo
    @Binding var photos: [Photo]
    @State private var multiplyRed = 1.0
    @State private var multiplyGreen = 1.0
    @State private var multiplyBlue = 1.0
    @State private var saturation = 1.0
    @State private var contrast = 1.0
    
    @State private var image: Image?
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Title", text: $photo.title)
                    .font(.system(size:30))
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .colorMultiply(Color(red: multiplyRed, green: multiplyGreen, blue: multiplyBlue))
                        .saturation(saturation)
                        .contrast(contrast)
                }
                
                HStack {
                    Button(action: {
                        multiplyRed = 1
                        multiplyBlue = 0
                        multiplyGreen = 0
                    }) {
                        Image("flower")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .colorMultiply(.red)
                    }.padding()
                    
                    Button(action: {
                        multiplyRed = 0
                        multiplyBlue = 0
                        multiplyGreen = 1
                    }) {
                        Image("flower")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .colorMultiply(.green)
                    }.padding()
                    
                    Button(action: {
                        multiplyRed = 0
                        multiplyBlue = 1
                        multiplyGreen = 0
                    }) {
                        Image("flower")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .colorMultiply(.blue)
                    }.padding()
                    
                    Button(action: {
                        multiplyRed = 1
                        multiplyBlue = 1
                        multiplyGreen = 1
                    }) {
                        Image("flower")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }.padding(10)
                    
                }
                VStack {
                    Text("Saturation")
                    Slider(value: $saturation, in: -5...7)
                        .padding(5)
                        .accentColor(.gray)
                    
                    Text("Contrast")
                    Slider(value: $contrast, in:-5...7)
                        .padding(5)
                        .accentColor(.gray)
                }
                HStack {
                    Button(action: {
                        contrast = 1.0
                        saturation = 1.0
                    }) {
                        Image(systemName: "gobackward")
                            .foregroundColor(.black)
                            .font(.system(size: 30))
                    }.padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    if photo.original{
                        let title: String = "\(photo.title)-\(Int.random(in: 1000000...9999999))"
                        let modifiedPhoto = Photo(title: title, file: photo.file, multiplyRed: multiplyRed,
                                                  multiplyGreen: multiplyGreen, multiplyBlue: multiplyBlue, saturation: saturation, contrast: contrast, original: false)
                        photos.append(modifiedPhoto)
                    }else{
                        photo.multiplyRed = multiplyRed
                        photo.multiplyGreen = multiplyGreen
                        photo.multiplyBlue = multiplyBlue
                        photo.saturation = saturation
                        photo.contrast = contrast
                    }
                    save()
                }, label: {
                    Text ("Save")
                })
            }
        }
        .onAppear{
            image = Image(photo.file)
            
            self.multiplyRed = photo.multiplyRed
            self.multiplyGreen = photo.multiplyGreen
            self.multiplyBlue = photo.multiplyBlue
            
            if let contrast = photo.contrast{
                self.contrast = contrast
            }
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
    DetailView(photo: .constant(Photo(title: "city Name", file: "city")),
               photos: .constant([Photo(title: "city Name", file: "city")]))
}
