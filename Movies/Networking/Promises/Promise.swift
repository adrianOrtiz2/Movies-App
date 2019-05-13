//
//  Promise.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/13/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

class Promise<Value>: Future<Value> {
    
    init(value: Value? = nil) {
        super.init()
        guard let value = value else { return }
        // If there is a value report directly
        result = .success(value)
    }
    
    func resolve(with value: Value) {
        result = .success(value)
    }
    
    func reject(with error: Error) {
        result = .failure(error)
    }
    
}
