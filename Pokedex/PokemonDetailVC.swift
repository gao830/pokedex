//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Yunpeng Gao on 4/24/17.
//  Copyright © 2017 Yunpeng Gao. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = pokemon.name
        
    }

}
