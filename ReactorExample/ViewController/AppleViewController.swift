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
        
    }
    
    func bind(reactor: AppleViewReactor) {
        self.persentButton.rx.tap
            .subscribe(onNext: { _ in
                self.present(self.orangeViewController, animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.currentImage }
            .bind(to: self.imageView.rx.image)
            .disposed(by: self.disposeBag)
    }
}

