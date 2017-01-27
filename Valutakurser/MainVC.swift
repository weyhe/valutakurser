//
//  ViewController.swift
//  Valutakurser
//
//  Created by Martin Weyhe Christiansen on 18/01/2017.
//  Copyright © 2017 Martin Weyhe Christiansen. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var updatedLbl: UILabel!
    
    var valuta: Valuta!
    var valutaKurser = [Valuta]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.downloadList {
            
            self.tableView.reloadData()
        }
        
    }

    
    func downloadList(completed: @escaping DownloadComplete) {
        
        Alamofire.request(URL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let updated = dict["date"] as? String {
                    self.updatedLbl.text = "Opdateret: \(updated)"
                }
                
                if let list = dict["rates"] as? Dictionary<String, Double> {

                    for (symb, val) in list {
                        
                        if symb == "USD" || symb == "EUR" || symb == "GBP" || symb == "NOK" || symb == "SEK" {
                            let valuta = Valuta(valueDate: "", symbol: symb, value: val)
                            self.valutaKurser.append(valuta)
                        }
                        
                    }

                }
                
             }
            completed()
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valutaKurser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "valutaCell") as? ValutaCell {
            
            let valutaKurs = valutaKurser[indexPath.row]
            cell.configureCell(valuta: valutaKurs)
            
            
            return cell
            
        } else {
            return ValutaCell()
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // valuta = valutaKurser[indexPath.row]
//        DispatchQueue.main.async {
//            self.valuta = self.valutaKurser[indexPath.row]
//            self.performSegue(withIdentifier: "HistoryVC", sender: self.valuta)
//        }
        self.valuta = self.valutaKurser[indexPath.row]
        self.performSegue(withIdentifier: "HistoryVC", sender: self.valuta)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "HistoryVC" {

            if let historyVC = segue.destination as? HistoryVC {
                
                if let valutaHist = sender as? Valuta {
                    
                    historyVC.valutaHist = valutaHist 
                }
           
            }
        }
    }

}

