//
//  PokemonManager.swift
//  PokedexApp
//
//  Created by Lautaro Galan on 15/05/2023.
//

import Foundation

// MARK: - Pokemon Delegate
protocol PokemonManagerDelegate{
    func showPokemonList(list: [Pokemon])
}

// MARK: - Pokemon Manager
struct PokemonManager{
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemonList(){
        let UrlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: UrlString){
            let session = URLSession(configuration: .default)
            // Using a completion handler to throw data, response or error messages
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                
                // Error
                if let error = error {
                    print("Error fetching Pokemons: \(error.localizedDescription)")
                }
                
                //Showcasing the pokemon list with a feature to remove 'null' out of the JSON list
                if let safeData = data?.parseData(removeString: "null,"){
                    if let pokemonList = self.parseJSON(pokemonData: safeData){
                        //print("Pokemon list: ", pokemonList)
                        delegate?.showPokemonList(list: pokemonList)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJSON(pokemonData: Data) -> [Pokemon]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Pokemon].self, from: pokemonData)
            return decodedData
            
        } catch {
            print("Error decoding data. \(error.localizedDescription)")
            return nil
        }
    }
}

//Removes the 'null' string that appears on the JSON list

extension Data {
    func parseData(removeString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
