//
//  ColorVC.swift
//  CardWorkout-Programmatic
//
//  Created by Mateusz Bereta on 09/07/2024.
//

import UIKit

class ColorVC: UIViewController {

    let buttons = [
        CWButton(backgroundColor: .brown, title: "Brown"),
        CWButton(backgroundColor: .darkGray, title: "Gray"),
        CWButton(backgroundColor: .systemPink, title: "Pink"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureButtons()
    }
    
    func configureButtons(){
        for i in 0..<buttons.count{
            view.addSubview(buttons[i])
            buttons[i].translatesAutoresizingMaskIntoConstraints = false
            if(i==0){
                NSLayoutConstraint.activate([
                    buttons[i].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 60),
                    buttons[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                    buttons[i].trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
                ])
            }
            else{
                NSLayoutConstraint.activate([
                    buttons[i].topAnchor.constraint(equalTo: buttons[i-1].bottomAnchor, constant: 60),
                    buttons[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                    buttons[i].trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
                ])
            }
            buttons[i].addTarget(self, action: #selector(backWithColor), for: .touchUpInside)
        }
    }
    
    @objc func backWithColor(sender:CWButton){
        let cardSelectionVC = CardSelectionVC()
        cardSelectionVC.backgroundColor = sender.backgroundColor
//        self.navigationController?.viewControllers = [cardSelectionVC]
        let vc:CardSelectionVC = self.navigationController?.viewControllers[0] as! CardSelectionVC
        vc.backgroundColor = sender.backgroundColor
        self.navigationController?.popToRootViewController(animated: true)
    }

}
