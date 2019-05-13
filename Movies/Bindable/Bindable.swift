//
//  Bindable.swift
//  NewTwitter
//
//  Created by Adrian Ortiz on 5/10/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

class Bindable<Value> {
    
    typealias Listener = (Value) -> Void
    
    private var listener: Listener?
    
    var value: Value {
        didSet {
            notify()
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
    }
    
    private func notify() {
        listener?(value)
    }
    
}
