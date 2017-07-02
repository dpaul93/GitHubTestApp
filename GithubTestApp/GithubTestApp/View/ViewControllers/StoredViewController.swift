//
//  StoredViewController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

class StoredViewController: CustomPresentationViewController {
    
    @IBOutlet weak var storedTableView: UITableView!
    
    var storedViewControllerPresenter: StoredViewPresenterProtocol!
    
    // MARK: Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: RepositoryTableViewCell.self), bundle: Bundle.main)
        storedTableView.register(nib, forCellReuseIdentifier: String(describing: RepositoryTableViewCell.self))
        storedTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storedTableView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func didPressTrashButton(_ sender: Any) {
        storedViewControllerPresenter.removeAllData()
    }
}

extension StoredViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storedViewControllerPresenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedViewControllerPresenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self)) as? RepositoryTableViewCell,
            let data = storedViewControllerPresenter.dataForCell(atIndexPath: indexPath) {
        
            cell.repositoryDescriptionLabel.text = data.repositoryDescription
            cell.repositoryNameLabel.text = data.fullName
            cell.starredCountLabel.text = String(data.stargazersCount)
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(storedViewControllerPresenter.heightForRow())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let webViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: RepositoryWebViewController.self)) as? RepositoryWebViewController,
            let data = storedViewControllerPresenter.dataForCell(atIndexPath: indexPath) {
            present(webViewController, data: data)
        }
    }
}

extension StoredViewController: StoredViewPresenterDelegate {
    func didReloadData() {
        storedTableView.reloadData()
    }
}
