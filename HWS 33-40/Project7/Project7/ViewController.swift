//
//  ViewController.swift
//  Project7
//
//  Created by Mateusz Bereta on 16/07/2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var petitionsJson = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredit))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filtr", style: .plain, target: self, action: #selector(setFilter))
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitionsJson = jsonPetitions.results
            filter("")
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showCredit() {
        let ac = UIAlertController(title: "Credit", message: "Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default)
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func setFilter() {
        let ac = UIAlertController(title: "Enter filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let filter = ac?.textFields?[0].text else { return }
            self?.filter(filter)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func filter(_ filterString: String) {
        if !filterString.isEmpty {
            petitions = petitionsJson.filter { $0.title.contains(filterString) }
        } else {
            petitions = petitionsJson
        }
        tableView.reloadData()
    }
}

