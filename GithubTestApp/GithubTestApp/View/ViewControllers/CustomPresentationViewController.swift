//
//  CustomPresentationViewController.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

class CustomPresentationViewController: UIViewController {
    func present(_ viewController: RepositoryWebViewController, data: GitHubRepository) {
        viewController.linkToOpen = data.repositoryURL
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension CustomPresentationViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let customSizePresentationController = CustomSizePresentationController(presentedViewController: presented, presenting: presenting)
        customSizePresentationController.frame = view.frame
        return customSizePresentationController
    }
}
