//
//  RoundButton.swift
//  FastCampProject
//
//  Created by lavaspoon on 2021/10/11.
//

import UIKit

//변경된 설정값을 스토리보드에서 실시간으로 확인할 수 있게 해줌
@IBDesignable
class RoundButton: UIButton {
    //@IBInspectable : 스토리보드에서도 isRound 프로퍼티 값을 변경할 수 있도록 해줌
    @IBInspectable var isRound : Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
