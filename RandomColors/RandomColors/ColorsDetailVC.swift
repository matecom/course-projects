//
//  ColorsDetailVC.swift
//  RandomColors
//
//  Created by Mateusz Bereta on 05/07/2024.
//

import UIKit

class ColorsDetailVC: UIViewController {
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color ?? .blue
    }
    @IBAction func showColorButtonTapped(_ sender: Any) {
        let alertColor = color ?? .blue
        let alertString: String = alertColor.getRGB() + "\n" + alertColor.getHEX()
        let alert = UIAlertController(title: "Color", message:alertString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Close alert"), style: .default, handler: { _ in
        
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Exit", comment: "Close color"), style: .destructive, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
