//
//  URLSession.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/13/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

extension URLSession {
    
    func request(_ endpoint: Endpoint) -> Future<Data> {
        // Contruct a promise to return as a Future
        let promise = Promise<Data>()
        
        guard let url = endpoint.urlRequest else {
            promise.reject(with: EndpointError.invalidURL)
            return promise
        }
        
        //Perform a data task
        let task = dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    promise.reject(with: error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    promise.reject(with: EndpointError.apiError("No response"))
                    return
                }
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 201 {
                    promise.resolve(with: data ?? Data())
                } else {
                    let defaultMessage = "Request finish with error \(httpResponse.statusCode)"
                    promise.reject(with: EndpointError.apiError(String(data: data ?? Data(), encoding: .utf8) ?? defaultMessage))
                }
            }
        }
        
        task.resume()
        
        return promise
        
    }
    
}
