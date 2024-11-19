//
//  MusicsViewController.swift
//  MyFavoritiesFinal
//
//  Created by Asanbay on 15.11.2024.
//

import UIKit

class MusicsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var favoriteMusic: [MusicsItem] = [
        MusicsItem(
            title: "Bohemian Rhapsody",
            artist: "Queen",
            genre: "Rock",
            coverImage: UIImage(named: "bohemian_rhapsody")!,
            description: "An epic rock opera blending multiple styles, showcasing Freddie Mercury's incredible vocal range and musical genius."
        ),
        MusicsItem(
            title: "Imagine",
            artist: "John Lennon",
            genre: "Pop, Rock",
            coverImage: UIImage(named: "imagine")!,
            description: "A timeless anthem for peace and unity, inspiring generations with its hopeful lyrics and soothing melody."
        ),
        MusicsItem(
            title: "Stairway to Heaven",
            artist: "Led Zeppelin",
            genre: "Rock",
            coverImage: UIImage(named: "stairway_to_heaven")!,
            description: "A legendary rock ballad combining mystical lyrics and a gradual crescendo of instrumental brilliance."
        ),
        MusicsItem(
            title: "Billie Jean",
            artist: "Michael Jackson",
            genre: "Pop",
            coverImage: UIImage(named: "billie_jean")!,
            description: "A defining track of the King of Pop, with an unforgettable bassline and electrifying rhythm."
        ),
        MusicsItem(
            title: "Smells Like Teen Spirit",
            artist: "Nirvana",
            genre: "Grunge, Rock",
            coverImage: UIImage(named: "smells_like_teen_spirit")!,
            description: "An anthem of Generation X, driving the grunge revolution with its raw energy and rebellious spirit."
        ),
        MusicsItem(
            title: "Hey Jude",
            artist: "The Beatles",
            genre: "Rock",
            coverImage: UIImage(named: "hey_jude")!,
            description: "A heartfelt song of comfort and hope, building to an iconic sing-along climax."
        ),
        MusicsItem(
            title: "Like a Rolling Stone",
            artist: "Bob Dylan",
            genre: "Folk Rock",
            coverImage: UIImage(named: "like_a_rolling_stone")!,
            description: "A groundbreaking track blending poetic lyrics with a raw, powerful sound, redefining modern music."
        ),
        MusicsItem(
            title: "Hotel California",
            artist: "Eagles",
            genre: "Rock",
            coverImage: UIImage(named: "hotel_california")!,
            description: "A haunting tale with intricate guitar solos and a reflective view of the American Dream."
        ),
        MusicsItem(
            title: "Shape of You",
            artist: "Ed Sheeran",
            genre: "Pop",
            coverImage: UIImage(named: "shape_of_you")!,
            description: "A chart-topping hit with catchy melodies, blending pop with tropical house influences."
        ),
        MusicsItem(
            title: "Rolling in the Deep",
            artist: "Adele",
            genre: "Pop, Soul",
            coverImage: UIImage(named: "rolling_in_the_deep")!,
            description: "A soulful track showcasing Adele's powerful voice, telling a story of heartbreak and resilience."
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

extension MusicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMusic.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
        let item = favoriteMusic[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

extension MusicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = favoriteMusic[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
