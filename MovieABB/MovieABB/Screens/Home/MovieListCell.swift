//
//  MovieListCell.swift
//  MovieABB
//
//  Created by Chichek on 07.01.26.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieListCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieListCell"
    
    // MARK: - UI
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    func configure(with movie: MovieDTO) {
        posterImageView.loadImage(path: movie.posterPath)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
    }
    
    private func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(145)
        }
    }
}
