//
//  GenreCell.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 14.07.22.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    @IBOutlet weak var genreLbl: UILabel!
    var genre: String! {
        didSet {
            guard let genre = genre else {
                return
            }
            genreLbl.text = genre
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
