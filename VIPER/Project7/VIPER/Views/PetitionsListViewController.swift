//
//  PetitionsListViewController.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation
import UIKit

protocol PetitionsListViewProtocol {
    func show(petitionsList: [Petition])
    func showError()
}

class PetitionsListViewController: UITableViewController, PetitionsListViewProtocol {
    private var presenter: PetitionsListViewControllerPresenterProtocol?
    private var petitions: [Petition] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VIPER Project 7"
        presenter = PetitionsListPresenter(view: self)
        presenter?.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filtr", style: .plain, target: self, action: #selector(setFilter))
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
        presenter?.showDetails(petitions[indexPath.row])
    }
    
    func show(petitionsList: [Petition]) {
        petitions = petitionsList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async { [weak self] in
            self?.present(ac, animated: true)
        }
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
            DispatchQueue.global(qos: .userInitiated).async {
                self?.presenter?.setFilter(filter)
            }
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}
