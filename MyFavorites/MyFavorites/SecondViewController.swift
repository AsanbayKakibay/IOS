//
//  SecondViewController.swift
//  MyFavorites
//
//  Created by Asanbay on 15.11.2024.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private var inputModel: FavoriteItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Проверка на случай, если inputModel не был установлен
        guard let inputModel = inputModel else {
            print("Ошибка: inputModel не установлен")
            return
        }

        coverImageView.image = inputModel.coverImage
        titleLabel.text = inputModel.title
        descriptionLabel.text = """
        Author: \(inputModel.author)
        Genre: \(inputModel.genre)
        
        Description: \(inputModel.description)
        """
    }

    func configure(with item: FavoriteItem) {
        self.inputModel = item
    }
}
