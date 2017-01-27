//
//  HistoryVC.swift
//  Valutakurser
//
//  Created by Martin Weyhe Christiansen on 25/01/2017.
//  Copyright © 2017 Martin Weyhe Christiansen. All rights reserved.
//

import UIKit
import Alamofire

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!

    @IBOutlet weak var histLbl: UILabel!
    
    var valutaHist: Valuta!
    var valutaHistArray = [Valuta]()
    var sortedValutaHistArray = [Valuta]()
    var dateHist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        histLbl.text = "DKK/\(valutaHist.symbol)"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        getHistoryData()

    
    }

    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return valutaHistArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "ValutaHistCell") as? ValutaHistCell {


        
            //let valutaKurs = valutaHistArray[indexPath.row]
            
            let valutaKurs = sortedValutaHistArray[indexPath.row]
            // let valutaDate = dateHist[indexPath.row]
            
            
            cell.configureCell(valuta: valutaKurs)
            return cell
            
        } else {
            return ValutaCell()
        }
    }
    
    
    
    func downloadHist(URL_HIST: String, completed: @escaping DownloadComplete) {
        
        Alamofire.request(URL_HIST).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let date = dict["date"] as? String {
                                        
                    if self.dateHist.contains(date) {
                        
                    } else {
                        
                        self.dateHist.append(date)
                        
                        
                        if let list = dict["rates"] as? Dictionary<String, Double> {
                            
                            for (symb, val) in list {
                                
                                if symb == self.valutaHist.symbol {
                                    let valuta = Valuta(valueDate: date, symbol: symb, value: val)
                                    self.valutaHistArray.append(valuta)
                                }

                            }
                        }
                        
                    }
                    
                }
                
                completed()
                
            }
            
        }
    }
    
    func getHistoryData() {
        
        let dateFormatter = DateFormatter()
        let day: Double = 60*60*24
        var date = Date.init()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        for _ in 0...30 {
            date = date.addingTimeInterval(-(day))
            
            let URL_HIST = "http://api.fixer.io/\(dateFormatter.string(from: date))?base=DKK"

            downloadHist(URL_HIST: URL_HIST) {

                //sortedValutaHistArray = valutaHistArray.filter({$0.valueDate.range(of: lower) != nil })
                self.sortedValutaHistArray = self.valutaHistArray.sorted(by: { $0.valueDate > $1.valueDate })
                self.tableView.reloadData()
            
            }
        }
    }
    

    @IBAction func BackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
