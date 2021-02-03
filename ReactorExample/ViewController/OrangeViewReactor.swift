//
//  OrangeViewReactor.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/03.
//

import Foundation
import ReactorKit
import RxSwift

class OrangeViewReactor: Reactor {
    enum Action {
        case setImageForEvent(String)
        case setImageForObserver(String)
    }
    enum Mutation {
        case currentImage(UIImage)
    }
    struct State {
        var image: UIImage?
    }
    
    var initialState: State
    var provider: ServiceProviderProtocol
    init(provider: ServiceProviderProtocol) {
        self.initialState = State()
        self.provider = provider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setImageForEvent(let str):
            self.provider.appleService.setImageForAppleEvent(str)
            return .empty()
        case .setImageForObserver(let str):
            return self.provider.appleService.setImageForAppleObserver(str)
                .map(Mutation.currentImage)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .currentImage(let image):
            newState.image = image
        }
        
        return newState
    }
}
