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
        case userName(String)
    }
    struct State {
        var value = 0
        var userName = ""
    }
    
    var initialState: State
    var currentUser: PublishSubject<String>
    
    init() {
        self.initialState = State()
        self.currentUser = PublishSubject<String>()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation, self.currentUser.map(Mutation.userName))
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
        case .userName(let str):
            newState.userName = str
        }
        
        return newState
    }
}
