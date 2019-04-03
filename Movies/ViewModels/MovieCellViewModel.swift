//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/27/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

struct MovieCellViewModel {
    
    let movie: MovieModel
    
    var numberOfItemsInSection: Int {
        return 1
    }
    
}
