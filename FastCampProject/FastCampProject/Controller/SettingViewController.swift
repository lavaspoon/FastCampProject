//
//  SettingViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/05.
//

import UIKit

protocol LEDSettingDelegate : AnyObject{
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}
class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var orangeBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var purpleBtn: UIButton!
    weak var delegate : LEDSettingDelegate?
    var ledText : String?
    var textColor : UIColor = .yellow
    var backgroundColor : UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView(){
        if let ledText = self.ledText {
            self.textField.text = ledText
        }
        self.changeTextColor(color: self.textColor)
        self.changeBackGroundColor(color: self.backgroundColor)
    }
    @IBAction func tapTextColorBtn(_ sender: UIButton) {
        if sender == self.yellowBtn {
            self.changeTextColor(color: .yellow)
            self.textColor = .yellow
        } else if sender == self.orangeBtn {
            self.changeTextColor(color: .orange)
            self.textColor = .orange
        } else {
            self.changeTextColor(color: .green)
            self.textColor = .green
        }
    }
    @IBAction func tapBackgroundColorBtn(_ sender: UIButton) {
        if sender == self.blackBtn {
            self.changeBackGroundColor(color: .black)
            self.backgroundColor = .black
        } else if sender == self.blueBtn {
            self.changeBackGroundColor(color: .blue)
            self.backgroundColor = .blue
        } else {
            self.changeBackGroundColor(color: .purple)
            self.backgroundColor = .purple
        }
    }
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        self.delegate?.changedSetting(
            text: self.textField.text,
            textColor: self.textColor,
            backgroundColor: self.backgroundColor
        )
        self.navigationController?.popViewController(animated: true)
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
