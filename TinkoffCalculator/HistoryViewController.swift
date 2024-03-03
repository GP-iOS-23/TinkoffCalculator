//
//  HistoryViewController.swift
//  TinkoffCalculator
//
//  Created by Глеб Поляков on 03.03.2024.
//

import UIKit

class HistoryViewController: UIViewController{
    
    var result: String?
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let result = result, result != "0" {
            resultLabel.text = result
        }else{
            resultLabel.text = "NoData"
        }
    }
}
