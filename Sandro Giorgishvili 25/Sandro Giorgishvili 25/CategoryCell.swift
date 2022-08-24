//
//  CountryCell.swift
//  Sandro Giorgishvili 25
//
//  Created by TBC on 24.08.22.
//

import UIKit

protocol CategoryCellDelegate {
    func deleteDirectory(cell: CategoryCell)
}

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setCellWithValuesOf(categoryName: String) {
        updateUI(categoryName: categoryName)
    }
    
    private func updateUI(categoryName: String) {
        self.categoryNameLbl.text = categoryName
    }
    
    var delegate: CategoryCellDelegate!
    
    @IBAction func deleteDirectory(_ sender: Any) {
        delegate.deleteDirectory(cell: self)
    }
}
