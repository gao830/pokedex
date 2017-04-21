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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
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
            let poke = pokemon[indexPath.row]
            cell.configureCell(pokemon: poke)
            
//            let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row + 1)
//            cell.configureCell(pokemon: pokemon)
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    
}

