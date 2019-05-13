//
//  DiscoverViewController.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    private lazy var binding: Bindable<DiscoverViewModel> = {
        return Bindable(viewModel)
    }()
    
    private lazy var viewModel: DiscoverViewModel = {
        return DiscoverViewModel()
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.cellIdentifier)
        // Do any additional setup after loading the view.
        viewModel.getRecentMovies()
        viewModel.moviesSections.bind { [unowned self] _ in
            self.tableView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiscoverViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            fatalError("Not expected cell")
        }
        cell.configureCell(with: viewModel.getViewModelCell(at: indexPath.section))
        return cell
    }
    
    
}
