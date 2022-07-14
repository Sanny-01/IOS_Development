//
//  CustomCell.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 12.07.22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
