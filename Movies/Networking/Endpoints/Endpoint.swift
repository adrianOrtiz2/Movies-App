//
//  Endpoint.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/13/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

enum EndpointError: Error, LocalizedError {
    case invalidURL
    case apiError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The url is invalid"
        case .apiError(let msg):
            return msg
        }
    }
}

struct Endpoint: URLBuilder {

    let path: String
    let queryParams: [URLQueryItem]?
    let bodyParams: [String : Any]?
    let method: RequestMethod
    let headers: [String: String]?
    
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    init(path: String, method: RequestMethod, bodyParams: [String : Any]? = nil, headers: [String : String]? = nil, queryParams: [URLQueryItem]? = nil) {
        self.path = path
        self.bodyParams = bodyParams
        self.method = method
        self.headers = headers
        self.queryParams = queryParams
    }
}
