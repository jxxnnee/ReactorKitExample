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

class OrangeViewController: UIViewController, StoryboardView {
    internal var disposeBag: DisposeBag = DisposeBag()
    internal let textField = UITextField()
    internal let imageView = UIImageView()
    internal let orangeButton = UIButton()
    internal let appleButton = UIButton()
    
    internal var orangeBool = false
    internal var appleBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setContentLayout()
    }
    
    func setContentLayout() {
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints({
            $0.width.height.equalTo(300)
            $0.center.equalToSuperview()
        })
        
        self.imageView.backgroundColor = .black
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        
        self.view.addSubview(self.orangeButton)
        self.orangeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.imageView.snp.bottom).offset(50)
        }
        self.view.addSubview(self.appleButton)
        self.appleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.orangeButton.snp.bottom).offset(50)
        }
        
        self.orangeButton.setTitleColor(.black, for: .normal)
        self.orangeButton.setTitle("CHANGE ORANGE IMAGE", for: .normal)
        self.appleButton.setTitleColor(.black, for: .normal)
        self.appleButton.setTitle("CHANGE APPLE IMAGE", for: .normal)
    }
    
    func bind(reactor: OrangeViewReactor) {
        self.orangeButton.rx.tap
            .map { _ -> Reactor.Action in
                self.orangeBool.toggle()
                
                let imgString = self.orangeBool ? "river" : "lamb"
                return Reactor.Action.setImageForObserver(imgString)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.appleButton.rx.tap
            .map { _ -> Reactor.Action in
                self.appleBool.toggle()
                
                let imgString = self.appleBool ? "river" : "lamb"
                return Reactor.Action.setImageForEvent(imgString)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.image }
            .bind(to: self.imageView.rx.image)
            .disposed(by: self.disposeBag)
    }
}
