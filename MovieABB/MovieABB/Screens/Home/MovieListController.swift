//
//  MovieListController.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

import Foundation
import UIKit

public final class MovieListController: UIViewController {
    
    //MARK: - UIElements
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )
        collection.register(
            MovieListCell.self,
            forCellWithReuseIdentifier: MovieListCell.id
        )
        collection.dataSource = self
        return collection
    }()
        
    // MARK: - Init
    
//    init(viewModel: PostDetailViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
        view.backgroundColor = .gray
    }
    
    private func addSubviews() {
        [
            collectionView
        ].forEach(view.addSubview(_:))
    }
    
    private func setupConstraints() {

    }
}

extension MovieListController {

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.trendingListSection()
            } else {
                return self.movieListSection()
            }
        }
    }

    func trendingListSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .absolute(210)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 30
        section.contentInsets = .init(
            top: 21,
            leading: 24,
            bottom: 64,
            trailing: 24
        )
        return section
    }

    func movieListSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0 / 3.0),
                heightDimension: .absolute(145)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(145)
            ),
            subitems: [item]
        )
        group.interItemSpacing = .fixed(12)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 18
        section.contentInsets = .init(
            top: 64,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        return section
    }
}

extension MovieListController: UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        section == 0 ? 5 : 12
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCell.id,
            for: indexPath
        )
    }
}
