//
//  ValutaCell.swift
//  Valutakurser
//
//  Created by Martin Weyhe Christiansen on 18/01/2017.
//  Copyright © 2017 Martin Weyhe Christiansen. All rights reserved.
//

import UIKit

class ValutaCell: UITableViewCell {


    @IBOutlet weak var symbolIcon: UIImageView!
    @IBOutlet weak var valutaLbl: UILabel!

    
    func configureCell(valuta: Valuta) {
        symbolIcon.image = UIImage(named: valuta.symbol)
        let valueInt = String(format: "%.2f", valuta.value)
        valutaLbl.text = valueInt
    }
}


