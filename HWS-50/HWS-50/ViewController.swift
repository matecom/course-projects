//
//  ViewController.swift
//  HWS-50
//
//  Created by Mateusz Bereta on 22/07/2024.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos: [Photo] = []
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddPrompt))
        loadPhotos()
    }
    
    func loadPhotos() {
        if let savedPhotos = defaults.object(forKey: "photos") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
            } catch {
                print("Failed to load photos")
            }
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
            print("Saved")
        } else {
            print("Failed to save people.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        let name = photos[indexPath.row].title != "" ? photos[indexPath.row].title : "Unknown"
        cell.textLabel?.text = name
        return cell
    }
    
    @objc func openAddPrompt() {
        let ac = UIAlertController(title: "Select an option", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: {[weak self] action in self?.addPhoto(action)}))
        ac.addAction(UIAlertAction(title: "Select from album", style: .default, handler: {[weak self] action in self?.addPhoto(action)}))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func addPhoto(_ alert: UIAlertAction) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        if alert.title!.contains("Take a photo") {
            picker.sourceType = .camera
        }
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        self.dismiss(animated: true)
        let ac = UIAlertController(title: "Title", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let name = ac?.textFields?[0].text else { return }
            let photo = Photo(image: imageName, title: name)
            self?.photos.append(photo)
            self?.tableView.reloadData()
            self?.save()
        }
        ac.addAction(submit)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "photoVC") as! PhotoViewController
        vc.photo = photos[indexPath.row]
        //self.navigationController?.show(vc, sender: nil)
        present(vc, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
