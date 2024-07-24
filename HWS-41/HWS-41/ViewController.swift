//
//  ViewController.swift
//  HWS-41
//
//  Created by Mateusz Bereta on 19/07/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var submitButton: UIButton!
    var allWords: [String] = []
    var chosenWord: String = ""
    var userCharacter: [Character] = []
    var checker = 0
    var lives = 7
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "♥️: 7"
        view.addSubview(scoreLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 20)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.borderStyle = UITextField.BorderStyle.roundedRect
        
        currentAnswer.textAlignment = .center
        currentAnswer.isUserInteractionEnabled = true
        currentAnswer.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        view.addSubview(currentAnswer)
        
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.isEnabled = false
        submitButton.addTarget(self, action: #selector(insertCharacter), for: .touchUpInside)
        view.addSubview(submitButton)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            answersLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            answersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            answersLabel.bottomAnchor.constraint(equalTo: currentAnswer.topAnchor),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            currentAnswer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentAnswer.rightAnchor.constraint(equalTo: submitButton.leftAnchor,  constant: -30),
            submitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    func startGame() {
        chosenWord = allWords.randomElement() ?? ""
        print(chosenWord)
        refreshWord()
    }
    
    func refreshWord() {
        let characterToGuess = chosenWord.filter({ !userCharacter.contains($0) }).map( { String($0) } )
        if checker == characterToGuess.count {
            lives -= 1
        } else {
            checker = characterToGuess.count
        }
        if lives == 0 {
            let ac = UIAlertController(title: "You lost!", message: "Word was \(chosenWord)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: resetGame))
            present(ac,animated: true)
        }
        var wordToShow = chosenWord
        for character in characterToGuess {
            wordToShow = wordToShow.replacingOccurrences(of: character, with: "?")
        }
        answersLabel.text = wordToShow.uppercased()
        if characterToGuess.isEmpty {
            let ac = UIAlertController(title: "You Won!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: resetGame))
            present(ac,animated: true)
        }
        scoreLabel.text = "♥️: \(lives)"
    }
    
    func resetGame(_:UIAlertAction) {
        chosenWord = allWords.randomElement() ?? ""
        userCharacter = []
        lives = 7
        checker = 0
        refreshWord()
    }

    @objc func insertCharacter() {
        if let string = currentAnswer.text {
            let character = [Character](string.lowercased())
            userCharacter.append(character[0])
            print(userCharacter)
            refreshWord()
        }
        currentAnswer.text = ""
        submitButton.isEnabled = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        submitButton.isEnabled = false
        if textField.text?.count == 1 {
            submitButton.isEnabled = true
        }
    }
}

