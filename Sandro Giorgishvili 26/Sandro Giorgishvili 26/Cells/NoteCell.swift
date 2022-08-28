//
//  NoteCell.swift
//  Sandro Giorgishvili 26
//
//  Created by TBC on 26.08.22.
//

import UIKit

protocol noteCellDelegate {
    func deleteNote(cell: NoteCell)
    func changeNoteIsFavoriteProperty(cell: NoteCell) -> Bool
}
class NoteCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var color: UIColor!
    var delegate: noteCellDelegate!
    let starButton = UIButton(type: .system)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setFavoriteButtonColor(color: UIColor) {
        favoriteButton.tintColor = color
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate.deleteNote(cell: self)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let check = delegate.changeNoteIsFavoriteProperty(cell: self)
        
        // if update was successfull only then change color
        if check {
            favoriteButton.tintColor = favoriteButton.tintColor == .lightGray ? .systemYellow : .lightGray
        }
    }
}
