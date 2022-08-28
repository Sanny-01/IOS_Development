//
//  NoteDetailsVC.swift
//  Sandro Giorgishvili 26
//
//  Created by TBC on 26.08.22.
//

import UIKit

protocol addNoteDelegate {
    func addNote(noteName: String, noteDescription: String)
    func editNote(index: Int, noteName: String, noteDescription: String)
}

class NoteDetailsVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var noteTextView: UITextView!
    
    var name: String!
    var noteText: String!
    var id: UUID?
    var noteIndex: Int?
    
    var delegate: addNoteDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        
        if saveButton.isEnabled == false { disableEditing() }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let noteName = nameTextField.text else { return }
        guard let noteText = noteTextView.text else { return }
        
        if noteText.isEmpty || noteName.isEmpty  {
            showAlertWithOkButton(title: nil, message: "Fields should not be left empty")
        } else {
            
            if id == nil {
                delegate.addNote(noteName: noteName , noteDescription: noteTextView.text)
                _ = navigationController?.popViewController(animated: true)
            } else {
                guard let noteIndex = noteIndex else { return }
                
                delegate.editNote(index: noteIndex , noteName: noteName, noteDescription: noteText)
            }
        }
    }
    
    func setValuesForVariables(noteName: String, noteDescription: String) {
        name = noteName
        noteText = noteDescription
    }
    
    func setIdAndIndex(id: UUID, noteIndex: Int) {
        self.id = id
        self.noteIndex = noteIndex
    }
    
    func updateUI() {
        nameTextField.text = name
        noteTextView.text = noteText
    }
    
    func setUpFavoriteNotePage() {
        saveButton.isEnabled = false
    }
    
    func disableEditing() {
        nameTextField.isEnabled = false
        noteTextView.isEditable = false
    }
}
