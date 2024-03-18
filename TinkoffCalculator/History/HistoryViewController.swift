//
//  HistoryViewController.swift
//  TinkoffCalculator
//
//  Created by Глеб Поляков on 03.03.2024.
//

import UIKit

class HistoryViewController: UIViewController{
    
    var calculations: [(expression: [CalculationHistoryItem], result:  Double)] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 50, green: 60, blue: 53, alpha: 0)
        
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    private func expressionToString(_ expression: [CalculationHistoryItem]) -> String{
        var result = ""
        
        for operand in expression{
            switch operand {
            case let .number(value):
                result += String(value) + " "
            case let .operation(value):
                result += value.rawValue + " "
            }
        }
        
        return result
    }
}

extension HistoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.frame.width,
                                              height: 25))
        
        let dateLabel = UILabel()
        dateLabel.font = .boldSystemFont(ofSize: 20)
        dateLabel.textColor = .white
        dateLabel.frame = CGRect.init(x: 15,
                                      y: 0,
                                      width: headerView.frame.width-10,
                                      height: headerView.frame.height-10)
        
        let date = Date()
        dateLabel.text = date.formatted(Date
            .FormatStyle()
            .day(.twoDigits)
            .month(.twoDigits)
            .year(.twoDigits))
        
        headerView.addSubview(dateLabel)
        return headerView
    }
}

extension HistoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        let historyItem = calculations[indexPath.row]
        cell.configure(with: expressionToString(historyItem.expression), result: String(historyItem.result))
        return cell
    }
    
}
