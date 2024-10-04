import Foundation

// Переменные с личной информацией
var firstName: String = "Asanbay"
var lastName: String = "Kakibay"
var age: Int = 20
let birthYear: Int = 2004
let currentYear: Int = 2024
var isStudent: Bool = true
var height: Double = 1.75
age = currentYear - birthYear

var country: String = "USA"
var city: String = "New York"

// Переменные для хобби и интересов
var hobby: String = "painting"
var numberOfHobbies: Int = 3
var favoriteNumber: Int = 7
var isHobbyCreative: Bool = true

var favoriteFood: String = "Pizza"
var favoriteMovie: String = "Inception"

// Строка с историей жизни
var lifeStory: String = "My name is \(firstName) \(lastName). I am \(age) years old, born in \(birthYear). " +
    "I am currently a student. I enjoy \(hobby), which is a creative hobby. " +
    "I have \(numberOfHobbies) hobbies in total, and my favorite number is \(favoriteNumber). " +
    "I live in \(city), \(country), and my favorite food is \(favoriteFood). My favorite movie is \(favoriteMovie)."

// Переменная для целей на будущее
var futureGoals: String = "In the future, I want to become a professional iOS developer."

// Дополнение строки с будущими целями
lifeStory += " In the future, I want to \(futureGoals) 😊."

// Печать полной истории жизни
print(lifeStory)
