//
//  ViewController.swift
//  Project10
//
//  Created by Mateusz Bereta on 18/07/2024.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWithAlbum))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addWithCamera))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {            
            fatalError("Unable to dequeue PersonCell.")
        }
        let person = people[indexPath.item]
        
        cell.nameView.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(title: "What do you want?", message: nil, preferredStyle: .alert)
        let rename = UIAlertAction (title: "Rename the person", style: .default) { [weak self, weak person] _ in
            self?.renamePerson(person!)
        }
        let remove = UIAlertAction (title: "Remove the person", style: .destructive) { [weak self, weak person] _ in
            self?.removePerson(person!)
        }
        ac.addAction(rename)
        ac.addAction(remove)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    
    func renamePerson(_ person: Person) {
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "ok", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            self?.collectionView.reloadData()
        }
        ac.addAction(submit)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    
    func removePerson(_ personToRemove: Person) {
        let ac = UIAlertController(title: "Remove person", message: "Are you sure?", preferredStyle: .alert)
        let submit = UIAlertAction(title: "Yes", style: .destructive) { [weak self, weak personToRemove] _ in
            self?.people.removeAll(where: { person in person == personToRemove } )
            self?.collectionView.reloadData()
        }
        ac.addAction(submit)
        ac.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ac,animated: true)
    }
    
    @objc func addWithCamera() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let ac = UIAlertController(title: "You don't have camera", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(ac,animated: true)
            return
        } else {
            picker.sourceType = .camera
            present(picker, animated: true)
        }
    }
    
    @objc func addWithAlbum() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
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
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

