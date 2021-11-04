//
//  WriteDiaryViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/21.
//

import UIKit

//delegate를 통해서 일기장리스트 화면에 일기가 작성된 '다이어리 객체'를 전달하기 위해
protocol WriteDiaryViewDelegate : AnyObject { //AnyObject 상속
    func didSeletRegister(diary: Diary) //파라미터에 Diary 객체가 전달되게함
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    //UIDatePicker()로 초기화
    private let datePicker = UIDatePicker()
    //DatePicker에서 선택된 데이터를 저장하는 프로퍼티
    private var diaryDate : Date?
    
    //delegate 프로퍼티 정의
    weak var delegate : WriteDiaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.confirmButton.isEnabled = false
        self.configureInputField()
    }
    
    //contentsTextView의 border가 투명이기때문에 설정해줌
    private func configureContentsTextView(){
        let setColor = UIColor(red: 220/225, green: 220/225, blue: 220/225, alpha: 1.0)
        //cgColor 사용
        self.contentsTextView.layer.borderColor = setColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        //addTarget : UIController 객체가 이벤트에 응답하는 방식을 설정하는 메서드
        //target: 해당 뷰 컨트롤러가 처리할거니깐 self, action: 호출될 메서드를 Selector로 넘겨줌,
        //for: 어떤 이벤트가 일어났을때 액션에 정의한 메서드를 호출할 것인지 설정
        //결론 -> datePicker의 값이 바뀔때마다 datePickerValueDidChange메소드 실행
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        //DatePicker 언어 한국어로 변경
        self.datePicker.locale = Locale(identifier: "ko_KR")
        //텍스트 필드 클릭시, 날짜가 선택창이 팝업되게함
        self.dateTextField.inputView = self.datePicker
    }
    //UIDatePicker객체를 전달받아서 메서드 실행 (값이 바뀔때 마다 실행되는 함수)
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        //DateFormatter(): 날짜와 텍스트를 변환
        let formmater = DateFormatter()
        
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        //datePicker에서 선택한 date 값 저장
        self.diaryDate = datePicker.date
        //datePicker에서 선택한 date 값 저장
        self.dateTextField.text = formmater.string(from: datePicker.date)
        //날짜 변경할때마다 dateTextFieldDidChanged가 실행되게 해줌
        self.dateTextField.sendActions(for: .editingChanged)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//MARK: [Delegate 패턴] 뷰컨트롤러로 diary 객체 전달
    //등록버튼을 누르면 다이어리 객체를 생성하고, delegate에 정의한 didSeletRegister() 메서드르 실행해서 파리미터에 생성한 다이어리 객체를 넘김
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
         //옵셔널 바인딩
        guard let title = self.titleTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
        
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        //다이러리 객체 전달
        self.delegate?.didSeletRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
//MARK: [등록버튼] 활성화/비활성화 기능 코드
    
    //[등록버튼] 텍스트필드의 모든 값이 채워졌을때 등록버튼이 눌리도록 설정
    private func configureInputField(){
        self.contentsTextView.delegate = self
        //텍스트뷰의 텍스트가 입력될때마다 등록버튼 활성화 여부를 판단하는 메서드
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChanged(_:)), for: .editingChanged)
        //date필드의 텍스트가 입력될때마다 등록버튼 활성화 여부를 판단하는 메서드
        //문제점: 데이트피커는 키보드로 값을 입력하는것이 아니기 때문에 실행이안됨 datePickerValueDidChange() 참조
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChanged(_:)), for: .editingChanged)
    }
    //[등록버튼] 텍스트필드의 텍스트가 입력될때마다 등록버튼 활성화 여부를 판단하는 메서드
    @objc private func titleTextFieldDidChanged(_ textField: UITextField){
        print("타이틀 필드체크")
        self.validateInputField()
    }
    //[등록버튼] date필드의 텍스트가 입력될때마다 등록버튼 활성화 여부를 판단하는 메서드
    @objc private func dateTextFieldDidChanged(_ textField: UITextField){
        print("데이트 필드체크")
        self.validateInputField()
    }
    //[등록버튼] 텍스트뷰의 텍스트가 입력될때마다 등록버튼 활성화 여부를 판단하는 메서드
    private func validateInputField() {
        //텍스트필드와 텍스트뷰가 비어있지 않으면 버튼 활성화 -> 텍스트 필드는 옵셔널처리, 텍스트뷰는 옵셔널 처리안함
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
    }
}

//[등록버튼]
extension WriteDiaryViewController : UITextViewDelegate {
//텍스트뷰의 텍스트가 입력될때 마다 호출되는 메서드
    func textViewDidChange(_ textView: UITextView) {
        print("내용 필드체크")
        self.validateInputField()
    }
}
