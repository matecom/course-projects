//
//  ViewController.swift
//  PhotosProject
//
//  Created by Mateusz Bereta on 11/07/2024.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        do {
            let items = try fileManager.contentsOfDirectory(atPath: path)
            for item in items where item.hasPrefix("nssl") {
                pictures.append(item)
            }
        } catch {
            print("Error with file manager")
        }
        pictures.sort()
        print(pictures)
        title = "Storm Viewer"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell.")
        }
        cell.labelName.text = pictures[indexPath.item]
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            detailVC.selectedImage = pictures[indexPath.item]
            detailVC.numberOfPhotos = pictures.count
            detailVC.photoNumber = indexPath.item
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let viewController = UIActivityViewController(activityItems: ["Recomend app"], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
}
