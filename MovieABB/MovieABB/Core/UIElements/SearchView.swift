//
//  SearchBar.swift
//  MovieABB
//
//  Created by Chichek on 08.01.26.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    
    var onSearch: ((String) -> Void)?
    
    // MARK: - UI
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(named: "searchText")
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor(named: "lineGray")
        textField.returnKeyType = .search
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [
                .foregroundColor: UIColor(named: "searchText")
            ]
        )
        return textField
    }()
    
    private let searchIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = UIColor(named: "searchText")
        image.backgroundColor = UIColor(named: "lineGray")
        return image
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
        backgroundColor = UIColor(named: "lineGray")
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    private func addSubviews() {
        addSubview(textField)
        addSubview(searchIcon)
    }
    
    private func setupConstraints() {
        searchIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(searchIcon.snp.leading).offset(-12)
            make.top.bottom.equalToSuperview()
        }
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        onSearch?(textField.text ?? "")
        return true
    }
}
