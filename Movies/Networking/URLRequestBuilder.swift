//
//  URLRequestBuilder.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible, APIRequestHandler {
    
    // MARK: - Main URLs
    var baseURL: URL { get }
    
    var requestURL: URL { get }
    
    var urlRequest: URLRequest { get }
    
    // MARK: - Path
    var path: ServerPaths { get }
    
    var headers: HTTPHeaders { get }
    
    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    // MARK: -
    var method: HTTPMethod { get }
    
    var enconding: ParameterEncoding { get }
}

extension URLRequestBuilder {
    var enconding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var requestURL: URL {
        return baseURL.appendingPathComponent(path.rawValue, isDirectory: false)
    }
    
    var token: String {
        return "76167e0900ebd22b448cb7775ab2c446"
    }
    
    var headers: HTTPHeaders {
        let header = HTTPHeaders()
        // Uncomment to add a header token
        // header["Authorization"] = "Bearer \(token)"
        return header
    }
    
    var defaultParams: Parameters {
        return Parameters()
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        print(urlRequest.url ?? "")
        return try enconding.encode(urlRequest, with: parameters)
    }
}
