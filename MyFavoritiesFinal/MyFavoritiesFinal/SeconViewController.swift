//
//  SeconViewController.swift
//  MyFavoritiesFinal
//
//  Created by Asanbay on 15.11.2024.
//

import UIKit

class SecondViewController: UIViewController {

    // Outlets для UI-элементов
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    // Хранение переданного элемента
    private var item: FavoriteItemProtocol?

    // Метод для настройки контроллера перед отображением
    func configure(with item: FavoriteItemProtocol) {
        self.item = item
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    // Обновление интерфейса с использованием данных item
    private func updateUI() {
        guard let item = item else {
            print("No item provided")
            return
        }

        titleLabel.text = item.title
        descriptionLabel.text = item.description
        coverImageView.image = item.coverImage
        if let book = item as? BooksItem {
                    firstDescriptionLabel.text = "Author: \(book.author), Genre: \(book.genre)"
                } else if let music = item as? MusicsItem {
                    firstDescriptionLabel.text = "Artist: \(music.artist), Genre: \(music.genre)"
                } else if let film = item as? FilmsItem {
                    firstDescriptionLabel.text = "Year: \(film.year), Genre: \(film.genre)"
                }
    }
}

