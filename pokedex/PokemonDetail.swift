//
//  PokemonDetail.swift
//  pokedex
//
//  Created by mohsin raza on 25/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PokemonDetail
{
    
     private var _description: String!
     private var _type: String!
     private var _defense: String!
     private var _height: String!
     private var _weight: String!
     private var _attack: String!
     private var _nextEvolutionId: String!
     private var _pokemonURL: String!
    
    
     //public getters
    
     var nextEvolutionId: String
     {
       return _nextEvolutionId ?? ""
     }
     
     var description: String
     {
       return _description ?? ""
     }
     
     var type: String
     {
       return _type ?? ""
     }
     
     var defense: String
     {
       return _defense ?? ""
     }
     
     var height: String
     {
      return _height ?? ""
     }
     
     var weight: String
     {
       return _weight ?? ""
     }
     
     var attack: String
     {
       return _attack ?? ""
     }
    
     var getId:Int!
     {
        didSet
        {
        self._pokemonURL = "\(FULL_URL)\(self.getId!)/"
        }
     }
    
     func downloadPokemonDetail(completed: @escaping DownloadComplete)
     {
         Alamofire.request(_pokemonURL).responseJSON
         {[weak weakself = self](response) in
            
            switch response.result
            {
              case .success(let value):
                
                let json = JSON(value)
                
                    weakself?._attack = "\(json["attack"].double ?? 0.0)"
                    weakself?._defense = "\(json["defense"].double ?? 0.0)"
                    weakself?._height = json["height"].string ?? ""
                    weakself?._weight = json["weight"].string ?? ""
                
                let typeNames =  json["types"].arrayValue.map({$0["name"].string})
                
                if typeNames.count != 0
                {
                    self._type = typeNames[0] ?? ""
                }
                
                if typeNames.count > 1
                {
                    for i in 1..<typeNames.count
                    {
                      let str = typeNames[i] ?? ""
                      self._type =  self._type+"/"+str
                    }
                }
                
                let url1 = json["descriptions"].arrayValue.map({$0["resource_uri"].string})[0] ?? ""
                
                Alamofire.request(BASE_URL+url1).responseJSON
                {(response) in
                        
                    switch response.result
                    {
                            
                        case .success(let value):
                            
                            let json = JSON(value)
                            
                            weakself?._description = (json["description"].string ?? "").replacingOccurrences(of: "POKMON", with: "pokemon")
                            
                        case .failure(let error as NSError):
                            print(error.debugDescription)
                            
                        default: break
                        
                    }
                    
                    completed()
                }

                let url2 = json["evolutions"].arrayValue.map({$0["resource_uri"].string})[0] ?? ""
                
                let newStr = url2.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                
                self._nextEvolutionId = nextEvoId
                
                
              case .failure(let error as NSError):
                  print(error.debugDescription)
             
              default: break
            }
         
            completed()
         }
    }
}


