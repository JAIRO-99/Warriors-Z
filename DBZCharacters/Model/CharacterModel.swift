//
//  CharacterModel.swift
//  DBZCharacters
//
//  Created by New on 26/03/24.
//

import Foundation


struct DBZModel: Codable{
    let items: [CharacterResponse]
    let meta : Meta
}

struct CharacterResponse: Codable, Identifiable{
    
    let id: Int
    let name: String
    let ki: String
    let maxKi: String
    let race: String
    let gender: Gender
    let description: String
    let image: String
    let affiliation: String
    
   // let originPlanet: PlanetOfOrigin
   // let transformations: [TransformationsCharacter]
    
    static let example = CharacterResponse(id: 1, name: "Goku", ki: "60.000.000", maxKi: "90 Septillion", race: "Saiyan", gender: .male, description: "El protagonista de la serie, conocido por su gran poder y personalidad amigable. Originalmente enviado a la Tierra como un infante volador con la misión de conquistarla. Sin embargo, el caer por un barranco le proporcionó un brutal golpe que si bien casi lo mata, este alteró su memoria y anuló todos los instintos violentos de su especie, lo que lo hizo crecer con un corazón puro y bondadoso, pero conservando todos los poderes de su raza. No obstante, en la nueva continuidad de Dragon Ball se establece que él fue enviado por sus padres a la Tierra con el objetivo de sobrevivir a toda costa a la destrucción de su planeta por parte de Freeza. Más tarde, Kakarot, ahora conocido como Son Goku, se convertiría en el príncipe consorte del monte Fry-pan y líder de los Guerreros Z, así como el mayor defensor de la Tierra y del Universo 7, logrando mantenerlos a salvo de la destrucción en innumerables ocasiones, a pesar de no considerarse a sí mismo como un héroe o salvador.", image: "https://res.cloudinary.com/dgtgbyo76/image/upload/v1699044374/hlpy6q013uw3itl5jzic.webp", affiliation: "Z Fighter")
}




enum Gender: String, Codable{
    case female = "Female"
    case male = "Male"
}

struct PlanetOfOrigin: Codable, Identifiable{
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
    var deleteAt: String?
}

struct TransformationsCharacter: Codable, Identifiable{
    var id: Int
    var name: String
    var image: String
    var ki: String
    var deleteAt: String?
}

struct Meta: Codable{
    let totalItems, itemCount, itemsPerPage, totalPages: Int
    let currentPage: Int
}
