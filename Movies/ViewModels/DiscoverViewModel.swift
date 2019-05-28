//
//  DiscoverViewModel.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

class DiscoverViewModel {
    
    var moviesSections: Bindable<[MovieSectionViewModel]> = Bindable([])
    
    private let apiRepository = ApiMoviesRepository()
    
    var numberOfSections: Int {
        return moviesSections.value.count
    }
    
    var numberOfRowsInSection: Int {
        return 1
    }
    
    func getHomeMovies() {
        apiRepository.getRecentMovies().observe { [weak self] (response) in
            switch response {
            case .failure(let error):
                    print(error.localizedDescription)
            case .success(let value):
                let section = MovieSectionViewModel(sectionName: "Most recent", movies: value.results.map{ MovieCellViewModel(movie: $0) })
                self?.moviesSections.value.append(section)
            }
        }
        
        apiRepository.getPopularMovies().observe {[weak self] (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let section = MovieSectionViewModel(sectionName: "Most popular", movies: value.results.map{ MovieCellViewModel(movie: $0) })
                self?.moviesSections.value.append(section)
            }
        }
        
    }
    
    func getViewModelCell(at position: Int) -> MovieSectionViewModel {
        return moviesSections.value[position]
    }
    
}
