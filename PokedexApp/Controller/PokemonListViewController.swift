//
//  ViewController.swift
//  PokedexApp
//
//  Created by Lautaro Galan on 15/05/2023.
//

import UIKit

class PokemonListViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    // MARK: - Variables
    var pokemonManager = PokemonManager()
    
    var pokemons: [Pokemon] = []
    
    var selectedPokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Register new table cell
        
        pokemonTableView.register(UINib(nibName: "PokemonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")
        
        pokemonManager.delegate = self
        
        pokemonTableView.delegate = self
        
        //To handle the information of the table
        pokemonTableView.dataSource = self
        
        //Execute the method to fetch pokemon list
        pokemonManager.fetchPokemonList()
    }
}
// MARK: - Pokemon Delegate
extension PokemonListViewController: PokemonManagerDelegate{
    func showPokemonList(list: [Pokemon]) {
        pokemons = list
        
        //Makes sure that the pokemon list gets reloaded with an async task
        
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
}
// MARK: - Table
extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCellTableViewCell
        cell.pokemonNameLabel.text = pokemons[indexPath.row].name
        
        //Cell Image from URL
        
        if let urlString = pokemons[indexPath.row].imageUrl as String?{
            if let urlImage = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let dataImage = try? Data(contentsOf: urlImage) else { return }
                    let image = UIImage(data: dataImage)
                    DispatchQueue.main.async {
                        cell.pokemonImageView.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = pokemons[indexPath.row]
        
        
        performSegue(withIdentifier: "pokemonDetail", sender: self)
        
        // Unselect a pokemon detail
        pokemonTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the identifier is the correct one, it will cast as pokemon detail View controller and it will select that pokemon
        
        if segue.identifier == "pokemonDetail" {
            let pokemonDetail = segue.destination as! PokemonDetailViewController
            pokemonDetail.pokemonShowcase = selectedPokemon
        }
    }
    
}

