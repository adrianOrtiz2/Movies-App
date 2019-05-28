//
//  SearchMovieViewController.swift
//  Movies
//
//  Created by Adrian Ortiz on 5/21/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

class SearchMovieViewController: UICollectionViewController {
    
    private let viewModel = SearchMoviesViewModels()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        self.collectionView.register(MovieCollectionViewCell.self)
        viewModel.results.bind {[weak self] _ in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieCollectionViewCell
        
        cell.configureCell(with: viewModel.results.value[indexPath.row])
        return cell
    }

}

extension SearchMovieViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(with: searchController.searchBar.text!)
    }

}
