//
//  PokemonModel.swift
//  PokedexApp
//
//  Created by Lautaro Galan on 15/05/2023.
//

import Foundation

struct Pokemon: Decodable, Identifiable{
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}
