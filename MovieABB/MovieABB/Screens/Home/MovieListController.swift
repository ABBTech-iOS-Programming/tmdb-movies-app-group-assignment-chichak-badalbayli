//
//  MovieListController.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

import Foundation
import UIKit
import SnapKit

public final class MovieListController: UIViewController {
    
    private var viewModel: MovieListViewModel
    private let viewStateHandler = ViewStateHandler()
    
    //MARK: - UIElements
    
    private let searchView = SearchView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to watch?"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )
        collection.register(
            TrendingMovieCell.self,
            forCellWithReuseIdentifier: TrendingMovieCell.reuseIdentifier
        )
        collection.register(
            MovieListCell.self,
            forCellWithReuseIdentifier: MovieListCell.reuseIdentifier
        )
        collection.register(
            MovieCategoryCell.self,
            forCellWithReuseIdentifier: MovieCategoryCell.reuseIdentifier
        )
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor(named: "backgroundGray")
        return collection
    }()
        
    // MARK: - Init
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadTrending()
        viewModel.loadMovies(category: .popular)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
        view.backgroundColor = UIColor(named: "backgroundGray")
        viewStateHandler.attach(to: self)
    }
    
    private func addSubviews() {
        [
            titleLabel,
            searchView,
            collectionView
        ].forEach(view.addSubview(_:))
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        searchView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            guard let self else { return }
            self.viewStateHandler.handle(state, in: self) {
                self.collectionView.reloadData()
            }
        }
        searchView.onTextChange = { [weak self] text in
            self?.viewModel.searchMovies(query: text)
        }
    }
}

extension MovieListController {

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0: return self.trendingListSection()
            case 1: return self.categorySection()
            case 2: return self.movieListSection()
            default: return nil
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
            bottom: 24,
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
            top: 20,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        return section
    }
    
    func categorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .estimated(1),
                heightDimension: .absolute(41)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .estimated(1),
                heightDimension: .absolute(41)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 20
        section.contentInsets = .init(
            top: 24,
            leading: 24,
            bottom: 20,
            trailing: 0
        )
        return section
    }
}

extension MovieListController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return viewModel.trendingMovies.count
        case 1:
            return MovieCategory.allCases.count
        case 2:
            return viewModel.movies.count
        default:
            return 0
        }
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingMovieCell.reuseIdentifier,
                for: indexPath
            ) as! TrendingMovieCell

            cell.configure(
                with: viewModel.trendingMovies[indexPath.item],
                rank: indexPath.item + 1
            )
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieCategoryCell.reuseIdentifier,
                for: indexPath
            ) as! MovieCategoryCell

            let category = MovieCategory.allCases[indexPath.item]
            cell.configure(
                title: category.title,
                selected: category == viewModel.currentCategory
            )
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieListCell.reuseIdentifier,
                for: indexPath
            ) as! MovieListCell

            cell.configure(with: viewModel.movies[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
extension MovieListController: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.section == 1 else { return }
        let category = MovieCategory.allCases[indexPath.item]
        viewModel.loadMovies(category: category)
        collectionView.reloadData()
    }
}
