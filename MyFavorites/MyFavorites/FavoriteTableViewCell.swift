//
//  FavoriteTableViewCell.swift
//  MyFavorites
//
//  Created by Asanbay on 15.11.2024.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func configure(with item: FavoriteItem) {
        coverImageView.image = item.coverImage
        titleLabel.text = item.title
    }
}
