//
//  CWButton.swift
//  CardWorkout-Programmatic
//
//  Created by Mateusz Bereta on 08/07/2024.
//

import UIKit

class CWButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }
    func configure(){
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 19,weight: .bold)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
