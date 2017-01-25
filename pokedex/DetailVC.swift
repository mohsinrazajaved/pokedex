//
//  DetailVC.swift
//  pokedex
//
//  Created by mohsin raza on 20/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit

class DetailVC: UIViewController
{

    var poke:Pokemon!
    var instancePoke = PokemonDetail()
    
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense : UILabel!
    @IBOutlet weak var height:UILabel!
    @IBOutlet weak var weight:UILabel!
    @IBOutlet weak var type:UILabel!
    @IBOutlet weak var pokeid:UILabel!
    @IBOutlet weak var pokeImg:UIImageView!
    @IBOutlet weak var pokeImg2:UIImageView!
    @IBOutlet weak var descrption:UILabel!
    @IBOutlet weak var evolutiomImg:UIImageView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = poke.name
        instancePoke.getId = poke.pokedexId
        instancePoke.downloadPokemonDetail
        {[weak weakself = self] in
            
            weakself?.updatePOKEUI()
        }
    }
    
    private func updatePOKEUI()
    {
        attack.text = instancePoke.attack
        defense.text = instancePoke.defense
        height.text = instancePoke.height
        weight.text = instancePoke.weight
        pokeImg.image = UIImage(named:"\(poke.pokedexId!).png")
        pokeImg2.image = UIImage(named:"\(poke.pokedexId!).png")
        evolutiomImg.image = UIImage(named:"\(instancePoke.nextEvolutionId).png")
        pokeid.text = "\(poke.pokedexId!)"
        descrption.text = instancePoke.description
        type.text = instancePoke.type.capitalized
    }

}



