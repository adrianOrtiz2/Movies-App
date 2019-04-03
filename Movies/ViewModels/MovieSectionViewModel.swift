//
//  MovieSectionViewModel.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/27/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

struct MovieSectionViewModel {
    
    let sectionName: String
    let movies: [MovieCellViewModel]
    
    var numberOfRowsInSection: Int {
        return movies.count
    }
    
}
