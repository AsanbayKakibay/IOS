//
//  FavoriteItemProtocol.swift
//  MyFavoritiesFinal
//
//  Created by Asanbay on 15.11.2024.
//

import UIKit

protocol FavoriteItemProtocol {
    var title: String { get }
    var description: String { get }
    var coverImage: UIImage { get }
}

struct BooksItem: FavoriteItemProtocol {
    let title: String
    let author: String
    let genre: String
    let coverImage: UIImage
    let description: String
}

struct FilmsItem: FavoriteItemProtocol {
    let title: String
    let year: String
    let genre: String
    let coverImage: UIImage
    let description: String
}

struct MusicsItem: FavoriteItemProtocol {
    let title: String
    let artist: String
    let genre: String
    let coverImage: UIImage
    let description: String
}
