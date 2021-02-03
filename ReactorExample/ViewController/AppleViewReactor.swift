//
//  AppleViewReactor.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/03.
//

import Foundation
import RxSwift
import ReactorKit

class AppleViewReactor: Reactor {
    enum Action {
    }
    enum Mutation {
        case setImage(UIImage)
    }
    struct State {
        var currentImage: UIImage?
    }
    
    var initialState: State
    var provider: ServiceProviderProtocol
    init(provider: ServiceProviderProtocol) {
        self.initialState = State()
        self.provider = provider
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let appleService = self.provider.appleService.event.flatMap {
            E -> Observable<Mutation> in
            print("ddd")
            switch E {
            case .imageName(let img):
                return .just(.setImage(img))
            }
        }
        
        return Observable.merge(mutation, appleService)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setImage(let img):
            newState.currentImage = img
        }
        
        return newState
    }
}
