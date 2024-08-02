//
//  PhotoViewController.swift
//  HWS-50
//
//  Created by Mateusz Bereta on 22/07/2024.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photo: Photo?
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if photo != nil {
            nameLabel.text = photo?.title
            let path = getDocumentsDirectory().appendingPathComponent(photo!.image)
            imageView.image = UIImage(contentsOfFile: path.path)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
