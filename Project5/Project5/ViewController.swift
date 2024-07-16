//
//  ViewController.swift
//  Project5
//
//  Created by Mateusz Bereta on 15/07/2024.
//

import UIKit

class ViewController: UITableViewController {
    var allWords : [String] = []
    var usedWords : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGameTapped))
        
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
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        switch lowerAnswer.isOk(chosenWord: title, usedWords: usedWords) {
        case .notPossible:
            guard let title = title?.lowercased() else { return }
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title)")
        case .notOriginal:
            showErrorMessage(errorTitle: "Word used already", errorMessage: "Be more original!")
        case .notReal:
            showErrorMessage(errorTitle: "Word not recognised", errorMessage: "You can't just make them up, you know!")
        case .tooShort:
            showErrorMessage(errorTitle: "Word is too short", errorMessage: "You can write more!")
        case .isSame:
            showErrorMessage(errorTitle: "Word is the same", errorMessage: "Be more original!")
        case .isOk:
            insertWord(answer)
            return
        }
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func insertWord(_ answer: String) {
        usedWords.insert(answer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func startGameTapped(){
        startGame()
    }
}

