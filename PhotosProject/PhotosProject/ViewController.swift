//
//  ViewController.swift
//  PhotosProject
//
//  Created by Mateusz Bereta on 11/07/2024.
//

import UIKit

class ViewController: UITableViewController {
    var pictures: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        /// this code from course will be deprecated, but I need this to change style in storeboard
        cell.textLabel?.text = pictures[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = pictures[indexPath.row]
//        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            detailVC.selectedImage = pictures[indexPath.row]
            detailVC.numberOfPhotos = pictures.count
            detailVC.photoNumber = indexPath.row
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
