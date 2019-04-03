//
//  MoviesRequest.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesRequest: URLRequestBuilder {

    case popular
    case recent
    case upcoming
    
    // MARK: - Paths
    internal var path: ServerPaths {
        switch self {
        case .popular:
            return .popular
        case .recent:
            return .recent
        case .upcoming:
            return .upcoming
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case .popular:
            break
        case .recent:
            params["api_key"] = token
            break
        case .upcoming:
            params["api_key"] = token
            break
        }
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        return .get
    }
    
}
