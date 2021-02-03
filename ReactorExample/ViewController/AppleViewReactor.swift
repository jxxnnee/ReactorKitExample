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
        case tapShowButton
    }
    enum Mutation {
        case setImage(UIImage)
        case isCanShowImage
    }
    struct State {
        var currentImage: UIImage?
        var shouldShowImage: Bool = false
//        var shouldShowImage = RevisionedData<Bool>(data: nil)
    }
    
    var initialState: State
    var provider: ServiceProviderProtocol
    var isCanShowImage = true
    init(provider: ServiceProviderProtocol) {
        self.initialState = State()
        self.provider = provider
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let appleService = self.provider.appleService.event.flatMap {
            E -> Observable<Mutation> in
            switch E {
            case .imageName(let img):
                return .just(.setImage(img))
            }
        }
        
        return Observable.merge(mutation, appleService)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapShowButton:
            return .just(.isCanShowImage)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setImage(let img):
            newState.currentImage = img
        case .isCanShowImage:
            newState.shouldShowImage.toggle()
//            self.isCanShowImage.toggle()
//            newState.shouldShowImage = state.shouldShowImage.update(self.isCanShowImage)
        }
        
        return newState
    }
}
