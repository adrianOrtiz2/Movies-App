//
//  SearchMoviesViewModel.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/21/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

class SearchMoviesViewModels {
    
    private var pendingRequest: DispatchWorkItem?
    private let repository = ApiMoviesRepository()
    var results: Bindable<[MovieCellViewModel]> = Bindable([])
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return results.value.count
    }
    
    func search(with query: String) {
        if query.isEmpty { return }
        pendingRequest?.cancel()
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.repository.searchMovies(query).observe { [weak self] (response) in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let value):
                    self?.results.value = value.results.map{ MovieCellViewModel(movie: $0) }
                }
            }
        }
        pendingRequest = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(350), execute: requestWorkItem)
    }
    
}
