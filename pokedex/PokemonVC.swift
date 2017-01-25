//
//  PokemonVC.swift
//  pokedex
//
//  Created by mohsin raza on 19/01/2017.
//  Copyright © 2017 mohsin raza. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonVC:UIViewController
{
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var musicplayer:AVAudioPlayer!
    var pokeArray = [Pokemon]()
    var filterpokeArray:[Pokemon]!
    var isInSearchMode = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchBar.delegate = self
        parseCSV()
        initAudio()
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    // Mark: - AVAudioPlayer
    
    fileprivate func initAudio()
    {
      let path = Bundle.main.path(forResource:"music", ofType:"mp3")
        
        do
        {
             musicplayer = try AVAudioPlayer(contentsOf:URL(fileURLWithPath: path!))
             musicplayer.prepareToPlay()
             musicplayer.numberOfLoops = 1
             musicplayer.play()
        }
        catch let error as NSError
        {
            print(error.debugDescription)
        }

    }
    
    // Mark: - CSVFile
    
    fileprivate func parseCSV()
    {
      
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
      
        do
        {
           let csvfile = try CSV(contentsOfURL: path!)
            
            for row in csvfile.rows
            {
               let obj = Pokemon(row["identifier"]!,Int(row["id"]!)!)
               pokeArray.append(obj)
            }
        }
        catch let error as NSError
        {
          print(error.debugDescription)
        }
    }
    
    
   
    // Mark: - Music

    @IBAction func musicBtn(_ sender: UIBarButtonItem)
    {
        if musicplayer.isPlaying
        {
          musicplayer.pause()
        }
        
        else
        {
          musicplayer.play()
        }

    }
    
     // Mark: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == storybored.storyboredId
        {
        
            if let destinationvc = segue.destination as? DetailVC
            {
              destinationvc.poke = (sender as? Pokemon)
            }
        }
    }
    
    //private struct
    fileprivate struct storybored
    {
      static let storyboredId = "detailpokemon"
    }
    
}

extension PokemonVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{


    // Mark: - UICollectionViewDatasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if isInSearchMode == true
        {
            return filterpokeArray.count
        }
            
        else
        {
            return pokeArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokeCell
        
        if isInSearchMode == true
        {
            cell.pokemon = filterpokeArray[indexPath.row]
        }
            
        else
        {
            cell.pokemon = pokeArray[indexPath.row]
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let poke:Pokemon!
        if isInSearchMode == true
        {
            poke = filterpokeArray[indexPath.row]
        }
            
        else
        {
            poke = pokeArray[indexPath.row]
        }
        
        performSegue(withIdentifier:storybored.storyboredId,sender: poke)
    }
    
    // Mark: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 105,height: 105)
    }
    
}


extension PokemonVC:UISearchBarDelegate
{
    // Mark: - SearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == ""
        {
            isInSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        }
            
        else
        {
            isInSearchMode = true
            let lower = searchBar.text!.lowercased()
            filterpokeArray = pokeArray.filter({$0.name?.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
}

