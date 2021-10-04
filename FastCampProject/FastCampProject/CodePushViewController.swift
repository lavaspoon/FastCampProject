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
        
    }
    @IBAction func backbtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
