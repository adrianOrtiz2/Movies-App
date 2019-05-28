//
//  URLSessionRequest.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/14/19.
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
    
    func downloadImage(_ url: URL?) -> Future<NSData> {
        // Contruct a promise to return as a Future
        let promise = Promise<NSData>()
        
        guard let url = url else {
            promise.reject(with: EndpointError.invalidURL)
            return promise
        }
        
        // Verify if the image is in cache
        let imageCache = NSCache<NSString, NSData>()
        let cacheKey = url.absoluteString as NSString
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            promise.resolve(with: cachedImage)
            return promise
        }
        // Download image from url
        dataTask(with: NSURLRequest(url: url) as URLRequest) { (data, _, error) in
            DispatchQueue.main.async() { () -> Void in
                guard let data = data, error == nil else {
                    promise.reject(with: error!)
                    return
                }
                let nsdata = NSData(data: data)
                imageCache.setObject(nsdata, forKey: cacheKey)
                promise.resolve(with: nsdata)
            }
        }.resume()
        return promise
    }
    
}
