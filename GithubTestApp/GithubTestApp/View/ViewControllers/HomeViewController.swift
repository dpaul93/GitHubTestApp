//
//  HomeViewController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

class HomeViewController: CustomPresentationViewController {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    var homeViewControllerPresenter: HomeViewPresenterProtocol!
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: RepositoryTableViewCell.self), bundle: Bundle.main)
        repositoriesTableView.register(nib, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
        repositoriesTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // MARK: Actions
    
    @IBAction func didPressCancelButton(_ sender: Any) {
        homeViewControllerPresenter.cancelSearch(withCompletion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewControllerPresenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewControllerPresenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self)) as? RepositoryTableViewCell,
            let data = homeViewControllerPresenter.dataForCell(atIndexPath: indexPath) {
            cell.repositoryDescriptionLabel.text = data.repositoryDescription
            cell.repositoryNameLabel.text = data.fullName
            cell.starredCountLabel.text = String(data.stargazersCount)
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(homeViewControllerPresenter.heightForRow())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let webViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: RepositoryWebViewController.self)) as? RepositoryWebViewController,
            let data = homeViewControllerPresenter.dataForCell(atIndexPath: indexPath) {
            present(webViewController, data: data)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        homeViewControllerPresenter.didRecieveQueryText(searchBar.text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}

extension HomeViewController: HomeViewPresenterDelegate {
    func clearResults() {
        repositoriesTableView.reloadData()
    }
    
    func firstRequestDidFinish(withIndexPathsToInsert indexPaths: [IndexPath]?, error: Error?) {
        if let indexPaths = indexPaths {
            repositoriesTableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func secondRequestDidFinish(withIndexPathsToInsert indexPaths: [IndexPath]?, error: Error?) {
        if let indexPaths = indexPaths {
            repositoriesTableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}
