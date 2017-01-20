//
//  PokeCell.swift
//  pokedex
//
//  Created by mohsin raza on 19/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell
{
    
    var pokemon:Pokemon!
    {
        didSet
        {
          updateCellUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5
    }
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    
    fileprivate func updateCellUI()
    {
        if pokemon != nil
        {
            pokemonImage.image = UIImage(named:"\(pokemon.getpokedexId!)"+".png")
            pokemonName.text = pokemon?.getname?.capitalized
        }
    }
}
