//
//  ViewController.swift
//  Sandro Giorgishvili 26
//
//  Created by TBC on 26.08.22.
//

import UIKit

class ViewController: UIViewController, addNoteDelegate, noteCellDelegate {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var notes = [Note]()
    
    var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addNote(noteName: String, noteDescription: String) {
        let newNote = Note(context: managedContext)
        
        newNote.id = UUID()
        newNote.name = noteName
        newNote.descriptionOfNote = noteDescription
        newNote.isFavorite = false
        do {
            try managedContext.save()
            getData()
        }  catch {
            print("Error occured could not add note")
        }
    }
    
    func editNote(index: Int, noteName: String, noteDescription: String) {
        let noteToEdit = notes[index]
        
        do {
            noteToEdit.name = noteName
            noteToEdit.descriptionOfNote = noteDescription
            
            try managedContext.save()
            getData()
        } catch {
            print("Could not edit note")
        }
    }
    
    func deleteNote(cell: NoteCell) {
        if let indexPath = notesTableView.indexPath(for: cell) {
            
            do {
                let noteToRemove = notes[indexPath.row]
                managedContext.delete(noteToRemove)
                                      
                try managedContext.save()
                getData()
            } catch {
                print("Error while deleting note")
            }
        }
    }
    
    func changeNoteIsFavoriteProperty(cell: NoteCell) -> Bool {
        if let indexPath = notesTableView.indexPath(for: cell) {
            let noteToEdit = notes[indexPath.row]
            
            do {
                noteToEdit.isFavorite = noteToEdit.isFavorite ? false : true
                
                try managedContext.save()
                getData()
            } catch {
                print("Could not edit note")
                
                return false
            }
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        getData()
    }
    
    func setUpTableView() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
    func getData() {
        do {
            let fetchedNotes = try managedContext.fetch(Note.fetchRequest())
            
            notes = fetchedNotes
            notesTableView.reloadData()
        } catch {
            print("Error occured while fetching data")
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = storyboard.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
        destinationVc.delegate = self
        self.navigationController?.pushViewController(destinationVc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notesTableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteCell
        
        cell.delegate = self
        
        if notes[indexPath.row].isFavorite {
            cell.setFavoriteButtonColor(color: .systemYellow)
        } else {
            cell.setFavoriteButtonColor(color: .lightGray)
        }
        
        cell.titleLbl.text = notes[indexPath.row].name
        cell.descriptionLbl.text = notes[indexPath.row].descriptionOfNote
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = storyboard.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
        
        guard let noteName = notes[indexPath.row].name else { return }
        guard let noteDescription = notes[indexPath.row].descriptionOfNote else { return }
        guard let id = notes[indexPath.row].id else { return }
        
        destinationVc.delegate = self
        destinationVc.setValuesForVariables(noteName: noteName, noteDescription: noteDescription)
        destinationVc.setIdAndIndex(id: id, noteIndex: indexPath.row)
        destinationVc.title = "Edit Note"
        
        self.navigationController?.pushViewController(destinationVc, animated: true)
    }
}

extension UIViewController {
    func pushToViewController(identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = storyboard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(destinationVc, animated: true)
    }
    
    func showAlertWithOkButton(title: String?, message: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let titleAttrString = NSMutableAttributedString(string: message, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
        ])
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.setValue(titleAttrString, forKey:"attributedTitle")
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(action)
        alertController.view.backgroundColor = UIColor.clear
        
        self.present(alertController, animated: true)
    }
}
