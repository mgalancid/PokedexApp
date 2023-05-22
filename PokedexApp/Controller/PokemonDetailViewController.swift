//
//  PokemonDetailViewController.swift
//  PokedexApp
//
//  Created by Lautaro Galan on 17/05/2023.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - Variables
    var pokemonShowcase: Pokemon?
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonDescriptionTextView: UITextView!
    
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    
    @IBOutlet weak var pokemonAttackLabel: UILabel!
    
    @IBOutlet weak var pokemonDefenseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Showcasing pokemons info
        pokemonImageView.loadFrom(URLAddress: pokemonShowcase?.imageUrl ?? "")
        
        pokemonTypeLabel.text = "Type: \(pokemonShowcase?.type ?? "")"
        pokemonAttackLabel.text = "Attack: \(String(describing: pokemonShowcase?.attack))"
        pokemonDefenseLabel.text = "Defense: \(String(describing: pokemonShowcase?.defense))"
        pokemonDescriptionTextView.text = pokemonShowcase?.description ?? ""
        
    }
}

// MARK: - Loading pokemon image

extension UIImageView{
    func loadFrom(URLAddress: String){
        guard let url = URL(string: URLAddress) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        .resume()
    }
}
