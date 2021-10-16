//
//  ViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dataSource 채택
        self.tableView.dataSource = self
        
    }
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
    }
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            //텍스트필드의 0번째 배열을 가져옴
            debugPrint("\(alert.textFields?[0].text)")
            
            guard let title = alert.textFields?[0].text else { return }
            let task = Task(title: title, done: false)
            //tasks 배열에 할일이 추가 됨
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        alert.addTextField(configurationHandler: { inputText in
            inputText.placeholder = "할 일을 입력해주세요."
            
        })
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController : UITableViewDataSource {
    //UITableViewDataSource 프로토콜을 채택하면 아래의 두 메서드는 꼭 구현해야함
    
    //numberOfRowsInSection: 각 섹션에 표시할 행의 갯수를 묻는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //배열의 갯수 반환
        return self.tasks.count
    }
    //cellForRowAt: 특정 섹션의 N번째 Row를 그리는데 필요한 셀을 반환하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //스토리보드에 정의한 셀을 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //배열에 저장된 할일 값을 가져옴
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
}
