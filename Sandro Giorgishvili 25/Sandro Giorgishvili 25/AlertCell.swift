//
//  AlertCell.swift
//  Sandro Giorgishvili 25
//
//  Created by TBC on 24.08.22.
//

import UIKit

protocol AlertCellDelegate {
    func deleteDirectoryFile(cell: AlertCell)
    func editAlert(cell: AlertCell)
}

class AlertCell: UITableViewCell {

    @IBOutlet weak var alertDateLbl: UILabel!
    @IBOutlet weak var alertNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellWithValuesOf(alertName: String, alertDate: String) {
        updateUI(alertName: alertName, alertDate: alertDate)
    }
    
    private func updateUI(alertName: String, alertDate: String) {
        self.alertNameLbl.text = alertName
        self.alertDateLbl.text = alertDate
    }
    
    var delegate: AlertCellDelegate!
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate.deleteDirectoryFile(cell: self)
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        delegate.editAlert(cell: self)
    }
}
