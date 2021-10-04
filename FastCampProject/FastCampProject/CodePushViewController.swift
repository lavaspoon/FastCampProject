//
//  codePushViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/01.
//

import UIKit

class CodePushViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        //옵셔널이기 떄문에 옵셔널 바인딩
        if let name = name {
            self.nameLabel.text = name
        }
        
    }
    @IBAction func backbtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
