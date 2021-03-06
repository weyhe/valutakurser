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

    private var _valueDate: String!
    private var _symbol: String!
    private var _value: Double!
    
    var valueDate: String {
        if _valueDate == nil {
            _valueDate = ""
        }
        
        return _valueDate
    }
    
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

    init(valueDate: String, symbol: String, value: Double) {
     
    
            self._symbol = symbol
            self._value = 1 / value * 100
            // self._value = value
        
            self._valueDate = valueDate
        }
        

    
 
}
