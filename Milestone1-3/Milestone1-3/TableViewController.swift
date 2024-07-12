//
//  TableViewController.swift
//  Milestone1-3
//
//  Created by Mateusz Bereta on 12/07/2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var pictures: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        do {
            let items = try fileManager.contentsOfDirectory(atPath: path)
            for item in items where item.hasSuffix("2x.png") {
                pictures.append("\(item.dropLast(7))")
            }
        } catch {
            print("Error with file manager")
        }
        title = "Flags APP"
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        //cell.textLabel?.text = pictures[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = pictures[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            detailVC.countryName = pictures[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
