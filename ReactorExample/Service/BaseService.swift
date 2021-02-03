//
//  BaseService.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/03.
//

import Foundation

class BaseService {
    unowned let provider: ServiceProviderProtocol

    init(provider: ServiceProviderProtocol) {
      self.provider = provider
    }
}
