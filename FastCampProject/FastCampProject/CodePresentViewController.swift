//
//  CodePresentViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/02.
//

import UIKit

protocol SendDataDelegate : AnyObject { //AnyObject 상속
    func sendData(name : String)
}

class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    //ViewController.swift에서 name 프로퍼티에 접근하기 위해서는 뷰컨트롤러에서 다운캐스팅 해야함
    weak var delegate : SendDataDelegate? //delegate 변수는 weak를 선언해서 메모리 누수방지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //옵셔널이기 떄문에 옵셔널 바인딩
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.delegate?.sendData(name: "Scott")
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
