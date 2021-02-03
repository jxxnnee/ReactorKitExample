//
//  OrangeViewController.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/03.
//

import Foundation
import RxSwift
import ReactorKit
import SnapKit

class OrangeViewController: UIViewController {
    internal let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContentLayout()
    }
    
    func setContentLayout() {
        self.view.addSubview(self.textField)
        self.textField.snp.makeConstraints({
            $0.center.equalTo(self.view)
            $0.width.equalTo(100)
        })
        
        self.textField.layer.borderWidth = 1.0
        self.textField.layer.borderColor = UIColor.black.cgColor
        self.textField.borderStyle = .roundedRect
    }
}
