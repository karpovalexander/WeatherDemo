//
//  CityTableViewCell.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import UIKit
import TableKit

class CityTableViewCell: UITableViewCell, ConfigurableCell {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 12
        photoImageView.backgroundColor = .imagePlaceholder
        
        nameLabel.font = .medium(size: 17)
        
        separatorView.backgroundColor = .separator
    }
    
    // MARK: - ConfigurableCell
    
    func configure(with item: CityCellViewModel) {
        photoImageView.setImage(with: item.imageURL)
        nameLabel.text = item.title
    }
    
    static var defaultHeight: CGFloat? {
        72
    }
}
