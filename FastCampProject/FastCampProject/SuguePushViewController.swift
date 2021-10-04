//
//  SuguePushViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/01.
//

import UIKit

class SuguePushViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SuguePushViewController 뷰가 로드됨")
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SuguePushViewController 뷰가 나타날 것이다.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SuguePushViewController 뷰가 나타남")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SuguePushViewController 뷰가 사라질 것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SuguePushViewController 뷰가 사라짐")
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
