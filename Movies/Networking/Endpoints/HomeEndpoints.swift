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
        return Endpoint(path: "/3/movie/popular", queryItems: [
            URLQueryItem(name: "api_key", value: "76167e0900ebd22b448cb7775ab2c446")
            ], method: .get)
    }
}
