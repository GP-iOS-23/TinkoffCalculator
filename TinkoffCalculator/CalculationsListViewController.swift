//
//  CalculationsListViewController.swift
//  TinkoffCalculator
//
//  Created by Глеб Поляков on 07.02.2024.
//

import UIKit

class CalculationsListViewController: UIViewController{
    
    var result: String?
    
    @IBOutlet weak var calculationLabel: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let result = result, result != "0"{
            calculationLabel.text = result
        }else{
            calculationLabel.text = "NoData"
        }
        //calculationLabel.text = !result ? "NoData": result
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
    
    @IBAction func dismissVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
