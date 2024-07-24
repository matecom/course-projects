//
//  ScriptsTableViewController.swift
//  Extension
//
//  Created by Mateusz Bereta on 24/07/2024.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ScriptsTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var webPage: String?
    var scriptsArray: [Script] = []
    var alert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pageURL = webPage else { return }
        scriptsArray = Script.loadScript(data: defaults.object(forKey: pageURL) as? Data)
        print(scriptsArray)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scriptsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Script", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = scriptsArray[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: scriptsArray[indexPath.row].title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Run", style: .default, handler: { [weak self] _ in self?.run(indexPath: indexPath) }))
        ac.addAction(UIAlertAction(title: "Show", style: .default, handler: { [weak self] _ in self?.showScript(indexPath: indexPath) }))
        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { [weak self] _ in self?.renameScript(indexPath: indexPath) }))
        ac.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { [weak self] _ in self?.removeScript(indexPath: indexPath) }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    
    func removeScript(indexPath: IndexPath) {
        scriptsArray.remove(at: indexPath.row)
        Script.save(allScripts: scriptsArray, url: webPage!)
        tableView.reloadData()
    }
    
    func renameScript(indexPath: IndexPath) {
        alert = UIAlertController(title: "Name script", message: nil, preferredStyle: .alert)
        alert!.addTextField() { [weak self] in $0.addTarget(self, action: #selector(self?.alertTextFieldDidChange), for: .editingChanged) }
        let submitAction = UIAlertAction(title: "Save", style: .default, handler: {[weak self, weak alert] _ in
            if alert?.textFields![0].text != nil {
                self?.scriptsArray[indexPath.row].title = alert!.textFields![0].text!
                Script.save(allScripts: self!.scriptsArray, url: self!.webPage!)
                self?.tableView.reloadData()
            }
        })
        alert!.addAction(submitAction)
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert!, animated: true)
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        alert?.actions[0].isEnabled = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
    
    @IBAction func run(indexPath: IndexPath) {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": scriptsArray[indexPath.row].js]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    func showScript(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVCID") as! ActionViewController
        vc.scriptJS = scriptsArray[indexPath.row].js
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
