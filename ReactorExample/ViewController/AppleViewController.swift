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
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var decrease: UIButton!
    @IBOutlet weak var increase: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bind(reactor: AppleViewReactor) {
        self.increase.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.decrease.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { "\($0.value)" }
            .bind(to: self.value.rx.text)
            .disposed(by: self.disposeBag)
    }
}

