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

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    let method: RequestMethod
    
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

extension Endpoint {
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        if method == .get {
            components.queryItems = queryItems
        }
        return components.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        switch method {
        case .post, .put, .delete:
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: queryItems, options: [])
            } catch {
                return nil
            }
        default:
            break
        }
        return request
    }
}

