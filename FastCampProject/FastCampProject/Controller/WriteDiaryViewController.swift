//
//  WriteDiaryViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/21.
//

import UIKit

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    //UIDatePicker()로 초기화
    private let datePicker = UIDatePicker()
    //DatePicker에서 선택된 데이터를 저장하는 프로퍼티
    private var diaryDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
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
        self.datePicker.locale = Locale(identifier: "ko_KR")
        //텍스트 필드 클릭시, 날짜가 뜨게함
        self.dateTextField.inputView = self.datePicker
    }
    //UIDatePicker객체를 전달받아서 메서드 실행
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        //DateFormatter(): 날짜와 텍스트를 변환
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        //datePicker에서 선택한 date 값 저장
        self.diaryDate = datePicker.date
        //datePicker에서 선택한 date 값 저장
        self.dateTextField.text = formmater.string(from: datePicker.date)
        
    }
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        
    }
    
}
