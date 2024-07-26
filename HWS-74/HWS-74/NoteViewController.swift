//
//  NoteViewController.swift
//  HWS-74
//
//  Created by Mateusz Bereta on 25/07/2024.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var titleTextView: UITextView!
    @IBOutlet var contentTextView: UITextView!
    
    var noteID: Int?
    let defaults = UserDefaults.standard
    var notes: [Note] = []
    var barButtons = [UIBarButtonItem]()
    
    func emptyNoteConfig(){
        for textView in [titleTextView, contentTextView] {
            textView?.text = nil
            textView?.setColor()
            textView?.setText()
        }
        for barButton in barButtons {
            barButton.isEnabled = false
        }
    }
    
    func buttonConfig() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareTapped))
        
        noteID != nil ? barButtons.append(UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(removeNotes))) : nil
        barButtons.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        barButtons.append(UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(addNotes)))
        
        self.toolbarItems = barButtons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        notes = Note.load(data: defaults.object(forKey: notesKey) as? Data)
        
        buttonConfig()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        titleTextView.delegate = self
        contentTextView.delegate = self
        
        self.navigationController?.isToolbarHidden = false
        
        self.navigationController?.toolbar.backgroundColor = UIColor.clear
        
        if noteID == nil {
            emptyNoteConfig()
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            titleTextView.text = notes[noteID!].title
            contentTextView.text = notes[noteID!].content
        }
    }
    
    @objc func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.setColor()
        textView.setText()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        for barButton in barButtons {
            barButton.isEnabled = !titleTextView.isEmptyWithPlaceholder() && !contentTextView.isEmptyWithPlaceholder()
        }
        navigationItem.rightBarButtonItem?.isEnabled = !titleTextView.isEmptyWithPlaceholder() && !contentTextView.isEmptyWithPlaceholder()
    }
    
    @objc func addNotes() {
        if noteID == nil {
            notes.append(Note(title: titleTextView.text, content: contentTextView.text))
        } else {
            notes[noteID!] = Note(title: titleTextView.text, content: contentTextView.text)
        }
        Note.save(allNotes: notes)
        print(notes)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func removeNotes() {
        notes.remove(at: noteID!)
        Note.save(allNotes: notes)
        print(notes)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func shareTapped() {
        let viewController = UIActivityViewController(activityItems: ["\(titleTextView.text!)\n\(contentTextView.text!)"], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            contentTextView.contentInset = .zero
        } else {
            contentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        contentTextView.scrollIndicatorInsets = contentTextView.contentInset
        
        let selectedRange = contentTextView.selectedRange
        contentTextView.scrollRangeToVisible(selectedRange)
    }
}
