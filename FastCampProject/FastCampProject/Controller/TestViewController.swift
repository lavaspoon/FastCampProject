//
//  TestViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/08.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var SenderBtn: UIButton!
    @IBOutlet weak var NickName: UITextField!
    
    var firstText : String?
    
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
    

}
