//
//  ValutaHistCell.swift
//  Valutakurser
//
//  Created by Martin Weyhe Christiansen on 26/01/2017.
//  Copyright © 2017 Martin Weyhe Christiansen. All rights reserved.
//

import UIKit

class ValutaHistCell: UITableViewCell {

    @IBOutlet weak var histValue: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    //func configureCell(valuta: Valuta, dateStr: String) {
    func configureCell(valuta: Valuta) {
        
        let valueInt = String(format: "%.2f", valuta.value)
        histValue.text = valueInt
        dateLbl.text = valuta.valueDate
        
    }
}
