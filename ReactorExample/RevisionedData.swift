//
//  RevisionedData.swift
//  ReactorExample
//
//  Created by 민경준 on 2021/02/04.
//

import Foundation

struct RevisionedData<T>: Equatable {
    static func == (lhs: RevisionedData, rhs: RevisionedData) -> Bool {
        return lhs.revision == rhs.revision
    }
    
    fileprivate let revision: UInt
    let data: T?
    
    init(revision: UInt, data: T?) {
        self.revision = revision
        self.data = data
    }
    init(data: T?) {
        self.revision = 0
        self.data = data
    }
}

extension RevisionedData {
    func update(_ data: T?) -> RevisionedData {
        return RevisionedData(revision: self.revision + 1, data: data)
    }
}
