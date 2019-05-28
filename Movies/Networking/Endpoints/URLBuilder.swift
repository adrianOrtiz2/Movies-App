//
//  URLBuilder.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/14/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

protocol URLBuilder {
    
    var queryParams: [URLQueryItem]? { get }
    var bodyParams: [String: Any]? { get }
    var defaultHeaders: [String: String] { get }
    var defaultQueryItems: [URLQueryItem] { get }
    var url: URL? { get }
    var path: String { get }
    var method: Endpoint.RequestMethod { get }
    var urlRequest: URLRequest? { get }
    var headers: [String: String]? { get }
    
}

extension URLBuilder {
    
    var defaultHeaders: [String: String] {
        var headers = [String: String]()
        headers["application/json"] = "Content-Type"
        return headers
    }
    
    var defaultQueryItems: [URLQueryItem] {
        var params = [URLQueryItem]()
        params.append(
            URLQueryItem(name: "api_key", value: "76167e0900ebd22b448cb7775ab2c446"))
        return params
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        if method == .get {
            components.queryItems = (queryParams ?? []) + defaultQueryItems
        }
        return components.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        print(url.absoluteString)
        request.httpMethod = method.rawValue
        // Setup headers
        let requestHeaders = defaultHeaders.merging(headers ?? [:], uniquingKeysWith: { (current, _) -> String in
            current
        })
        for header in requestHeaders {
            request.setValue(header.key, forHTTPHeaderField: header.value)
        }
        // Setup params
        switch method {
        case .post, .put, .delete:
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParams ?? [], options: [])
            } catch { print("Empty params: \(error.localizedDescription)") }
        default:
            break
        }
        return request
    }
    
}
