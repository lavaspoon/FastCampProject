//
//  ViewController.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    //다이어리 배열로 초기화
    private var diaryList = [Diary]() {
        didSet {
            self.saveDiaryList()
        }
    }
//MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
    }
    
//MARK: UD값을 가져옴
    private func loadDiaryList() {
        let UD = UserDefaults.standard
        //Any타입으로 리턴됨 -> 타입캐스팅
        guard let data = UD.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap { // Diary 타입이 되도록 compactMap 고차함수를 통해 매핑
            guard let title = $0["title"] as? String else { return nil } //$0 : 축약인자로 딕셔너리 접근, "title" 키로 딕셔너리 value를 가져옴, 딕셔너리 value가 anytype 이니깐 String 으로 타입변환
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            //Diary 타입이 되도록 인스턴스화
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }

//MARK: [collection]뷰 속성 정의
    private func configureCollectionView() {
        //FlowLayout 인스턴스 대입
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        //컨텐츠 간격 10
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
//MARK: [Delegate 패턴] Diary 객체 수신
    //세그웨이로 화면전환하기 때문에 prepare 메서드 실행
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //세그웨이로 이동하는 뷰컨트롤러가 무엇인지 작성
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController {
            //delegate 위임
            writeDiaryViewController.delegate = self
        }
    }
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    //데이터 저장
    private func saveDiaryList(){
        let date = self.diaryList.map {
            [
                "title" : $0.title,
                "contents" : $0.contents,
                "date" : $0.date,
                "isStar" : $0.isStar
            ]
        }
        let UD = UserDefaults.standard
        UD.set(date, forKey: "diaryList")
    }
}
//[Delegate 패턴] Diary 객체 수신
extension ViewController : WriteDiaryViewDelegate {
    //Diary 객체 수신
    func didSeletRegister(diary: Diary) {
        self.diaryList.append(diary)
        //배열에 추가된 후, 날짜별로 정리
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
}
//[collection]뷰 속성 정의
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    //cellForItemAt : 컬렉션뷰의 지정된 위치에 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() } //DiaryCell로 다운캐스팅, 다운캐스팅이 실패하면 빈 UICollection셀 반환되도록 구현
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        return cell
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout {
    //셀의 사이즈를 설정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout UICollectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}

//MARK: [디테일뷰] 데이터 전달하기 위해 delegate 선언
extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //스토리보드에 있는 뷰 컨트롤러 인스턴스화, 타입캐스팅
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        //선택한 셀의 값을 diary 변수에 저장
        let diary = self.diaryList[indexPath.row]
        //데이터 전달
        viewController.diary = diary
        viewController.indexPath = indexPath
        //삭제를 위한 델리게이트
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: [디테일뷰] 삭제
extension ViewController : DiaryDetailViewDelegate {
    func didSelectedDelete(indexPath: IndexPath) {
        //전달받은 indexPath.row 값을 배열에서 삭제
        self.diaryList.remove(at: indexPath.row)
        //컬렉션 뷰의 인덱스 삭제
        self.collectionView.deleteItems(at: [indexPath])
    }
}
