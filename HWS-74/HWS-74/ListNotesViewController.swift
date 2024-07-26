//
//  ViewController.swift
//  HWS-74
//
//  Created by Mateusz Bereta on 25/07/2024.
//

import UIKit

class ListNotesViewController: UITableViewController {
    
    var notes: [Note] = []
    let noteCounter = UIBarButtonItem(title: "\(0) notes", style: .plain, target: nil, action: nil)
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        
        notes = Note.load(data: defaults.object(forKey: notesKey) as? Data)
                
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        self.navigationController?.isToolbarHidden = false

        var items = [UIBarButtonItem]()
        
        noteCounter.title = "\(notes.count) notes"
        noteCounter.isEnabled = false
        noteCounter.tintColor = UIColor.black
        
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(noteCounter)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNotes)))

        self.toolbarItems = items
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notes = Note.load(data: defaults.object(forKey: notesKey) as? Data)
        noteCounter.title = "\(notes.count) notes"
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].content
        return cell
    }
    
    @objc func addNotes() {
        showNote()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showNote(noteID: indexPath.row)
    }
    
    func showNote(noteID: Int? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NoteVCID") as! NoteViewController
        vc.noteID = noteID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

