//
//  MoviesRepository.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/13/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import Foundation

protocol MoviesRepository {
    func getRecentMovies() -> Future<MoviesResponse>
    func getPopularMovies() -> Future<MoviesResponse>
    
}

class ApiMoviesRepository: MoviesRepository {

    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getRecentMovies() -> Future<MoviesResponse> {
        let endpoint = Endpoint.popular()
        return urlSession.request(endpoint).decoded()
    }
    
    func getPopularMovies() -> Future<MoviesResponse> {
        let endpoint = Endpoint.upcoming()
        return urlSession.request(endpoint).decoded()
    }
    
    func searchMovies(_ query: String) -> Future<MoviesResponse> {
        let endpoint = Endpoint.searchMovies(query)
        return urlSession.request(endpoint).decoded()
    }
    
}
