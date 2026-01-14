//
//  UIImageView.swift
//  MovieABB
//
//  Created by Chichek on 06.01.26.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(path: String?) {
        let url = path.flatMap {
            URL(string: "https://image.tmdb.org/t/p/w500\($0)")
        }
        kf.setImage(
            with: url,
            options: [.transition(.fade(0.25))]
        )
    }
}
