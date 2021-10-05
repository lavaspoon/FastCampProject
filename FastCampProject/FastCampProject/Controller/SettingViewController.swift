//
//  SettingViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/05.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var orangeBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var purpleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func tapTextColorBtn(_ sender: UIButton) {
        if sender == self.yellowBtn {
            self.changeTextColor(color: .yellow)
        } else if sender == self.orangeBtn {
            self.changeTextColor(color: .orange)
        } else {
            self.changeTextColor(color: .green)
        }
    }
    @IBAction func tapBackgroundColorBtn(_ sender: UIButton) {
        if sender == self.blackBtn {
            self.changeBackGroundColor(color: .black)
        } else if sender == self.blueBtn {
            self.changeBackGroundColor(color: .blue)
        } else {
            self.changeBackGroundColor(color: .purple)
        }
    }
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        
    }
    
    private func changeTextColor(color : UIColor) {
        self.yellowBtn.alpha = color == UIColor.yellow ? 1 : 0.2
        self.orangeBtn.alpha = color == UIColor.orange ? 1 : 0.2
        self.greenBtn.alpha = color == UIColor.green ? 1 : 0.2
    }
    private func changeBackGroundColor(color : UIColor) {
        self.blackBtn.alpha = color == UIColor.black ? 1 : 0.2
        self.blueBtn.alpha = color == UIColor.blue ? 1 : 0.2
        self.purpleBtn.alpha = color == UIColor.purple ? 1 : 0.2
    }
}
