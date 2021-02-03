//
//  OrangeViewController+Rx.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/03.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: OrangeViewController {
    var setUserName: ControlEvent<String> {
        let source = base.textField.rx.text.orEmpty.distinctUntilChanged()
        return ControlEvent(events: source)
    }
}
