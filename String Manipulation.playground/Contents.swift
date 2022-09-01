import UIKit

var myName = "Gallagher"
var smallerString = "laugh"

// contains
if myName.contains(smallerString) {
	print("\(myName) contains \(smallerString)")
} else {
	print("There is no \(smallerString) in \(myName)")
}

// .hasPrefix + .hasSuffix

var occupation = "Real Estate Developer"
var searchString = "Swift"

print("\nPREFIX SEARCH")
occupation.hasPrefix(searchString)

if occupation.hasPrefix(searchString) {
	print("You're hired!")
} else {
	print("No job for you")
}

print("\nSUFFIX SEARCH")

occupation = "iOS hater"
searchString = "Developer"

if occupation.hasSuffix(searchString) {
	print("You're hired! We need more \(occupation)s")
} else {
	print("No one needs any \(occupation)s")
}

// .removeLast()
print("\nRemove Last")

var bandName = "The White Stripes"
let lastChar = bandName.removeLast()
print("After we remove \(lastChar) the band is just \(bandName)")

// .removeFirst(k: Int)
print("\nRemove First #")
var person = "Dr. Nick"
let title = "Dr."
person.removeFirst(title.count+1)
print(person)

// .replacingOccurances(of: width:)
print("\nREPLACING OCCURANCES OF ")

// 123 James St.
// 123 James St
// 123 James Street

var address = "123 James St."
var streetString = "St."
var replacingString = "Street"

var standardAddress = address.replacingOccurrences(of: streetString, with: replacingString)
print(standardAddress, address)


// What if you have "123 St. James St."

// Iterate through string

print("\nBACKWARDS STRING")

var name = "Gallaugher"
var nameBackwards = ""

//for letter in name {
//	nameBackwards = String(letter) + nameBackwards
//}
print(nameBackwards)

for letter in name.reversed() {
	nameBackwards += String(letter)
}

print(nameBackwards)

// Capitaliation
print("\nPLAYING WITH CAPS")

var crazyCaps = "SWift DEVelOPeR"
var uppercased = crazyCaps.uppercased()
var lowercased = crazyCaps.lowercased()
var capitalized = crazyCaps.capitalized

print(crazyCaps, uppercased, lowercased, capitalized)

var wordsToGuess = "SWIFT"
var revealedWord = "_"

for _ in 2...wordsToGuess.count {
	revealedWord += " _"
}
// revealedWords.removeLast()
print("\(wordsToGuess) will show as '\(revealedWord)'")

// Create a String from repeating value
revealedWord = "_" + String(repeating: " _", count: wordsToGuess.count-1)
print("Using repeating string:  '\(revealedWord)'")

// Challenge Reveal the word
print("\nREVEAL THE WORD")

var letterGuessed = "AFASFAWFFQFVQVRHHAASFAQGQ"
wordsToGuess = "STARWARS"
revealedWord = ""

for letter in wordsToGuess {
	if letterGuessed.contains(letter) {
		revealedWord = revealedWord + "\(String(letter)) "
	} else {
		revealedWord = revealedWord + "_ "
	}
}
revealedWord.removeLast()
print("'\(revealedWord)'")

occupation = "Swift Developer"
searchString = " "
occupation.hasPrefix(searchString)
occupation.hasSuffix(searchString)


occupation = "Swift Developer"
searchString = "Swift"
if occupation.hasPrefix(searchString) {
	occupation.removeFirst(searchString.count + 1)
}
print(occupation)


print("\nREPLACING OCCURENCES")
var searchTerm = " and "
var replaceTerm = " & "
var phrase = "This and that and the other"
var newPhrase = phrase.replacingOccurrences(of: searchTerm, with: replaceTerm)
print(phrase)
// Console output: This and that and the other
print(newPhrase)
// Console output: This & that & the other


address = "123 St. James St."
streetString = "St."
replacingString = "Street"


address.hasPrefix(streetString)
if address.hasSuffix(streetString) {
	standardAddress = address.replacingOccurrences(of: streetString, with: replacingString)
}

print(standardAddress, address)


var names = ["Sue", "Sanjay", "Monty", "Anne", "Viktor", "Katie", "Anika", "Maya"]

var occupations = ["Software Engineer", "Accountant", "iOS Developer", "Mobile App Engineer", "Marketer", "Programmer", "Web Developer"]

var index = 0

var inviteeIndices = [Int]()

for occupation in occupations {
	if occupation.contains("Engineer") || occupation.contains("Developer") || occupation.contains("Programmer")  {
		inviteeIndices.append(index)
	}
	index += 1
}

for value in inviteeIndices {
	print("\(names[value]) - \(occupations[value])")
}

