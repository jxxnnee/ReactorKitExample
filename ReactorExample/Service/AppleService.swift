//
//  AppleService.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/04.
//

import Foundation
import RxSwift

enum AppleEvent {
    case imageName(UIImage)
}

protocol AppleServiceProtocol {
    var event: PublishSubject<AppleEvent> { get }
    func setImageForAppleEvent(_ type: String)
    func setImageForAppleObserver(_ type: String) -> Observable<UIImage>
}

class AppleService: BaseService, AppleServiceProtocol {
    var event = PublishSubject<AppleEvent>()
    
    func setImageForAppleEvent(_ type: String) {
        if type == "river" { self.event.onNext(.imageName(#imageLiteral(resourceName: "image_1"))) }
        if type == "lamb" { self.event.onNext(.imageName(#imageLiteral(resourceName: "image_2"))) }
    }
    
    func setImageForAppleObserver(_ type: String) -> Observable<UIImage> {
        return Observable.create { observer in
            if type == "river" { observer.onNext(#imageLiteral(resourceName: "image_1")) }
            if type == "lamb" { observer.onNext(#imageLiteral(resourceName: "image_2")) }
            
            return Disposables.create()
        }
    }
}
