import Foundation

// Problem 1: FizzBuzz
func fizzBuzz() {
    for i in 1...100 {
        if i % 3 == 0 && i % 5 == 0 {
            print("FizzBuzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

// Problem 2: Prime Numbers
func isPrime(_ number: Int) -> Bool {
    if number < 2 { return false }
    for i in 2..<number {
        if number % i == 0 {
            return false
        }
    }
    return true
}

func printPrimeNumbers() {
    for i in 1...100 {
        if isPrime(i) {
            print(i)
        }
    }
}

// Problem 3: Temperature Converter
func convertTemperature(value: Double, unit: String) {
    switch unit.uppercased() {
    case "C":
        let fahrenheit = (value * 9/5) + 32
        let kelvin = value + 273.15
        print("\(value)°C = \(fahrenheit)°F = \(kelvin)K")
    case "F":
        let celsius = (value - 32) * 5/9
        let kelvin = celsius + 273.15
        print("\(value)°F = \(celsius)°C = \(kelvin)K")
    case "K":
        let celsius = value - 273.15
        let fahrenheit = (celsius * 9/5) + 32
        print("\(value)K = \(celsius)°C = \(fahrenheit)°F")
    default:
        print("Unknown unit")
    }
}

// Problem 4: Shopping List Manager
func shoppingListManager() {
    var shoppingList = [String]()
    var shouldContinue = true

    while shouldContinue {
        print("\nChoose an option: (1) Add item (2) Remove item (3) View list (4) Exit")
        if let input = readLine(), let option = Int(input) {
            switch option {
            case 1:
                print("Enter item to add:")
                if let newItem = readLine() {
                    shoppingList.append(newItem)
                }
            case 2:
                print("Enter item to remove:")
                if let removeItem = readLine(), let index = shoppingList.firstIndex(of: removeItem) {
                    shoppingList.remove(at: index)
                } else {
                    print("Item not found")
                }
            case 3:
                print("Shopping List: \(shoppingList)")
            case 4:
                shouldContinue = false
            default:
                print("Invalid option")
            }
        }
    }
}

// Problem 5: Word Frequency Counter
func wordFrequencyCounter(sentence: String) {
    var wordCount = [String: Int]()
    let words = sentence.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }

    for word in words {
        wordCount[word, default: 0] += 1
    }

    for (word, count) in wordCount {
        print("\(word): \(count)")
    }
}

// Problem 6: Fibonacci Sequence
func fibonacci(_ n: Int) -> [Int] {
    guard n > 0 else { return [] }
    var sequence = [0, 1]
    if n == 1 { return [0] }
    while sequence.count < n {
        sequence.append(sequence[sequence.count - 1] + sequence[sequence.count - 2])
    }
    return Array(sequence.prefix(n))
}

// Problem 7: Grade Calculator
func gradeCalculator(students: [String: Int]) {
    let totalScore = students.values.reduce(0, +)
    let averageScore = totalScore / students.count
    let highestScore = students.values.max() ?? 0
    let lowestScore = students.values.min() ?? 0

    print("Average score: \(averageScore)")
    print("Highest score: \(highestScore)")
    print("Lowest score: \(lowestScore)")

    for (student, score) in students {
        let status = score >= averageScore ? "above" : "below"
        print("\(student) scored \(score), which is \(status) the average.")
    }
}

// Problem 8: Palindrome Checker
func isPalindrome(_ text: String) -> Bool {
    let filteredText = text.lowercased().filter { $0.isLetter }
    return filteredText == String(filteredText.reversed())
}

// Problem 9: Simple Calculator
func simpleCalculator() {
    var shouldContinue = true

    while shouldContinue {
        print("Enter first number:")
        guard let firstInput = readLine(), let num1 = Double(firstInput) else { continue }
        print("Enter second number:")
        guard let secondInput = readLine(), let num2 = Double(secondInput) else { continue }
        print("Choose operation (+, -, *, /):")
        let operation = readLine()

        var result: Double?
        switch operation {
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "*":
            result = num1 * num2
        case "/":
            if num2 != 0 {
                result = num1 / num2
            } else {
                print("Error: Division by zero")
            }
        default:
            print("Unknown operation")
        }

        if let result = result {
            print("Result: \(result)")
        }

        print("Do you want to continue? (yes/no)")
        shouldContinue = readLine()?.lowercased() == "yes"
    }
}

// Problem 10: Unique Characters
func hasUniqueCharacters(_ text: String) -> Bool {
    var charSet = Set<Character>()
    for char in text {
        if charSet.contains(char) {
            return false
        }
        charSet.insert(char)
    }
    return true
}

// Main execution examples:

print("Problem 1: FizzBuzz")
fizzBuzz()

print("\nProblem 2: Prime Numbers")
printPrimeNumbers()

print("\nProblem 3: Temperature Converter")
convertTemperature(value: 100, unit: "C")
convertTemperature(value: 212, unit: "F")
convertTemperature(value: 373.15, unit: "K")

print("\nProblem 4: Shopping List Manager")
shoppingListManager()

print("\nProblem 5: Word Frequency Counter")
wordFrequencyCounter(sentence: "Swift is a powerful and intuitive programming language. Swift makes programming fun!")

print("\nProblem 6: Fibonacci Sequence")
print(fibonacci(10))

print("\nProblem 7: Grade Calculator")
let studentsScores = ["John": 80, "Jane": 90, "Alex": 78, "Emily": 88]
gradeCalculator(students: studentsScores)

print("\nProblem 8: Palindrome Checker")
print(isPalindrome("A man, a plan, a canal, Panama"))

print("\nProblem 9: Simple Calculator")
simpleCalculator()

print("\nProblem 10: Unique Characters")
print(hasUniqueCharacters("Swift"))
print(hasUniqueCharacters("Programming"))
