//
//  ViewController.swift
//  GameProject
//
//  Created by Mateusz Bereta on 11/07/2024.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    var highScore = 0
    let maxQuestions = 10
    let defaults = UserDefaults.standard
    let notificationID = "alarmGame"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScore = defaults.object(forKey:"HighScore") as? Int ?? 0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        registerLocalNotification()
    }
    
    func askQuestion(_: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) Score: \(score)"
        
        questionsAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print(sender.tag)
        var title: String
        var wrong = ""
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            wrong = "Wrong! That’s the flag of \(countries[correctAnswer].uppercased())\n"
            score -= 1
        }
        let finalMessage = questionsAsked >= maxQuestions ? "FINAL " : ""
        var message = "\(wrong)Your \(finalMessage)score is \(score)"
        if questionsAsked >= maxQuestions  && score > highScore {
            message = "\(message)\nThis is your new high score!!!"
            highScore = score
            defaults.set(score, forKey: "HighScore")
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: questionsAsked < maxQuestions ? .default : .destructive, handler: askQuestion))
        present(alertController, animated: true)
        if questionsAsked >= maxQuestions {
            resetGame()
        }
    }
    
    func resetGame() {
        score = 0
        questionsAsked = 0
    }
    
    @objc func showScore() {
        let alertController = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default))
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }
    
    func registerLocalNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {[weak self] (granted, error) in
            if granted {
                print("Yay")
                self?.scheduleLocalNotification()
            }
        }
    }
    
    func scheduleLocalNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Come back and play"
        content.body = "This is time to play the game."
        content.categoryIdentifier = notificationID
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
        print(trigger)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
