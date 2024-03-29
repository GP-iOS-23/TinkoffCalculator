//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by Глеб Поляков on 31.01.2024.
//

import UIKit

enum CalculationError: Error{
    case dividedByZero
    case tooGreat
}

enum Operation: String{
    case add = "+"
    case substract = "-"
    case multiply = "x"
    case divide = "/"
    
    func calculate(_ number1: Double, _ number2: Double) throws -> Double{
        switch self {
        case .add:
            if number1 > 99999999 || number2 > 99999999{
                throw CalculationError.tooGreat
            }
            
            return number1 + number2
        case .substract:
            return number1 - number2
        case .multiply:
            if number1 > 99999999 || number2 > 99999999{
                throw CalculationError.tooGreat
            }
            
            return number1 * number2
        case .divide:
            if number2 == 0{
                throw CalculationError.dividedByZero
            }
            
            return number1 / number2
        }
    }
}

enum CalculationHistoryItem{
    case number(Double)
    case operation(Operation)
}

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonText = sender.currentTitle else {return}
        
        if buttonText == "," && label.text?.contains(",") == true {
            return
        }
        
        if label.text == "0" && buttonText == ","{
            label.text = "0\(buttonText)"
        }else if label.text == "0"{
            label.text = buttonText
        }else{
            label.text?.append(buttonText)
        }
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard
            let buttonText = sender.currentTitle,
            let buttonOperation = Operation(rawValue: buttonText)
        else { return }
        
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
        else { return }
        
        
        if label.text == "0" && buttonText == "-"{
            label.text = buttonText
        }else{
            calculationHistory.append(.number(labelNumber))
            calculationHistory.append(.operation(buttonOperation))
            
            resetLabelText()
        }
    }
    
    @IBAction func clearButtonPressed() {
        calculationHistory.removeAll()
        
        resetLabelText()
    }
    
    @IBAction func calculateButtonPressed() {
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
        else { return }
        
        calculationHistory.append(.number(labelNumber))
        
        do{
            let result = try calculate()
            
            label.text = numberFormatter.string(from: NSNumber(value: result))
            calculations.append((calculationHistory, result))
        } catch {
            label.text = "Ошибка"
        }
            
            
        calculationHistory.removeAll()
    }
    
    @IBAction func showCalculationsList(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let calculationsListVC = sb.instantiateViewController(identifier: "HistoryViewController")
        if let vc = calculationsListVC as? HistoryViewController{
            vc.calculations = calculations
        }
        
        navigationController?.pushViewController(calculationsListVC, animated: true)
    }
    
    
    var calculationHistory: [CalculationHistoryItem] = []
    var calculations: [(expression: [CalculationHistoryItem], result:  Double)] = []
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 10
        
        return numberFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetLabelText()
        historyButton.accessibilityIdentifier = "historyButton"
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//    }
    
    func calculate() throws -> Double{
        guard case .number(let firstNumber) = calculationHistory[0] else { return 0 }
        
        var currentResult = firstNumber
        
        for index in stride(from: 1, to: calculationHistory.count - 1, by: 2){
            guard
                case .operation(let operation) = calculationHistory[index],
                case .number(let number) = calculationHistory[index + 1]
            else { break }
            
            currentResult = try operation.calculate(currentResult, number)
        }
        
        return currentResult
    }
    
    func resetLabelText(){
        label.text = "0"
    }

}

