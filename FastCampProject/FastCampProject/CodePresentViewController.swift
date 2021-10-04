//
//  CodePresentViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/02.
//

import UIKit

class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    //ViewController.swift에서 name 프로퍼티에 접근하기 위해서는 뷰컨트롤러에서 다운캐스팅 해야함
    override func viewDidLoad() {
        super.viewDidLoad()
        //옵셔널이기 떄문에 옵셔널 바인딩
        if let name = name {
            self.nameLabel.text = name
        }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
