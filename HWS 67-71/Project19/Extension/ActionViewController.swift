//
//  ActionViewController.swift
//  Extension
//
//  Created by Mateusz Bereta on 23/07/2024.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    
    var pageTitle = ""
    var pageURL = ""
    var scriptJS = ""
    var alert: UIAlertController?
    let defaults = UserDefaults.standard
    
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = scriptJS
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Script", style: .plain, target: self, action: #selector(showScriptMenu))
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }
    
    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": textView.text ?? ""]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
    @objc func showScriptMenu() {
        let ac = UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Save script", style: .default, handler: saveScript)
        saveAction.isEnabled = !textView.text.isEmpty
        
        ac.addAction(UIAlertAction(title: "alert(document.title)", style: .default, handler: copyScript))
        ac.addAction(UIAlertAction(title: "Show saved scripts", style: .default, handler: presentTableView))
        ac.addAction(saveAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func copyScript(_ alert: UIAlertAction) {
        textView.text = alert.title
    }
    
    func presentTableView(_ alert: UIAlertAction) {
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScriptsVCID") as! ScriptsTableViewController
        vc.webPage = pageURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveScript(_:UIAlertAction) {
        var scriptsArray = Script.loadScript(data: defaults.object(forKey: pageURL) as? Data)
        alert = UIAlertController(title: "Name script", message: nil, preferredStyle: .alert)
        alert!.addTextField() {[weak self] in $0.addTarget(self, action: #selector(self?.alertTextFieldDidChange), for: .editingChanged) }
        let submitAction = UIAlertAction(title: "Save", style: .default, handler: {[weak self, weak alert] _ in
            if self?.textView.text != nil && alert?.textFields![0].text != nil && self?.pageURL != nil {
                scriptsArray.append(Script(js: self!.textView.text!, title: alert!.textFields![0].text!))
                Script.save(allScripts: scriptsArray, url: self!.pageURL)
                print(scriptsArray)
            }
        })
        submitAction.isEnabled = false
        alert!.addAction(submitAction)
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert!, animated: true)
    }
    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        alert?.actions[0].isEnabled = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
}
