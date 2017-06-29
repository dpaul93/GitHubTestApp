//
//  TabBarControllerExtension.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import UIKit

extension UITabBarController {
    func getCurrentViewController() -> UIViewController? {
        let index = selectedIndex == NSNotFound ? 0 : selectedIndex
        return viewControllers?[index]
    }
    
    func setupViewControllersWithDI() {
        guard let viewControllers = viewControllers else  {return }
        let apiManager = APIManager()
        let dataManager = DataManager()
        
        for controller in viewControllers {
            var basePresenter: BasePresenterProtocol?
            if let homeViewController = controller as? HomeViewController {
                let homeViewPresenter = HomeViewPresenter()
                basePresenter = homeViewPresenter
                homeViewPresenter.delegate = homeViewController
                homeViewController.homeViewControllerPresenter = homeViewPresenter
            } else if let storedViewControler = controller as? StoredViewController {
                let storedViewControllerPresenter = StoredViewPresenter()
                basePresenter = storedViewControllerPresenter
                storedViewControllerPresenter.delegate = storedViewControler
                storedViewControler.storedViewControllerPresenter = storedViewControllerPresenter
            }
            basePresenter?.apiManager = apiManager
            basePresenter?.dataManager = dataManager
        }
    }
}
