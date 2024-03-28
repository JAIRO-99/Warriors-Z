//
//  CharacterDetailView.swift
//  DBZCharacters
//
//  Created by New on 26/03/24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @State private var isAnimating = false
    
    let character: CharacterResponse
    
    @StateObject var viewModel: CharacterViewModel
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    ZStack{
                        VStack{
                            ImageCharacterView(url: character.image, width: 150, height: 300)
                                .shadow(radius: 12)
                                .scaleEffect(isAnimating ? 1.1 : 0.7)
                                .padding(.top,20)
                                
                                
                                
                                ScrollView(.horizontal){
                                   
                                    //Vista de transformaciones
                                }
                            }
                        }
                    Text(character.race)
                    
                    Text(character.description)
                        .padding()
                }
                
            }
            .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation {
                    isAnimating = true
                }
            }
        }
        }
    }
}

#Preview {
    CharacterDetailView(character: CharacterResponse.example, viewModel: CharacterViewModel())
}
