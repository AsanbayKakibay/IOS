//
//  FilmsViewController.swift
//  MyFavoritiesFinal
//
//  Created by Asanbay on 15.11.2024.
//


import UIKit

class FilmsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var favoriteFilms: [FilmsItem] = [
        FilmsItem(
            title: "The Shawshank Redemption",
            year: "1994",
            genre: "Drama",
            coverImage: UIImage(named: "shawshank")!,
            description: "A story of hope and friendship in a harsh prison, as Andy Dufresne finds ways to survive and inspire others."
        ),
        FilmsItem(
            title: "The Godfather",
            year: "1972",
            genre: "Crime, Drama",
            coverImage: UIImage(named: "godfather")!,
            description: "An iconic tale of a powerful mafia family, focusing on loyalty, power, and the moral costs of leadership."
        ),
        FilmsItem(
            title: "Inception",
            year: "2010",
            genre: "Sci-Fi, Action",
            coverImage: UIImage(named: "inception")!,
            description: "A mind-bending thriller about dreams within dreams, led by a skilled extractor trying to achieve redemption."
        ),
        FilmsItem(
            title: "The Dark Knight",
            year: "2008",
            genre: "Action, Crime, Drama",
            coverImage: UIImage(named: "dark_knight")!,
            description: "A gritty exploration of chaos and heroism as Batman faces his most dangerous foe, the Joker."
        ),
        FilmsItem(
            title: "Pulp Fiction",
            year: "1994",
            genre: "Crime, Drama",
            coverImage: UIImage(named: "pulp_fiction")!,
            description: "A stylized anthology of interconnected stories about crime, redemption, and dark humor."
        ),
        FilmsItem(
            title: "Forrest Gump",
            year: "1994",
            genre: "Drama, Romance",
            coverImage: UIImage(named: "forrest_gump")!,
            description: "The life of a simple man who witnesses and influences key historical moments while searching for love and happiness."
        ),
        FilmsItem(
            title: "The Matrix",
            year: "1999",
            genre: "Sci-Fi, Action",
            coverImage: UIImage(named: "matrix")!,
            description: "A revolutionary sci-fi story about a hacker who discovers the reality of human existence is a simulated dream."
        ),
        FilmsItem(
            title: "Fight Club",
            year: "1999",
            genre: "Drama",
            coverImage: UIImage(named: "fight_club")!,
            description: "A psychological drama exploring identity, consumerism, and rebellion through the lens of an underground fight club."
        ),
        FilmsItem(
            title: "The Lord of the Rings: The Return of the King",
            year: "2003",
            genre: "Fantasy, Adventure",
            coverImage: UIImage(named: "lotr_return")!,
            description: "The epic conclusion to the battle for Middle-earth, where courage, friendship, and sacrifice shape the fate of the world."
        ),
        FilmsItem(
            title: "Interstellar",
            year: "2014",
            genre: "Sci-Fi, Adventure, Drama",
            coverImage: UIImage(named: "interstellar")!,
            description: "A visually stunning exploration of space and time as a group of astronauts seeks a new home for humanity."
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let detailVC = segue.destination as? SecondViewController,
               let selectedItem = sender as? FavoriteItemProtocol {
                detailVC.configure(with: selectedItem)
            }
        }
    }

}

extension FilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteFilms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        let item = favoriteFilms[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

extension FilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = favoriteFilms[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
