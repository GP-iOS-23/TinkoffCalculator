//
//  HistoryViewController.swift
//  TinkoffCalculator
//
//  Created by Глеб Поляков on 03.03.2024.
//

import UIKit

class HistoryViewController: UIViewController{
    
    var result: String?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        initialize()
    }
    
    private func initialize(){
        modalPresentationStyle = .fullScreen
    }
    
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
