//
//  ContentView.swift
//  DBZCharacters
//
//  Created by New on 26/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var characterViewModel = CharacterViewModel()
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    @State private var searchWarrior = ""
    
    var filteredWarriors: [CharacterResponse]{
        guard !searchWarrior.isEmpty else{return characterViewModel.characters}
        return characterViewModel.characters.filter{$0.name.localizedCaseInsensitiveContains(searchWarrior)}
    }
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredWarriors, id: \.id){ warrior in
                        NavigationLink {
                            CharacterDetailView(character: warrior, viewModel: CharacterViewModel())
                        }label:{
                            CharacterCellView(dbCharacter: warrior, viewModel: characterViewModel)
                        }
                        .task{
                            if characterViewModel.hasReachedEnd(of: warrior) && !characterViewModel.isFetching{
                                await characterViewModel.fetchNextSetOfWarriors()
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Warriors Z")
            .searchable(text: $searchWarrior,prompt: "Search Warriors Z")
            .onChange(of: searchWarrior) {
                withAnimation{
                    characterViewModel.filterWarriors(name: searchWarrior)
                }
                
            }
           
        }
        
    }
}

#Preview {
    ContentView()
}
