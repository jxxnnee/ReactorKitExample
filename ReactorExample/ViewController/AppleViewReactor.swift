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
        case increase
        case decrease
    }
    enum Mutation {
        case increaseValue
        case decreaseValue
    }
    struct State {
        var value = 0
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return .just(.increaseValue)
        case .decrease:
            return .just(.decreaseValue)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .increaseValue:
            newState.value = state.value + 1
        case .decreaseValue:
            newState.value = state.value - 1
        }
        
        return newState
    }
}
