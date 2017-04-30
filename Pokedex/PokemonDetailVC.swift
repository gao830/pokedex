//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Yunpeng Gao on 4/24/17.
//  Copyright © 2017 Yunpeng Gao. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImg: UIImageView!
   
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
//    @IBAction func musicPressed(_ sender: UIButton) {
//        if musicPlayer.isPlaying {
//            musicPlayer.pause()
//            sender.alpha = 0.2
//        } else {
//            musicPlayer.play()
//            sender.alpha = 1.0
//        }
//    }

}
