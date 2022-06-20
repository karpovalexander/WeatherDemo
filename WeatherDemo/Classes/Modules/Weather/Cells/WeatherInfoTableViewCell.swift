//
//  WeatherInfoTableViewCell.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit
import TableKit

class WeatherInfoTableViewCell: UITableViewCell, ConfigurableCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .medium(size: 12)
        titleLabel.textColor = .gray
        
        valueLabel.font = .regular(size: 17)
        
        separatorView.backgroundColor = .separator
    }
    
    // MARK: - ConfigurableCell
    
    func configure(with item: WeatherInfoCellViewModel) {
        titleLabel.text = item.title
        valueLabel.text = item.value
    }
    
    static var defaultHeight: CGFloat? {
        52
    }
}
