//
//  ViewController.swift
//  MyFavorites
//
//  Created by Asanbay on 15.11.2024.
//

import UIKit

class ViewController: UIViewController {

    private var favoriteBooks: [FavoriteItem] = [
        FavoriteItem(
            title: "To Kill a Mockingbird",
            author: "Harper Lee",
            genre: "Classic Fiction",
            coverImage: UIImage(named: "mockingbird")!,
            description: "A powerful novel about racial injustice in the American South, focusing on moral growth and the importance of compassion."
        ),
        FavoriteItem(
            title: "1984",
            author: "George Orwell",
            genre: "Dystopian",
            coverImage: UIImage(named: "1984")!,
            description: "A dystopian tale set in a totalitarian society, exploring the themes of freedom, truth, and the dangers of political repression."
        ),
        FavoriteItem(
            title: "Pride and Prejudice",
            author: "Jane Austen",
            genre: "Romance",
            coverImage: UIImage(named: "pride_and_prejudice")!,
            description: "A romantic and witty novel that examines issues of class, marriage, and personal growth in 19th-century England."
        ),
        FavoriteItem(
            title: "The Great Gatsby",
            author: "F. Scott Fitzgerald",
            genre: "Classic Fiction",
            coverImage: UIImage(named: "gatsby")!,
            description: "A story of love, wealth, and the American Dream, capturing the decadence and excess of the Roaring Twenties."
        ),
        FavoriteItem(
            title: "Moby Dick",
            author: "Herman Melville",
            genre: "Adventure",
            coverImage: UIImage(named: "moby_dick")!,
            description: "A gripping story of obsession and revenge, chronicling the journey of Captain Ahab and his pursuit of the white whale, Moby Dick."
        ),
        FavoriteItem(
            title: "The Catcher in the Rye",
            author: "J.D. Salinger",
            genre: "Classic Fiction",
            coverImage: UIImage(named: "catcher_in_the_rye")!,
            description: "A story of teenage rebellion and self-discovery, narrated by the candid and cynical Holden Caulfield."
        ),
        FavoriteItem(
            title: "The Hobbit",
            author: "J.R.R. Tolkien",
            genre: "Fantasy",
            coverImage: UIImage(named: "hobbit")!,
            description: "A fantasy adventure following Bilbo Baggins on a journey filled with magic, dragons, and the struggle between good and evil."
        ),
        FavoriteItem(
            title: "War and Peace",
            author: "Leo Tolstoy",
            genre: "Historical Fiction",
            coverImage: UIImage(named: "war_and_peace")!,
            description: "An epic novel that intertwines themes of love, power, and sacrifice against the backdrop of Napoleon's invasion of Russia."
        ),
        FavoriteItem(
            title: "Crime and Punishment",
            author: "Fyodor Dostoevsky",
            genre: "Psychological Fiction",
            coverImage: UIImage(named: "crime_and_punishment")!,
            description: "A deep dive into guilt, morality, and redemption, following the journey of a man who commits a crime and grapples with his conscience."
        ),
        FavoriteItem(
            title: "The Alchemist",
            author: "Paulo Coelho",
            genre: "Adventure",
            coverImage: UIImage(named: "alchemist")!,
            description: "A philosophical novel about following your dreams and listening to your heart, set in a mystical journey across the desert."
        )
    ]

    @IBOutlet weak var tableView: UITableView!

        private var selectedBook: FavoriteItem!

        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToDetail",
               let detailVC = segue.destination as? SecondViewController {
                detailVC.configure(with: selectedBook)
            }
        }
    }

    extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteBooks.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
            let book = favoriteBooks[indexPath.row]
            cell.configure(with: book)
            return cell
        }
    }

    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedBook = favoriteBooks[indexPath.row]
            performSegue(withIdentifier: "goToDetail", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
