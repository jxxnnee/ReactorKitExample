//
//  ServiceProvider.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/03.
//

import Foundation

protocol ServiceProviderProtocol: class {
    var appleService: AppleServiceProtocol { get }
}

final class ServiceProvider: ServiceProviderProtocol {
    static let shared = ServiceProvider()
    // Reactor들이 공통적인 스트림을 제공 받아야 하기때문에
    // 하나의 객체로 서비스를 제공받도록 싱글톤 패턴으로 구현했다.
    
    lazy var appleService: AppleServiceProtocol = AppleService(provider: self)
}
