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
    private var viewModel: MovieSectionViewModel? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(with vm: MovieSectionViewModel) {
        viewModel = vm
        collectionView.reloadData()
    }
    
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 1
        }
        return viewModel.numberOfRowsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath)
    }
    
    
}
