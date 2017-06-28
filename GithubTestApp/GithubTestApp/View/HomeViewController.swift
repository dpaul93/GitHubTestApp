//
//  HomeViewController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.frame.origin.y = repositoriesTableView.frame.minY - searchController.searchBar.frame.height
        self.view.addSubview(searchController.searchBar)

    }
    
    

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
    
    // MARK: UITableViewDelegate

}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

//extension HomeViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // prevent search bar from scrolling to the bottom
//        let yPosition = scrollView.contentOffset.y >= 0 ? scrollView.contentOffset.y : 0
//        scrollView.contentOffset.y = yPosition
//    }
//}
