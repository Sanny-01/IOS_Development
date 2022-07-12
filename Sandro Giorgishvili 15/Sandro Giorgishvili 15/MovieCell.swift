//
//  MovieCell.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 12.07.22.
//

import UIKit

protocol MovieCellDelegate {
    func addMovie(cell: MovieCell)
}

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    
    var delegate: MovieCellDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        delegate.addMovie(cell: self)
    }
}
