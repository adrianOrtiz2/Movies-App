//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/27/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "movieTableViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: Bindable<MovieSectionViewModel>?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(MovieCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(with vm: MovieSectionViewModel) {
        viewModel = Bindable(vm)
        viewModel?.bind(listener: {[weak self] _ in
            self?.collectionView.reloadData()
        })
    }
    
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.value.numberOfRowsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieCollectionViewCell
        
        guard let vm = viewModel?.value.movies[indexPath.row] else {
            fatalError("Unexpected view model")
        }

        cell.configureCell(with: vm)
        return cell
    }
    
    
}
