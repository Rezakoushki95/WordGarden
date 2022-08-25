//
//  ViewController.swift
//  WordGarden
//
//  Created by Reza Koushki on 19/08/2022.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var wordsGuessedLabel: UILabel!
	@IBOutlet weak var wordsRemainingLabel: UILabel!
	@IBOutlet weak var wordsMissedLabel: UILabel!
	@IBOutlet weak var wordsInGameLabel: UILabel!
	
	@IBOutlet weak var wordBeingRevealedLabel: UILabel!
	@IBOutlet weak var guessedLetterField: UITextField!
	@IBOutlet weak var guessLetterButton: UIButton!
	@IBOutlet weak var gameStatusMessageLabel: UILabel!
	@IBOutlet weak var playAgainButton: UIButton!
	@IBOutlet weak var flowerImageView: UIImageView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guessLetterButton.isEnabled = false
	}
	
	func returnLastCharacter(_ text: String) -> String {
		guard let lastCharacter = text.last else {
			return ""
		}
		return String(lastCharacter)
	}
	
	func updateUIAfterGuess() {
		guessedLetterField.text = ""
		guessedLetterField.resignFirstResponder()
		guessLetterButton.isEnabled = false
	}
	
	@IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
		if let text = sender.text {
			guessLetterButton.isEnabled = !(text.isEmpty)
			guessedLetterField.text = returnLastCharacter(text)
		}
	}
	
	@IBAction func doneButtonPressed(_ sender: UITextField) {
		updateUIAfterGuess()
	}
	
	@IBAction func guessLetterButtonPressed(_ sender: UIButton) {
		updateUIAfterGuess()

	}
	
	@IBAction func playAgainButtonPressed(_ sender: UIButton) {
	}

}

