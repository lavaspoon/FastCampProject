//
//  ViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController 뷰가 로드됨")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController 뷰가 나타날 것이다.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController 뷰가 나타남")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController 뷰가 사라짐")
    }
    
    //code로 푸쉬
    @IBAction func codePusbBtn(_ sender: UIButton) {
        //스토리보드의 뷰컨트롤러 인스턴스화
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else { return }
        //다운캐스팅 : CodePushViewController에 정의한 name 프로퍼티에 접근하기 위해 as? 선언함
        viewController.name = "lavaspoon"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //code로 프리젠트
    @IBAction func codePresentBtn(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else { return }
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "lavaspoon"
        viewController.delegate = self //delegate 프로퍼티 접근해서 self로 초기화하게 되면 deleagete를 위임받게됨
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

