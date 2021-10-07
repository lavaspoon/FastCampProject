//
//  SettingViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/05.
//

import UIKit
//1) 이전 화면으로 데이터 전달을 위한 프로토콜 선언
protocol LEDSettingDelegate : AnyObject{
    //설정값을 전달하는 함수 정의(이전화면으로 전달할 값)
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
    
    //2) 델리게이트 프로퍼티 추가
    weak var delegate : LEDSettingDelegate?
    
    var ledText : String? // 뷰 컨트롤러에서 설정된 텍스트를 가져오기 위한 프로퍼티
    var textColor : UIColor = .yellow
    var backgroundColor : UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    //MARK: 1-이전화면의 값들을 세팅뷰에서 받음
    private func configureView(){
        if let ledText = self.ledText {
            self.textField.text = ledText
        }
        //이전화면에서 받은 컬러와 백그다운드를 change 함수의 파라미터로 전달해줌
        self.changeTextColor(color: self.textColor)
        self.changeBackGroundColor(color: self.backgroundColor)
    }
    
    @IBAction func tapTextColorBtn(_ sender: UIButton) {
        //sender 파라미터는 클릭한 버튼의 색을 담음
        if sender == self.yellowBtn { //전달받은 sender 가 엘로우 버튼이면 텍스트 컬러를 엘로우로 바꿈
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
            //설정된 프로퍼티 값들을 파라미터로 전달함
            text: self.textField.text,
            textColor: self.textColor,
            backgroundColor: self.backgroundColor
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color : UIColor) {
        //파라미터로 전달받은 색상이 해당색상이면 1, 아니면 0.5
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
