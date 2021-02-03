//
//  ViewController.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class AppleViewController: UIViewController, StoryboardView {
    internal var disposeBag = DisposeBag()
    let orangeViewController = OrangeViewController()
    internal var imageView = UIImageView()
    
    
    @IBOutlet weak var persentButton: UIButton!
    internal var showButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        orangeViewController.reactor = OrangeViewReactor(provider: ServiceProvider.shared)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints({
            $0.width.height.equalTo(300)
            $0.center.equalToSuperview()
        })
        
        self.imageView.backgroundColor = .black
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        
        self.view.addSubview(self.showButton)
        self.showButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.imageView.snp.bottom).offset(50)
        })
        
        self.showButton.setTitleColor(.black, for: .normal)
        self.showButton.setTitle("HIDE IMAGE", for: .normal)
    }
    
    func bind(reactor: AppleViewReactor) {
        self.persentButton.rx.tap
            .subscribe(onNext: { _ in
                self.present(self.orangeViewController, animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
        
        self.showButton.rx.tap
            .map { Reactor.Action.tapShowButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.shouldShowImage }
            .do(onNext: {
                print("shouldShowImage", $0)
                let title = $0 ? "HIDE IMAGE" : "SHOW IMAGE"
                self.showButton.setTitle(title, for: .normal)
            })
            .map { $0 ? 1.0 : 0.0 }
            .bind(to: self.imageView.rx.alpha)
            .disposed(by: self.disposeBag)
        
//        reactor.state
//            .map { $0.shouldShowImage }
//            .distinctUntilChanged()
//            .subscribe(onNext: {
//                guard let val = $0.data else { return }
//
//                print("shouldShowImage", val)
//                let title = val ? "HIDE IMAGE" : "SHOW IMAGE"
//                self.showButton.setTitle(title, for: .normal)
//                self.imageView.alpha = val ? 1.0 : 0.0
//            })
//            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.currentImage }
            .bind(to: self.imageView.rx.image)
            .disposed(by: self.disposeBag)
    }
}

