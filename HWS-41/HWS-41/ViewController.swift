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
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
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
        
        view.addSubview(currentAnswer)
        
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: .normal)
//        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
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
        // Do any additional setup after loading the view.
    }
    
    


}

