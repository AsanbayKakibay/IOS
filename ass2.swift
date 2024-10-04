import Foundation

// Easy Tasks
let fruits = ["Apple", "Banana", "Cherry", "Date", "Fig"]
print(fruits[2])

var favoriteNumbers: Set<Int> = [7, 14, 21]
favoriteNumbers.insert(28)
print(favoriteNumbers)

let programmingLanguages = ["Swift": 2014, "Python": 1991, "Java": 1995]
print(programmingLanguages["Swift"]!)

var colors = ["Red", "Green", "Blue", "Yellow"]
colors[1] = "Purple"
print(colors)

// Medium Tasks
let set1: Set = [1, 2, 3, 4]
let set2: Set = [3, 4, 5, 6]
let intersection = set1.intersection(set2)
print(intersection)

var studentScores = ["Alice": 85, "Bob": 90, "Charlie": 88]
studentScores["Bob"] = 95
print(studentScores)

let fruits1 = ["Apple", "Banana"]
let fruits2 = ["Cherry", "Date"]
let mergedFruits = fruits1 + fruits2
print(mergedFruits)

// Hard Tasks
var countryPopulation = ["USA": 331_000_000, "China": 1_400_000_000, "India": 1_380_000_000]
countryPopulation["Canada"] = 37_000_000
print(countryPopulation)

let animals1: Set = ["cat", "dog"]
let animals2: Set = ["dog", "mouse"]
let unionSet = animals1.union(animals2)
let finalSet = unionSet.subtracting(animals2)
print(finalSet)

let studentGrades = [
    "Alice": [85, 90, 92],
    "Bob": [88, 76, 93],
    "Charlie": [90, 85, 87]
]
print(studentGrades["Bob"]![1])
