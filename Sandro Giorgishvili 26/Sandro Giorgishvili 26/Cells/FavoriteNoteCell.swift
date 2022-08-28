//
//  FavoriteNoteCell.swift
//  Sandro Giorgishvili 26
//
//  Created by TBC on 28.08.22.
//

import UIKit

class FavoriteNoteCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
