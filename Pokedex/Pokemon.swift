//
//  Pokemon.swift
//  Pokedex
//
//  Created by Yunpeng Gao on 4/18/17.
//  Copyright © 2017 Yunpeng Gao. All rights reserved.
//

import Foundation
class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
