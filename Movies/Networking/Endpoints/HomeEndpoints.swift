//
//  HomeEndpoints.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/13/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

extension Endpoint {
    
    static func popular() -> Endpoint {
        return Endpoint(path: "/3/movie/popular", method: .get)
    }
    
    static func upcoming() -> Endpoint {
        return Endpoint(path: "/3/movie/upcoming", method: .get)
    }
    
    static func searchMovies(_ query: String) -> Endpoint {
        return Endpoint(path: "/3/search/movie", method: .get, bodyParams: nil, headers: nil, queryParams: [URLQueryItem(name: "query", value: query)])
    }
}
