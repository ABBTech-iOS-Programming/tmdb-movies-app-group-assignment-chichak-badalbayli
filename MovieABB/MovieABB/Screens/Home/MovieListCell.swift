//
//  MovieListCell.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

import Foundation
import UIKit

final class MovieListCell: UICollectionViewCell {
    static let id = "MovieCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 12
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
