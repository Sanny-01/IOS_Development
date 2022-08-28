//
//  FavoriteNotesVC.swift
//  Sandro Giorgishvili 26
//
//  Created by TBC on 28.08.22.
//

import UIKit

class FavoriteNotesVC: UIViewController {
        
    @IBOutlet weak var favoriteNotesTableView: UITableView!
    
    var notes = [Note]()
    var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        getDataUsingPredicate()
    }
    
    func setUpTableView() {
        favoriteNotesTableView.delegate = self
        favoriteNotesTableView.dataSource = self
    }
    
    func getDataUsingPredicate() {
        let request = Note.fetchRequest()
        
        request.predicate = NSPredicate(format: "isFavorite == true")
        
        let fetchedNotes = try! managedContext.fetch(request)
        
        self.notes = fetchedNotes
        favoriteNotesTableView.reloadData()
    }
}

extension FavoriteNotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteNotesTableView.dequeueReusableCell(withIdentifier: "FavoriteNoteCell") as! FavoriteNoteCell
        
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
        
        destinationVc.setValuesForVariables(noteName: noteName, noteDescription: noteDescription)
        destinationVc.setUpFavoriteNotePage()
        destinationVc.setIdAndIndex(id: id, noteIndex: indexPath.row)
        destinationVc.title = "Favorite note"
        
        self.navigationController?.pushViewController(destinationVc, animated: true)
    }
}
