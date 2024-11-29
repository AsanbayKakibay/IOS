//
//  ViewController.swift
//  HeroRandomizer
//
//  Created by Asanbay on 28.11.2024.
//


import UIKit

struct Hero: Decodable {
    let name: String
    let images: Images
    let biography: Biography
    let powerstats: PowerStats
}
struct Images: Decodable {
        let lg: String
}
    
struct Biography: Decodable {
    let fullName: String
}

struct PowerStats: Decodable {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
}

class ViewController: UIViewController {
    @IBOutlet private weak var heroImage: UIImageView!
    @IBOutlet private weak var heroTitle: UILabel!
    @IBOutlet private weak var heroDescription: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var heroButton: UIButton!
    
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var durabilityLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var combatLabel: UILabel!
    
    @IBOutlet private weak var intelligenceProgress: CircularProgressBar!
    @IBOutlet private weak var strengthProgress: CircularProgressBar!
    @IBOutlet private weak var speedProgress: CircularProgressBar!
    @IBOutlet private weak var durabilityProgress: CircularProgressBar!
    @IBOutlet private weak var powerProgress: CircularProgressBar!
    @IBOutlet private weak var combatProgress: CircularProgressBar!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    @IBAction func heroRollDidTap(_ sender: UIButton) {
        let randomId = Int.random(in: 1...731)
        fetchHero(by: randomId)
    }
    
    private func fetchHero(by id: Int) {
        activityIndicator.startAnimating()
        let urlString = "https://akabab.github.io/superhero-api/api/id/\(id).json"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.heroTitle.text = "Error fetching hero"
                    self.heroDescription.text = "Error: \(error.localizedDescription)"
                    self.heroImage.image = nil
                    self.ratingLabel.text = ""
                }
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.handleHeroData(data: data)
            }
        }.resume()
    }
    
    private func handleHeroData(data: Data) {
        do {
            // Логируем ответ для отладки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Hero data: \(jsonString)")  // Логируем данные перед декодированием
            }

            let hero = try JSONDecoder().decode(Hero.self, from: data)
            DispatchQueue.main.async {
                self.heroTitle.text = hero.name
                self.heroDescription.text = "\(hero.biography.fullName)"
                self.heroImage.layer.cornerRadius = self.heroImage.bounds.width / 2.5
                self.heroImage.clipsToBounds = true

                self.loadImage(from: hero.images.lg)

                let averageRating = self.calculateAverageRating(for: hero.powerstats)
                self.ratingLabel.text = "Rating: \(averageRating)"

                self.intelligenceProgress.setProgress(CGFloat(min(hero.powerstats.intelligence, 100)) / 100)
                self.strengthProgress.setProgress(CGFloat(min(hero.powerstats.strength, 100)) / 100)
                self.speedProgress.setProgress(CGFloat(min(hero.powerstats.speed, 100)) / 100)
                self.durabilityProgress.setProgress(CGFloat(min(hero.powerstats.durability, 100)) / 100)
                self.powerProgress.setProgress(CGFloat(min(hero.powerstats.power, 100)) / 100)
                self.combatProgress.setProgress(CGFloat(min(hero.powerstats.combat, 100)) / 100)

                self.intelligenceLabel.text = "Intelligence: \(hero.powerstats.intelligence)"
                self.strengthLabel.text = "Strength: \(hero.powerstats.strength)"
                self.speedLabel.text = "Speed: \(hero.powerstats.speed)"
                self.durabilityLabel.text = "Durability: \(hero.powerstats.durability)"
                self.powerLabel.text = "Power: \(hero.powerstats.power)"
                self.combatLabel.text = "Combat: \(hero.powerstats.combat)"
            }
        } catch {
            DispatchQueue.main.async{
                self.heroTitle.text = "Randomize again"
                self.heroDescription.text = "Error: \(error.localizedDescription)"  // Логирование ошибки
                self.heroImage.image = nil
                self.ratingLabel.text = ""
                
                self.intelligenceProgress.setProgress(CGFloat(min(0, 100)) / 100)
                self.strengthProgress.setProgress(CGFloat(min(0, 100)) / 100)
                self.speedProgress.setProgress(CGFloat(min(0, 100)) / 100)
                self.durabilityProgress.setProgress(CGFloat(min(0, 100)) / 100)
                self.powerProgress.setProgress(CGFloat(min(0, 100)) / 100)
                self.combatProgress.setProgress(CGFloat(min(0, 100)) / 100)
                
                self.intelligenceLabel.text = ""
                self.strengthLabel.text = ""
                self.speedLabel.text = ""
                self.durabilityLabel.text = ""
                self.powerLabel.text = ""
                self.combatLabel.text = ""
            }
        }
    }

    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.heroImage.image = image
                }
            }
        }
    }
    
    private func calculateAverageRating(for powerStats: PowerStats) -> Int {
        let total = powerStats.intelligence + powerStats.strength + powerStats.speed + powerStats.durability + powerStats.power + powerStats.combat
        return total / 6
    }
}

