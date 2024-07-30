//
//  PetitionsListViewController.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation
import UIKit

class PetitionsListViewController: UITableViewController, PetitionsListView {
    private let presenter: PetitionsListPresenter
    private var petitions: [Petition] = []
    
    init(presenter: PetitionsListPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VIPER Project 7"
        presenter.viewDidLoad(view: self)
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
        //        let vc = DetailViewController()
        //        vc.detailItem = petitions[indexPath.row]
        //        navigationController?.pushViewController(vc, animated: true)
    }
    
    func show(petitionsList: [Petition]) {
        petitions = petitionsList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
