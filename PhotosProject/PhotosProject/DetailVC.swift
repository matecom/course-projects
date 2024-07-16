//
//  DetailVC.swift
//  PhotosProject
//
//  Created by Mateusz Bereta on 11/07/2024.
//

import UIKit

class DetailVC: UIViewController {
    var selectedImage: String?
    var numberOfPhotos: Int?
    var photoNumber: Int?
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        if(photoNumber != nil && numberOfPhotos != nil){
            title = "Picture \(photoNumber!+1) of \(numberOfPhotos!)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
