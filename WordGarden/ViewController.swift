//
//  ViewController.swift
//  WordGarden
//
//  Created by Reza Koushki on 19/08/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

	@IBOutlet weak var wordsGuessedLabel: UILabel!
	@IBOutlet weak var wordsRemainingLabel: UILabel!
	@IBOutlet weak var wordsMissedLabel: UILabel!
	@IBOutlet weak var wordsInGameLabel: UILabel!
	
	@IBOutlet weak var wordBeingRevealedLabel: UILabel!
	@IBOutlet weak var guessedLetterTextField: UITextField!
	@IBOutlet weak var guessLetterButton: UIButton!
	@IBOutlet weak var gameStatusMessageLabel: UILabel!
	@IBOutlet weak var playAgainButton: UIButton!
	@IBOutlet weak var flowerImageView: UIImageView!
	
	var audioPlayer: AVAudioPlayer!
	
	var wordsToGuess = ["SWIFT", "DOG", "CAT"]
	var currentWordIndex = 0
	var wordToGuess = ""
	var lettersGuessed = ""
	let maxNumberOfWrongGuessed = 8
	var wrongGuessesRemaining = 8
	var wordsGuessedCount = 0
	var wordsMissedCount = 0
	var guessCount = 0
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let text = guessedLetterTextField.text!
		guessLetterButton.isEnabled = !(text.isEmpty)
		
		wordToGuess = wordsToGuess[currentWordIndex]
		wordBeingRevealedLabel.text = "_" + String(repeating: " _", count: wordToGuess.count-1)
		updateGameStatusLabel()
		
	}
	
	func playSound(name: String) {
		if let sound = NSDataAsset(name: name) {
			do {
				try audioPlayer = AVAudioPlayer(data: sound.data)
				audioPlayer.play()
			} catch {
				print("Error: \(error.localizedDescription). Could not initialize AVAudioPlayer object")
			}
		} else {
			print("ERROR: Could not read data from file \(name)")
		}
	}
	
	func returnLastCharacter(_ text: String) -> String {
		guard let lastCharacter = text.last else {
			return ""
		}
		return String(lastCharacter)
	}
	
	func updateUIAfterGuess() {
		guessedLetterTextField.resignFirstResponder()
		guessedLetterTextField.text! = ""
		guessLetterButton.isEnabled = false
	}
	
	func formatRevealedWord() {
		// format and show revealedWord in wordBeingRevealedLabel to include new guess.
		var revealedWord = ""
		
		// loop through all letters in wordToGuess
		for letter in wordToGuess {
			// check if letter in wordToGuess is in letterGuessed (i.e did you guess this letter already?)
			if lettersGuessed.contains(letter) {
				revealedWord = revealedWord + "\(letter) "
			} else {
				// if not, add an underscore + a black space, to revealedWord.
				revealedWord = revealedWord + "_ "
			}
		}
		// remove extra space in revealed word
		revealedWord.removeLast()
		wordBeingRevealedLabel.text = revealedWord
	}
	
	func updateAfterWinOrLose() {
		// increment currentWordIndex by 1
		// disable guessdLetterTextField
		// disable guessALetterButton
		// set playAgainButton .isHidden to false
		
		currentWordIndex += 1
		guessedLetterTextField.isEnabled = false
		guessLetterButton.isEnabled = false
		playAgainButton.isHidden = false
		
		updateGameStatusLabel()
	}
	
	func updateGameStatusLabel() {
		// Update all labels at top of the screen
		wordsGuessedLabel.text = "Words Guessed: \(wordsGuessedCount)"
		wordsMissedLabel.text = "Words Missed: \(wordsMissedCount)"
		wordsRemainingLabel.text = "Words to Guess: \(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount))"
		wordsInGameLabel.text = "Words in Game: \(wordsToGuess.count)"
	}
	
	func drawFlowerAndPlaySound(_ currentLetterGuessed: String) {
		// update image, if needed, and keep track of wrong guesses
		if wordToGuess.contains(currentLetterGuessed) == false {
			wrongGuessesRemaining -= 1
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
				UIView.transition(
					with: self.flowerImageView,
					duration: 0.5,
					options: .transitionCrossDissolve,
					animations: {self.flowerImageView.image = UIImage.init(named: "wilt\(self.wrongGuessesRemaining)")})
				{ (_) in
					
					// If we are not on the last flower
					// - show next flower
					// otherwise we are on flower0
					// - playSound (word-not-guessed)
					// - perform another UIView Transition to Flower0
					//
					if self.wrongGuessesRemaining != 0 {
						self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)")
					} else {
						self.playSound(name: "word-not-guessed")
						UIView.transition(
							with: self.flowerImageView,
							duration: 0.5,
							options: .transitionCrossDissolve,
							animations: {self.flowerImageView.image = UIImage(named: "flower\(self.wrongGuessesRemaining)")}, completion: nil)
					}
				}
				self.playSound(name: "incorrect")
			}
		} else {
			playSound(name: "correct")
		}
	}
	
	func guessALetter() {
		// get current letter guessed and add it to all lettersGuessed
		let currentLetterGuessed = guessedLetterTextField.text!
		lettersGuessed += currentLetterGuessed
		formatRevealedWord()
		drawFlowerAndPlaySound(currentLetterGuessed)
		
		// update gameStatusMessageLabel
		guessCount += 1
		let guesses = guessCount == 1 ? "Guess" : "Guesses"
		gameStatusMessageLabel.text = "You've Made \(guessCount) \(guesses)"
		
		// after each guess, check to see if two things happen:
		// 1) The user won the game
		// - all letters guessed, no more underscores in wordBeingRevealed.text
		// - handle game over
		// 2. THe user loss the game
		// -  wrongGuessesRemaining = 0
		// - handle game over
		
		if wordBeingRevealedLabel.text!.contains("_") == false {
			gameStatusMessageLabel.text = "You've guessed it! It took you \(guessCount) guesses to guess the word."
			wordsGuessedCount += 1
			playSound(name: "word-guessed")
			updateAfterWinOrLose()
		} else if wrongGuessesRemaining == 0 {
			gameStatusMessageLabel.text = "So sorry. You are out of guesses."
			wordsMissedCount += 1
			updateAfterWinOrLose()
		}
		
		// Check to see if all words played. If so, update the message indicating the player can restart the game.
		if currentWordIndex == wordsToGuess.count {
			gameStatusMessageLabel.text! += "\n\nYou've tried all of the words! Restart from the beginning?"
		}
	}
	
	@IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
		sender.text = String(sender.text?.last ?? " ").trimmingCharacters(in: .whitespaces).uppercased()
		guessLetterButton.isEnabled = !(sender.text!.isEmpty)
	}
	
	@IBAction func doneKeyPressed(_ sender: UITextField) {
		guessALetter()
		updateUIAfterGuess()
	}
	
	@IBAction func guessLetterButtonPressed(_ sender: UIButton) {
		guessALetter()
		updateUIAfterGuess()

	}
	
	@IBAction func playAgainButtonPressed(_ sender: UIButton) {

		
		// If all words have been guessed and you select playAgain, restart all games as if the app has been restarted
		
		if currentWordIndex == wordsToGuess.count {
			currentWordIndex = 0
			wordsGuessedCount = 0
			wordsMissedCount = 0
		}
		
		// hide playAgain Button
		// enable letterGuessedTextField
		// disableGuessALetterButton - it is already
		// currentWord should be set to next word
		// set wordBeingRevealed.text to  underscores seperated by spaces
		// set wrongGuesseRemaining to maxNumberOfWrongGuesses
		// set guessCount = 0
		// set flowerImage to flower8
		// clear out lettersGuessed, so new word restarts with no letters guesses or = ""
		// set gameStatusMessageLabel.text to "You've Made Zero Guesses"
		playAgainButton.isHidden = true
		guessedLetterTextField.isEnabled = true
		guessLetterButton.isEnabled = false
		wordToGuess = wordsToGuess[currentWordIndex]
		wrongGuessesRemaining = maxNumberOfWrongGuessed
		wordBeingRevealedLabel.text = "_" + String(repeating: " _", count: wordToGuess.count - 1)
		guessCount = 0
		flowerImageView.image = UIImage(named: "flower\(maxNumberOfWrongGuessed)")
		lettersGuessed = ""
		updateGameStatusLabel()
		gameStatusMessageLabel.text = "You've Made Zero Guesses"
		
		
	}

}

