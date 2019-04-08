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
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell,
            let vm = viewModel?.movies[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: vm)
        return cell
    }
    
    
}
