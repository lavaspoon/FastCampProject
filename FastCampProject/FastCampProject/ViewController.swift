//
//  ViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController, LEDSettingDelegate, senderDelegate{

    
    
    @IBOutlet weak var NickNameLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentsLabel.textColor = .yellow
    }
    //3) 세그웨이로 화면전환 되니깐 prepare 함수를 통해서 값 받는다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //다운캐스팅 하여 세팅뷰컨트롤러의 프로퍼티 접근
        if let settingViewController = segue.destination as? SettingViewController {
            //delegate 위임
            settingViewController.delegate = self
            
            //MARK: 2-세팅뷰로 현재 값들을 보내줌
            settingViewController.ledText = self.contentsLabel.text
            settingViewController.textColor = self.contentsLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
        if let testViewController = segue.destination as? TestViewController {
            testViewController.firstText = self.NickNameLabel.text // 첫번째 화면 값 test뷰로 전달
            testViewController.delegate = self
            print("1) 테스트뷰 델리게이트 위임")
        }
    }
    //4) 값을 받기위해 반드시 선언해줘야 함
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        //이전화면에서 전달하는 설정값들을 뷰에 초기화 시켜줌
        if let text = text {
            self.contentsLabel.text = text
        }
        self.contentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
    
    func changeText(text: String?) {
        print("2) 테스트뷰에서 값 전달받음")
        self.NickNameLabel.text = text
    }

}
