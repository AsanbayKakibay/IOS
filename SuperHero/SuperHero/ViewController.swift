//
//  ViewController.swift
//  SuperHero
//
//  Created by Asanbay on 30.11.2024.
//


import UIKit
import Alamofire
import Kingfisher

struct Hero: Codable {
    let name: String
    let images: Images
    let biography: Biography
    let powerstats: PowerStats
}
struct Images: Codable {
        let lg: String
}
    
struct Biography: Codable {
    let fullName: String
}

struct PowerStats: Codable {
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
    @IBOutlet private weak var heroClassLabel: UILabel!
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
        getLocalHero()
    }
    
    @IBAction func heroRollDidTap(_ sender: UIButton) {
        let randomId = Int.random(in: 1...731)
        fetchHero(by: randomId)
    }
    /*
     private func fetchHero(by id: Int) {
     activityIndicator.startAnimating()
     let urlString = "https://akabab.github.io/superhero-api/api/id/\(id).json"
     guard let url = URL(string: urlString) else { return }
     let urlRequest = URLRequest(url: url)
     
     URLSession.shared.dataTask(with: urlRequest) { data, response, error in
     
     if let error = error {
     DispatchQueue.main.async {
     self.activityIndicator.stopAnimating()
     self.showErrorState(with: error.localizedDescription)
     }
     return
     }
     
     guard let data = data else { return }
     DispatchQueue.main.async {
     self.activityIndicator.stopAnimating()
     self.handleHeroData(data: data)
     }
     }.resume()
     }*/
    
    private func fetchHero(by id: Int) {
        activityIndicator.startAnimating()
        
        let urlString = "https://akabab.github.io/superhero-api/api/id/\(id).json"
        
        
        AF.request(urlString).responseDecodable(of: Hero.self) { response in
            self.activityIndicator.stopAnimating()
            
            switch response.result {
            case .success(let hero):

                self.animateHeroUpdate(with: hero)
                self.saveHero(hero)
            case .failure(let error):

                self.showErrorState(with: error.localizedDescription)
            }
        }
    }
    
    private func saveHero(_ hero: Hero) {
            guard let heroData = try? PropertyListEncoder().encode(hero) else {
                return
            }
            UserDefaults.standard.set(heroData, forKey: "lastHero")
        }
    
    private func getLocalHero() {
            if
                let heroData = UserDefaults.standard.data(forKey: "lastHero"),
                let storedHero = try? PropertyListDecoder().decode(Hero.self, from: heroData)
            {
                animateHeroUpdate(with: storedHero)
            }
        }
    
    private func handleHeroData(data: Data) {
        do {
            let hero = try JSONDecoder().decode(Hero.self, from: data)
            DispatchQueue.main.async {
                self.animateHeroUpdate(with: hero)
            }
        } catch {
            DispatchQueue.main.async {
                self.showErrorState(with: error.localizedDescription)
            }
        }
    }
    
    private func showErrorState(with message: String) {
        heroTitle.text = "Oops..."
        heroDescription.text = "Failed to load the hero. Check your internet connection."
        heroImage.image = nil
        heroClassLabel.text = ""
        ratingLabel.text = ""
        
        intelligenceProgress.setProgress(0, animated: true, duration: 0.5)
        strengthProgress.setProgress(0, animated: true, duration: 0.5)
        speedProgress.setProgress(0, animated: true, duration: 0.5)
        durabilityProgress.setProgress(0, animated: true, duration: 0.5)
        powerProgress.setProgress(0, animated: true, duration: 0.5)
        combatProgress.setProgress(0, animated: true, duration: 0.5)
        
        intelligenceLabel.text = ""
        strengthLabel.text = ""
        speedLabel.text = ""
        durabilityLabel.text = ""
        powerLabel.text = ""
        combatLabel.text = ""
    }
    
    private func animateHeroUpdate(with hero: Hero) {

        UIView.transition(with: heroImage, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.heroImage.layer.cornerRadius = self.heroImage.bounds.width / 2.5
            self.heroImage.clipsToBounds = true
            
            self.loadImage(from: hero.images.lg)
        })
        

        UIView.animate(withDuration: 0.5, animations: {
            self.heroTitle.alpha = 0
            self.heroDescription.alpha = 0
            self.ratingLabel.alpha = 0
            self.heroClassLabel.alpha = 0
            
            self.intelligenceLabel.alpha = 0
            self.strengthLabel.alpha = 0
            self.speedLabel.alpha = 0
            self.durabilityLabel.alpha = 0
            self.powerLabel.alpha = 0
            self.combatLabel.alpha = 0
        }) { _ in

            self.heroTitle.text = hero.name
            self.heroDescription.text = hero.biography.fullName
            
            let averageRating = self.calculateAverageRating(for: hero.powerstats)
            self.ratingLabel.text = "Rating\n\(averageRating)"
            
            let (heroClass, heroClassColor) = self.determineHeroClass(for: averageRating)
            self.heroClassLabel.text = "Class\n\(heroClass)"
            self.heroClassLabel.textColor = heroClassColor
            
            self.intelligenceProgress.setProgress(CGFloat(hero.powerstats.intelligence) / 100, animated: true, duration: 0.5)
            self.strengthProgress.setProgress(CGFloat(hero.powerstats.strength) / 100, animated: true, duration: 0.5)
            self.speedProgress.setProgress(CGFloat(hero.powerstats.speed) / 100, animated: true, duration: 0.5)
            self.durabilityProgress.setProgress(CGFloat(hero.powerstats.durability) / 100, animated: true, duration: 0.5)
            self.powerProgress.setProgress(CGFloat(hero.powerstats.power) / 100, animated: true, duration: 0.5)
            self.combatProgress.setProgress(CGFloat(hero.powerstats.combat) / 100, animated: true, duration: 0.5)
            
            
            self.intelligenceLabel.text = "Intelligence: \(hero.powerstats.intelligence)"
            self.strengthLabel.text = "Strength: \(hero.powerstats.strength)"
            self.speedLabel.text = "Speed: \(hero.powerstats.speed)"
            self.durabilityLabel.text = "Durability: \(hero.powerstats.durability)"
            self.powerLabel.text = "Power: \(hero.powerstats.power)"
            self.combatLabel.text = "Combat: \(hero.powerstats.combat)"
            

            UIView.animate(withDuration: 0.5) {
                self.heroTitle.alpha = 1
                self.heroDescription.alpha = 1
                self.ratingLabel.alpha = 1
                self.heroClassLabel.alpha = 1
                
                self.intelligenceLabel.alpha = 1
                self.strengthLabel.alpha = 1
                self.speedLabel.alpha = 1
                self.durabilityLabel.alpha = 1
                self.powerLabel.alpha = 1
                self.combatLabel.alpha = 1
            }
        }
    }
    /*
     private func loadImage(from urlString: String) {
     guard let url = URL(string: urlString) else { return }
     
     DispatchQueue.global().async {
     if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
     DispatchQueue.main.async {
     self.heroImage.image = image
     }
     }
     }
     }*/
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        heroImage.kf.setImage(with: url)
    }
    
    
    private func calculateAverageRating(for powerStats: PowerStats) -> Int {
        let total = powerStats.intelligence + powerStats.strength + powerStats.speed + powerStats.durability + powerStats.power + powerStats.combat
        return total / 6
    }
    
    private func determineHeroClass(for averageRating: Int) -> (String, UIColor) {
        switch averageRating {
        case 90...100:
            return ("S", UIColor.systemYellow)
        case 80..<90:
            return ("A", UIColor.systemGreen)
        case 70..<80:
            return ("B", UIColor.systemBlue)
        case 60..<70:
            return ("C", UIColor.systemOrange)
        case 50..<60:
            return ("D", UIColor.systemRed)
        case 40..<50:
            return ("E", UIColor.systemPurple)
        default:
            return ("F", UIColor.black)
        }
    }
}
