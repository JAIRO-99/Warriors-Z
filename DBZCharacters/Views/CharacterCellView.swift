//
//  CharacterCellView.swift
//  DBZCharacters
//
//  Created by New on 27/03/24.
//

import SwiftUI

struct CharacterCellView: View {
    
    let dbCharacter: CharacterResponse
    @StateObject var viewModel: CharacterViewModel
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(.purple)
                .cornerRadius(25)
                .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.black ,lineWidth: 1)
                )
            
            VStack{
                ImageCharacterView(url: dbCharacter.image, width: 90, height: 170)
                
                Text(dbCharacter.name)
                    .font(.headline)
                    .shadow(radius: 10)
                    .foregroundColor(.black)
                    
            }
            .padding()
        }
    }
}

#Preview {
    CharacterCellView(dbCharacter: ExampleModelData.example[0], viewModel: CharacterViewModel())
}
