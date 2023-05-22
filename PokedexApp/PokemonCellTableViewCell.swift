//
//  PokemonCellTableViewCell.swift
//  PokedexApp
//
//  Created by Lautaro Galan on 17/05/2023.
//

import UIKit

class PokemonCellTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
