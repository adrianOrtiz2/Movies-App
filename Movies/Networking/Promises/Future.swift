//
//  Future.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/13/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

class Future<Value> {
    
    typealias FutureResult = Result<Value, Error>
    
    var result: FutureResult? {
        // Observe whenever a result is assigned, and report it
        didSet {
            result.map(report)
        }
    }
    
    private lazy var callbacks = [(FutureResult) -> Void]()
    
    func observe(with callback: @escaping (FutureResult) -> Void) {
        callbacks.append(callback)
        // If a result has already been set, call the callback directly
        result.map(callback)
    }
    
    private func report(result: FutureResult) {
        for callback in callbacks {
            callback(result)
        }
    }
    
}

// MARK: - Chaining
extension Future {
    
    private func chained<NextValue>(with closure: @escaping (FutureResult) throws -> Future<NextValue>) -> Future<NextValue> {
        //Promise wrapper
        let promise = Promise<NextValue>()
        
        // Observe the current future
        observe { result in
            switch result {
            case .success(let value):
                do {
                    // Attempt to construct a new future given the value from the first one
                    let future = try closure(.success(value))
                    
                    //Observe the neasted futuare and once is completed resolve wrapper future
                    future.observe(with: { result in
                        switch result {
                        case .success(let value):
                            promise.resolve(with: value)
                        case .failure(let error):
                            promise.reject(with: error)
                        }
                    })
                } catch {
                    promise.reject(with: error)
                }
                break
            case .failure(let error):
                promise.reject(with: error)
            }
        }
        
        return promise
    }
    
}

// MARK: - Transforms
extension Future {
    
    private func transformed<NextValue>(with closure: @escaping (FutureResult) throws -> NextValue) -> Future<NextValue> {
        return chained(with: { value in
            return try Promise(value: closure(value))
        })
    }
}

// MARK: - Decode
extension Future where Value == Data {
    func decoded<NextValue: Decodable>() -> Future<NextValue> {
        return transformed {
            try JSONDecoder().decode(NextValue.self, from: $0.get())
        }
    }
}

extension Future where Value == NSData {
    func decodeImage() -> Future<UIImage> {
        return transformed {
            guard let image = try UIImage(data: Data(referencing: $0.get())) else {
                throw EndpointError.invalidURL
            }
            return image
        }
    }
}
