//
//  TestViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/08.
//

import UIKit
//1) 프로토콜 선언
protocol senderDelegate : AnyObject {
    func changeText(text: String?)
}
class TestViewController: UIViewController {
    
    @IBOutlet weak var SenderBtn: UIButton!
    @IBOutlet weak var NickName: UITextField!
    
    var firstText : String?
    //2) 델리게이트 프로퍼티 선언
    weak var delegate : senderDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVIew()
        SenderBtn.layer.cornerRadius = 10
    }
    
    private func configureVIew(){
        if let firstText = self.firstText {
            self.NickName.text = firstText
        }
    }
    @IBAction func tapSenderBtn(_ sender: UIButton) {
        self.delegate?.changeText(text: self.NickName.text)//위임된 뷰컨트롤러의 changeText() 실행
        print("3) 뷰컨 다녀옴 끝.")
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
