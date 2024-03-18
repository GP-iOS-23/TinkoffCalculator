//
//  HistoryTableViewCell.swift
//  TinkoffCalculator
//
//  Created by Глеб Поляков on 18.03.2024.
//

import Foundation
import UIKit


class HistoryTableViewCell: UITableViewCell{
    
    @IBOutlet private weak var expressionLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    
    func configure(with expression: String, result: String){
        expressionLabel.text = expression
        resultLabel.text = result
        
        expressionLabel.textColor = .white
        resultLabel.textColor = .white
        self.backgroundColor = UIColor(red: 50, green: 60, blue: 53, alpha: 0)
    }
}
