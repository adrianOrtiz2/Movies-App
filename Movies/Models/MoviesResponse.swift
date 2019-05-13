//
//  MoviesResponse.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
    let results: [MovieModel]
}
