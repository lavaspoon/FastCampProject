//
//  ViewController.swift
//  Practice
//
//  Created by lavaspoon on 2021/10/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func tapAddBtn(_ sender: UIBarButtonItem) {
        //let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        let alert = UIAlertController(title: "메세지 입력", message: nil, preferredStyle: .alert)
        let regist = UIAlertAction(title: "전송", style: .default, handler: { [weak self] i in
            guard let title = alert.textFields?[0].text else { return }
            guard let message = alert.textFields?[1].text else { return }
            
            let capsule = Task(title: title, message: message)
            self?.tasks.append(capsule)
            self?.tableView.reloadData()
        })
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        
        alert.addAction(regist)
        alert.addAction(cancel)
        alert.addTextField(configurationHandler: { i in
            i.placeholder = "제목"
        })
        alert.addTextField(configurationHandler: { i in
            i.placeholder = "메세지"
        })
        
        self.present(alert, animated: true, completion: nil)
        
        func saveTasks(){
            let data = self.tasks.map {
                [
                    "title": $0.title,
                    "message": $0.message
                ]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cellIden", for: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = "\(task.title):\(task.message)"
        return cell
    }

}

