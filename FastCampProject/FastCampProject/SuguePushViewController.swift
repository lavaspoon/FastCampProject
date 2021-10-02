//
//  SuguePushViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/01.
//

import UIKit

class SuguePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
