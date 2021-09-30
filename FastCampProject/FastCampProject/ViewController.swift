//
//  ViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let quotes = [
        Quote(contents: "When you go through hardships and decide not to surrender, that is strength.", name: "Arnold Schwarzenegger"),
        Quote(contents: "It is kind of fun to do the impossible.When you go through hardships and decide not to surrender, that is strength.", name: "Walt Disney"),
        Quote(contents: "There are better starters than me but I’m a strong finisher.", name: "Usain Bolt"),
        Quote(contents: "Tough times never last, but tough people do.", name: "Robert H. Schuller"),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapQuoteCreateBtn(_ sender: UIButton) {
        print("UIViewController-tapQuoteCreateBtn")
        
        let random = Int(arc4random_uniform(4)) //0~3 사이의 난수가 랜덤으로 나옴. 배열의 인덱스 요소에 접근하기위해 Int형으로 치환
        let quote = quotes[random]
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
        
    }
    
}

