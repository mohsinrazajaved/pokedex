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

    fileprivate var _name:String?
    fileprivate var _pokedexId:Int?
    
    //getters
    var getname:String?
    {
        if _name != nil
        {
            return _name
        }
        
        return nil
    }
    
    var getpokedexId:Int?
    {
        if _pokedexId != nil
        {
         return _pokedexId
        }

     return nil
    }
    
    
    init(_ name:String,_ pokedex:Int)
    {
       _name = name
       _pokedexId = pokedex
    }
}
