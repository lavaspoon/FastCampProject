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
        
    }
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        print(numberValue)
    }
    @IBAction func tapClearButton(_ sender: UIButton) {
    
    }
    @IBAction func tapNanugiButton(_ sender: UIButton) {
    
    }
    @IBAction func tapGobhagiButton(_ sender: UIButton) {
    
    }
    @IBAction func tapPlusButton(_ sender: UIButton) {
    
    }
    @IBAction func tapMinusButton(_ sender: UIButton) {
    
    }
    @IBAction func tapEqualButton(_ sender: UIButton) {
    
    }
}
