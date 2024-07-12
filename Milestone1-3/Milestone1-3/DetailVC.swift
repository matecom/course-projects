//
//  DetailVC.swift
//  Milestone1-3
//
//  Created by Mateusz Bereta on 12/07/2024.
//

import UIKit

class DetailVC: UIViewController {
    
    var countryName: String?
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageToLoad = countryName {
            imageView.image = UIImage(named: "\(imageToLoad)@3x.png")
        }
        title = countryName?.uppercased()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let viewController = UIActivityViewController(activityItems: ["Flag of: \(countryName!)",image], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }

}
