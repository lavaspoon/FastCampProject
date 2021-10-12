//
//  ViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/09/28.
//

import UIKit

enum Operation {
    case Nanugi
    case Gobhagi
    case Minus
    case Plus
    case unKnown
}
class ViewController: UIViewController {
    
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation : Operation = .unKnown
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = displayNumber
        }
    }
    @IBAction func tapNumberButton(_ sender: UIButton) {
        //입력한 버튼의 값을 가져옴
        guard let numberValue = sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = displayNumber
        }
    }
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.numberOutputLabel.text = "0"
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unKnown
    }
    @IBAction func tapNanugiButton(_ sender: UIButton) {
        self.operation(.Nanugi)
    }
    @IBAction func tapGobhagiButton(_ sender: UIButton) {
        self.operation(.Gobhagi)
    }
    @IBAction func tapPlusButton(_ sender: UIButton) {
        self.operation(.Plus)
    }
    @IBAction func tapMinusButton(_ sender: UIButton) {
        self.operation(.Minus)
    }
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
        print(self.currentOperation)
    }
    
    // MARK: 함수로 기능 구분
    func operation(_ operation: Operation){
        if currentOperation != .unKnown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand =  Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                switch self.currentOperation {
                case .Nanugi:
                    self.result = "\(firstOperand / secondOperand)"
                case .Gobhagi:
                    self.result = "\(firstOperand * secondOperand)"
                case .Plus:
                    self.result = "\(firstOperand + secondOperand)"
                case .Minus:
                    self.result = "\(firstOperand - secondOperand)"
                default:
                    break
                }
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
            }
            self.currentOperation = operation
        } else {
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            print(self.currentOperation)
            self.displayNumber = ""
        }
    }
}
