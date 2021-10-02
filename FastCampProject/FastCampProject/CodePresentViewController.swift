//
//  CodePresentViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/02.
//

import UIKit

class CodePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backBtn(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
