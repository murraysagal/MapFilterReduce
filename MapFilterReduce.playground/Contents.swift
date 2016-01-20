//
//  Created by Murray Sagal on 2016-01-19.
//  Copyright © 2016 Murray Sagal. All rights reserved.
//

import UIKit

let numbers = [ 1, 2, 3, 4, 5, 6, 7 ]

/////////////////////////////////////////////////////////////
// MARK: -- for...in and forEach()

// create a function that accepts a number and prints it to the console
func printNumber(number: Int) -> () {
    print(number)
}

print("for...in calling the function")
for number in numbers {
    printNumber(number)
}
print("")

print("forEach() passing the function")
numbers.forEach(printNumber)
print("")

// Question: What is the difference between printNumber(number) as used in the for loop and the way it is used in forEach()?
// Answer: In the for loop the function is being called with a parameter. You are calling it. You are passing the parameter.
//  In forEach(), a reference to the function is handed to forEach(). Internally, it passes the parameter to the function.
// being passed to forEach().

// Ok. But creating a function for whatever I'm doing with forEach() seems like it might get a bit tiresome. Is there another way?
// There are a couple of ways...

print("forEach() with anonymous function")
numbers.forEach({ (number: Int) -> () in
    print(number)
})
print("")

// Ok, but that's still a lot of syntax. Can it be further simplified?
// Yes. Use a trailing closure with all the shortcuts.

print("forEach() with trailing closure with all the shortcuts and the magic parameter name")
numbers.forEach { print($0) }
print("")

// Question: Who provides the value for $0?


////////////////////////////////////////////////////////////
// MARK: - enumerate(), for when you need the index

print("for...in with enumerate(), reference the tuple and each item by name and index")
for t in numbers.enumerate() {
    print(t, t.index, t.element, t.0, t.1)
}
print("")

print("for...in with enumerate(), override the tuple item names")
for (i, n) in numbers.enumerate() {
    print(i, n)
}
print("")

print("forEach() with enumerate(), trailing closure, all the reference methods")
numbers.enumerate().forEach {print($0, $0.index, $0.element, $0.0, $0.1)}
print("")

// Question: When would you use enumerate()?
// Question: What's a tuple?


///////////////////////////////////////////////////////////////
// MARK: -- convert an array of integers to an array of strings
// create a function that takes a number and returns a string...
func stringFromNumber(number: Int) -> String {
    return "\(number)"
}
var stringsFromNumbers: [String] = [] // an array for the strings

print("for...in that calls the function")
for number in numbers {
    let string = stringFromNumber(number)
    stringsFromNumbers.append(string)
}
print(stringsFromNumbers)
print("")

print("map() that passes the function")
stringsFromNumbers = numbers.map(stringFromNumber)
print(stringsFromNumbers)
print("")

// Question: Again, what is the difference between how stringFromNumber() is used in the for...in loop and in map()?

print("map() with anonymous function with no shortcuts")
stringsFromNumbers = numbers.map({ (number: Int) -> String in
    return "\(number)"
})
print(stringsFromNumbers)
print("")

print("map() with a trailing closure will all the shortcuts")
stringsFromNumbers = numbers.map{"\($0)"}
print(stringsFromNumbers)
print("")



////////////////////////////////////////////////
// MARK: -- filter out the odd numbers
// create a function that returns true if a number is even, false for odd
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}
var evenNumbers: [Int] = []

print("for...in calling the function")
for number in numbers {
    if isEven(number) {
        evenNumbers.append(number)
    }
}
print(evenNumbers)
print("")

print("filter() passing the function")
evenNumbers = numbers.filter(isEven)
print(evenNumbers)
print("")

// Question: Again, what is the difference between how isEven() is used in the for...in loop and in filter()?

print("filter() with an anonymous function with no shortcuts")
evenNumbers = numbers.filter({ (number: Int) -> Bool in
    return number % 2 == 0
})
print(evenNumbers)
print("")

print("filter() with a trailing closure with all the shortcuts")
evenNumbers = numbers.filter {$0 % 2 == 0}
print(evenNumbers)
print("")



//////////////////////////////////////////////////////////////////////////
// MARK: -- add the numbers in the array to get a total, should get 28
// first create a function where the first parameter is the running total and the second parameter is the next number to add.
// the function returns the result of adding the two parameters
func addToTotal(total: Int, numberToAdd: Int) -> Int {
    return total + numberToAdd
}
var total = 0

print("for...in calling the function")
for number in numbers {
    total = addToTotal(total, numberToAdd: number)
}
print(total)
print("")

print("reduce() passing the function")
total = numbers.reduce(0, combine: addToTotal)
print(total)
print("")

// Broken Record: Again, what is the difference between how addToTotal() is used in the for...in loop and in reduce()?

print("reduce() with an anonymous function with no shortcuts")
total = numbers.reduce(0, combine: { (total: Int, number: Int) -> Int in
    return total + number
})
print(total)
print("")

print("reduce() with a trailing closure with all the shortcuts")
total = numbers.reduce(0) {$0 + $1}
print(total)
print("")

print("another reduce() example showing that the starting value can be a different type, return one long string")
let x = numbers.reduce("") { (string: String, number: Int) -> String in
    return  "\(string)\(number)"
}
print(x)
print("")



////////////////////////////////////////
// MARK: combine -- sum the odd numbers
print("sum of the odd numbers= \(1 + 3 + 5 + 7)")
var sumOfOddNumbers = 0
print("")

print("filter().reduce() using trailing closures with all the shortcuts")
sumOfOddNumbers = numbers.filter{$0 % 2 != 0}.reduce(0){$0 + $1}
print(sumOfOddNumbers)
print("")



///////////////////////////////////////
// MARK: - assign an anoymous function to a constant
print("forEach() with a closure from a constant")
let printIt = { print($0) }
numbers.forEach(printIt)
let strings = numbers.map{"\($0)"}
strings.forEach(printIt)
print("")



//////////////////////////////////////
// MARK: - example using a class
class Test {
    var score: Int = 0
}

let test1 = Test()
test1.score = 75
let test2 = Test()
test2.score = 80
let test3 = Test()
test3.score = 90

print("map() to print the object addresses")
let tests = [test1, test2, test3]
var addresses = tests.map{unsafeAddressOf($0)}
print(addresses)
print("")

print("filter() to find Tests with scores > 80")
let greaterThan80 = tests.filter{$0.score > 80}
addresses = greaterThan80.map{unsafeAddressOf($0)}
print(addresses)
print("")

print("reduce() to find highest score")
let bestTest = tests.reduce(tests[0]) {
    print("")
    print("$0= \(unsafeAddressOf($0))")
    print("$1= \(unsafeAddressOf($1))")
    
    let testWithHigherScore = $0.score > $1.score ? $0:$1
    
    print("testWithHigherScore= \(unsafeAddressOf(testWithHigherScore))")
    return testWithHigherScore
}
print(bestTest.score)
