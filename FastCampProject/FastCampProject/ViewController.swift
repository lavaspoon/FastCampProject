//
//  ViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem?
    
    //0) Task 구조체 생성자 생성
    var forms = [Message](){
        //배열에 요소가 추가 될때 마다 실행
        didSet{
            self.saveMessage()
        }
    }
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        //0) dataSource 채택
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //self.loadTasks()
        self.loadMessage()
    }
    //done 버튼을 눌렀을때 실행됨
    @objc func doneButtonTap(){
        //edit 버튼으로 바꿈
        self.navigationItem.leftBarButtonItem = self.editButton
        //편집창 닫음
        self.tableView.setEditing(false, animated: true)
    }
    
    //배열에 요소 추가할때마다 실행할 함수
    func saveMessage(){
        //배열에 있는 요소를 딕셔너리 형태로 매핑
        let data = self.forms.map {
            [   //딕셔너리 형태로 form 배열에 저장
                "name": $0.name,
                "message": $0.message,
                "done": $0.done
            ]
        }
        print("saveMessage 실행: \(data)")
        let UD = UserDefaults.standard
        UD.set(data, forKey: "Message")
    }
    //뷰컨트롤러 로드 했을떄 함수 실행
    func loadMessage(){
        let UD = UserDefaults.standard
        //object 메서드는 Any 타입으로 반환, 반환하는 값이 딕셔너리이기 때문에 타입캐스팅, 타입캐스팅이 실패할 수 도 있으니 guard문 처리
        //as? : 캐스팅 성공하면 옵셔널값 반환하고 실패 하면 nil 반환
        guard let data = UD.object(forKey: "Message") as? [[String: Any]] else { return }
        print("loadMessage 실행: \(data)")
        //compactMap : 1차원 배열에서 nil 제거하고, 옵셔널 바인딩 할때 사용
        //as? : 캐스팅 성공하면 옵셔널값 반환하고 실패 하면 nil 반환
        //다시 배열에 넣어줌
        self.forms = data.compactMap{
            //다시 tasks 배열에 저장 compactMap으로 매핑
            //딕셔너리 value 가 Any 타입이니깐 String, Bool 로 타입 캐스팅
            guard let name = $0["name"] as? String else { return nil }
            guard let message = $0["message"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Message(name: name, message: message, done: done)
        }
    }
    
    
    
    
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        guard !self.forms.isEmpty else { return }
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            //텍스트필드의 0번째 배열을 가져옴
            //1) alert에 입력한 타이틀값을 title 변수에 담은 후
            guard let title = alert.textFields?[0].text else { return }
            //2) Message 구조체에 담아 form 변수에 저장
            let form = Message(name: "lavaspoon", message: title, done: false)
            //3) tasks 배열에 할일이 추가
            self?.forms.append(form)
            //6) 등록버튼 클릭 시, 테이블뷰 갱신
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
//필수, 가독성을 위해 extension 씀
extension ViewController : UITableViewDataSource {
    //UITableViewDataSource 프로토콜을 채택하면 아래의 두 메서드는 꼭 구현해야함
    
    //numberOfRowsInSection: 각 섹션에 표시할 행의 갯수를 묻는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //배열의 갯수 반환
        return self.forms.count
    }
    //cellForRowAt: 특정 섹션의 N번째 Row를 그리는데 필요한 셀을 반환하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //4) 스토리보드에 정의한 셀을 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //5) 배열에 저장된 할일 값을 가져옴
        let form = self.forms[indexPath.row]
        cell.textLabel?.text = form.message
        //체크마크
        if form.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    //스와이프 모드, 편집 모드에서 버튼을 선택하면 호출 되는 메서드
    //해당 메서드는 행에 변경사항을 커밋 해야함
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //선택한 항목을 배열에서 삭제
        self.forms.remove(at: indexPath.row)
        //선택한 항목을 테이블에서 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.forms.isEmpty {
            self.doneButtonTap()
        }
    }
    
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.forms[선택한 셀 번호] 를 통해 배열의 값을 form 프로퍼티에 저장
        var form = self.forms[indexPath.row]
        form.done = !form.done
        self.forms[indexPath.row] = form
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
