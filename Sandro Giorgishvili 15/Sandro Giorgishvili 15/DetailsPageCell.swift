//
//  DetailsPageCell.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 14.07.22.
//

import UIKit

class DetailsPageCell: UICollectionViewCell {
    
    @IBOutlet weak var filmNameLbl: UILabel!
    
    var filmTitle: String! {
        didSet {
            guard let title = filmTitle else {
                return
            }
            filmNameLbl.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
