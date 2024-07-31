//
//  ViewController.swift
//  HWS-32
//
//  Created by Mateusz Bereta on 18/07/2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList: [String] = []
    var alert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(promptAddItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(promptMenu))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Remove item", message: "Do you want remove \(shoppingList[indexPath.row]) from the list?", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] action in
            self?.shoppingList.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func promptAddItem() {
        alert = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        alert!.addTextField() {[weak self] in $0.addTarget(self, action: #selector(self?.alertTextFieldDidChange), for: .editingChanged) }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alert] action in
            guard let item = alert?.textFields?[0].text else { return }
            self?.addItem(item)
        }
        
        submitAction.isEnabled = false
        alert!.addAction(submitAction)
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert!, animated: true)
    }
    
    func promptClearList() {
        let ac = UIAlertController(title: "Clear shopping list", message: "Do you want clear the shopping list?", preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Clear", style: .destructive) { [weak self] action in
            self?.shoppingList = []
            self?.tableView.reloadData()
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func promptMenu() {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let clearAction = UIAlertAction(title: "Clear list", style: .destructive, handler: {[weak self] _ in
            self?.promptClearList()
        })
        let shareAction = UIAlertAction(title: "Share list", style: .default, handler: {[weak self] _ in
            self?.promptShareList()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(clearAction)
        optionMenu.addAction(shareAction)
        optionMenu.addAction(cancelAction)
        
        if shoppingList.isEmpty {
            clearAction.isEnabled = false
            shareAction.isEnabled = false
        }
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func promptShareList() {
        let viewController = UIActivityViewController(activityItems: ["My shopping list: \n\(shoppingList.joined(separator: "\n"))"], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
    
    func addItem(_ item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        alert?.actions[0].isEnabled = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
}

