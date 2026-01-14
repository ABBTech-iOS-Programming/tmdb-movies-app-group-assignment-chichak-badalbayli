//
//  TabBarController.swift
//  MovieABB
//
//  Created by Chichek on 07.01.26.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }

    private func setupTabs() {
        let homeVC = MovieListController(
            viewModel: MovieListViewModel()
        )
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .black
        searchVC.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )

        let watchlistVC = UIViewController()
        watchlistVC.view.backgroundColor = .black
        watchlistVC.tabBarItem = UITabBarItem(
            title: "Watchlist",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )
        viewControllers = [
            homeVC,
            searchVC,
            watchlistVC
        ]
    }

    private func setupAppearance() {
        tabBar.barTintColor = UIColor(named: "backgroundGray")
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
    }
}

