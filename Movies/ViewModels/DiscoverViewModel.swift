//
//  DiscoverViewModel.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

class DiscoverViewModel {
    
    private var moviesSections: [MovieSectionViewModel] = []
    private let completationHandler: () -> Void
    
    init(completationHandler: @escaping () -> Void) {
        self.completationHandler = completationHandler
    }
    
    var numberOfSections: Int {
        return moviesSections.count
    }
    
    var numberOfRowsInSection: Int {
        return 1
    }
    
    func getRecentMovies() {
        MoviesRequest.upcoming.send(MoviesResponse.self) { [weak self] (response) in
            switch response {
            case .failure(let error):
                print(error?.localizedDescription)
                break
            case .success(let value):
                let section = MovieSectionViewModel(sectionName: "Most popular", movies: value.results.map{ MovieCellViewModel(movie: $0) })
                self?.moviesSections.append(section)
                self?.completationHandler()
                break
            }
        }
    }
    
    func getViewModelCell(at position: Int) -> MovieSectionViewModel {
        return moviesSections[position]
    }
    
}
