//
//  DiaryDetailViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/21.
//

import UIKit

//MARK: DELEGATE를 이용한 일기 삭제
protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectedDelete(indexPath: IndexPath)
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate : DiaryDetailViewDelegate?
    
    //전달받을 프로퍼티 선언
    var diary : Diary?
    var indexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
//MARK: [뷰컨트롤러 델리게이트] 전달받은 diary 객체를 뷰에 초기화
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = dateToString(date: diary.date)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        
        //수정모드 데이터 전달
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        viewController.diaryEditorMode = .edit(indexPath, diary)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        //전달받은 indexPath값 옵셔널 바인딩
        guard let indexPath = self.indexPath else { return }
        //indexPath 델리게이트에 전달
        self.delegate?.didSelectedDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
}
