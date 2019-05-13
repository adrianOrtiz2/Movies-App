//
//  MovieModel.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    
    let id: Int
    let video: Bool
    let votes: Double
    let title: String
    let image: String
    let originTitle: String
    let overview: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case video
        case votes = "vote_average"
        case title
        case image = "poster_path"
        case originTitle = "original_title"
        case overview
        case releaseDate = "release_date"
    }
}
