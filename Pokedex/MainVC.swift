//
//  ViewController.swift
//  Pokedex
//
//  Created by Yunpeng Gao on 4/16/17.
//  Copyright © 2017 Yunpeng Gao. All rights reserved.
//

import UIKit
import AVFoundation

//import Alamofire

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
        searchBar.showsCancelButton = true
        collection.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
//            musicPlayer.play()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
//            print(rows)
            for row in rows {
                if let Id = row["id"] {
                    let pokeId = Int(Id)!
                    if let name = row["identifier"] {
                         let poke = Pokemon(name: name, pokedexId: pokeId)
                        pokemon.append(poke)
                    }
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
//        print(pokemon)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let poke : Pokemon!
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        var poke: Pokemon!
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    @IBAction func musicPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        searchBar.resignFirstResponder()
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        view.endEditing(true)
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""  {
            inSearchMode = false
            
            collection.reloadData()
            self.collection?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
            view.endEditing(true)
        } else {
            inSearchMode = true
            let text = searchBar.text!
            filteredPokemon = pokemon.filter({$0.name.localizedStandardRange(of: text) != nil})
            collection.reloadData()
            if filteredPokemon.count != 0 {
                self.collection?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
            }
            

        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if inSearchMode {
            searchBar.text = ""
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            self.collection?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        } else {
            view.endEditing(true)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
}

