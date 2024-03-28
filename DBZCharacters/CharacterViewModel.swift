//
//  CharacterViewModel.swift
//  DBZCharacters
//
//  Created by New on 26/03/24.
//

import Foundation

class CharacterViewModel: ObservableObject{
    
    @Published var characters: [CharacterResponse] = []
    @Published var filterCharacter : [CharacterResponse] = []
    @Published private (set) var viewState: ViewState?
    
    var isLoading: Bool{
        viewState == .loading
    }
    
    var isFetching: Bool{
       viewState == .fetching
    }
    
    
    
    private let service = NetworkAPI.shared
    
    private var page = 1
    private var totalPages: Int?
    
    init (){
        getListOfCharacters()
    }
    
    
    func getListOfCharacters(){
        
        viewState = .loading
        defer {viewState = .finished}
        service.getCharacter(numberPage: page) { [weak self] result in //weak self para evitar retain circles
            DispatchQueue.main.async{
                switch result {
                case .success(let result):
                    self?.totalPages = result.meta.totalPages
                    self?.characters = result.items
                case .failure(let error):
                    print("Debug: \(error)")
                }
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfWarriors() async {
        guard page != totalPages else {return}
        viewState = .fetching
        defer {viewState = .finished}
        
        page += 1
        service.getCharacter(numberPage: page) { result in //weak self para evitar retain circles
            DispatchQueue.main.async{
                switch result {
                case .success(let result):
                  
                    self.characters.append(contentsOf: result.items)
                case .failure(let error):
                    print("Debug: \(error)")
                }
            }
        }
        
    }
    
    func hasReachedEnd(of warrior: CharacterResponse) -> Bool{
        characters.last?.id == warrior.id
    }
    func filterWarriors(name: String){
        if name.isEmpty{
            filterCharacter = characters
        }else{
           filterCharacter = characters.filter({ warrior in
                warrior.name.lowercased().contains(name.lowercased())
            })
        }
    }
    
}

extension CharacterViewModel{
    enum ViewState{
        case fetching
        case loading
        case finished
    }
}
