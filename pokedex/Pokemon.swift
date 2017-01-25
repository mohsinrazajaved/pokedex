//
//  Pokemon.swift
//  pokedex
//
//  Created by mohsin raza on 19/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import Foundation

class Pokemon
{

    private var _name:String!
    private var _pokedexId:Int!
    
    //public getters
    var name:String?
    {
       return _name ?? ""
    }
    
    var pokedexId:Int?
    {
      return _pokedexId ?? 0
    }
    
    init(_ name:String,_ pokedex:Int)
    {
       _name = name
       _pokedexId = pokedex
    }
}
