//
//  Pokemon.swift
//  Pokedex_SwiftUI
//
//  Created by Otis on 2024/9/13.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Float
    let weight: Float
    let types: [PokemonTypeEntry]
    let sprites: PokemonSprites
    
    struct PokemonTypeEntry: Decodable {
        let type: PokemonType
    }
    
    struct PokemonType: Decodable {
        let name: String
    }
    
    struct PokemonSprites: Decodable {
        let other: OtherSprites
    }
    
    struct OtherSprites: Decodable {
        let home: HomeSprites
    }
    
    struct HomeSprites: Decodable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
