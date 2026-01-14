//
//  MovieListCell.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendingMovieCell: UICollectionViewCell {

    static let reuseIdentifier = "TrendingMovieCell"

    // MARK: - UI

    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        return image
    }()

    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 96)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public functions
    
    func configure(with movie: MovieDTO, rank: Int) {
        rankingLabel.attributedText = NSAttributedString(
            string: "\(rank)",
            attributes: [
                .foregroundColor: UIColor(named: "backgroundGray") ?? UIColor.gray,
                .strokeColor: UIColor.systemBlue,
                .strokeWidth: -1
            ]
        )
        movieImage.loadImage(path: movie.posterPath)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        rankingLabel.text = nil
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [
            movieImage,
            rankingLabel
        ].forEach(contentView.addSubview(_:))
    }
    
    private func setupConstraints() {
        movieImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(210)
        }
        rankingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(40)
        }
    }
}
