//
//  CountryCell.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 30.08.22.
//

import UIKit

class CountryCell: UITableViewCell {
    
    
    static var identifier: String { .init(describing: self) }
    
    let countryLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(with model: CountryCellModel) {
        countryLabel.text = model.title
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        addSubview(countryLabel)
        countryLabel.anchor(left: leftAnchor, paddingLeft: 15)
        countryLabel.anchor(top: topAnchor, paddingTop: 10)
    }
}
