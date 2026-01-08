//
//  MovieCategoryView.swift
//  MovieABB
//
//  Created by Chichek on 07.01.26.
//

import UIKit
import SnapKit

final class MovieCategoryCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieCategoryCell"
    
    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineGray")
        view.isHidden = true
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, selected: Bool) {
        titleLabel.text = title
        underlineView.isHidden = !selected
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(underlineView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(2)
            make.bottom.equalToSuperview()
        }
    }
}

