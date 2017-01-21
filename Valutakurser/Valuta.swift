//
//  ValutaCell.swift
//  Valutakurser
//
//  Created by Martin Weyhe Christiansen on 18/01/2017.
//  Copyright © 2017 Martin Weyhe Christiansen. All rights reserved.
//


import UIKit
import Alamofire

class Valuta {

    private var _symbol: String!
    private var _value: Double!
    
    
    var symbol: String {
        
        if _symbol == nil {
            _symbol = ""
        }
        
        return _symbol
    }
    
    var value: Double {
        
        if _value == nil {
            _value = 0
        }
        
        
        return _value
    }

    init(symbol: String, value: Double) {
     
    
            self._symbol = symbol
            self._value = 1 / value * 100
        
        
        }
        

    
 
}
