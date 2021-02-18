//
//  EarthQuakeCell.swift
//  EarthQuakeCollector
//
//  Created by Keval Patel on 2/16/21.
//

import UIKit

class EarthQuakeCell: UITableViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    static let cellIdentifier: String = "EarthQuakeCell"
    public var earthQuakeCellModel: EarthQuakeProperties? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
        guard let model = earthQuakeCellModel else {
            return
        }
        titleLabel.text = model.title
        detailLabel.text = model.eventDetailDescription
        statusLabel.text = model.statusDetailDescription
        profileLabel.text = model.profileLetter
        addAccessibility(model: model)
    }
    
}

//MARK: - Registrable
extension EarthQuakeCell {
    static var reuseIdentifier: String {
        return cellIdentifier
    }
}

//MARK:- ADA Configuration
extension EarthQuakeCell {
    enum Elements: String {
        case titleLabel
        case detailLabel
        case profileLabel
        case statusLabel
    }
    
    /// Adds accesibility to `UIElements`
    /// - Parameter model: `EarthQuakeProperties`
    private func addAccessibility(model: EarthQuakeProperties) {
        titleLabel.addAccessibility(accessibilityproperties: AccessibilityProperties(accessibilityLabel: model.title, accessibilityIdentifier: Elements.titleLabel.rawValue))
        detailLabel.addAccessibility(accessibilityproperties: AccessibilityProperties(accessibilityLabel: model.eventDetailDescription, accessibilityIdentifier: Elements.detailLabel.rawValue))
        statusLabel.addAccessibility(accessibilityproperties: AccessibilityProperties(accessibilityLabel: model.statusDetailDescription, accessibilityIdentifier: Elements.statusLabel.rawValue))
        profileLabel.addAccessibility(accessibilityproperties: AccessibilityProperties(accessibilityLabel: model.profileLetter, accessibilityIdentifier: Elements.profileLabel.rawValue))
    }
}

// MARK: - UI Configuration Methods
extension EarthQuakeCell {
    private func configureUI() {
        configureColor()
        configureFont()
        configureProfileLabel()
    }
    
    /// configures the colors of `UIElement`
    private func configureColor() {
        titleLabel.textColor = EbayColors.titleColor
        profileLabel.textColor = EbayColors.white
        detailLabel.textColor = EbayColors.bodyColor
        statusLabel.textColor = EbayColors.bodyColor
        profileLabel.backgroundColor = EbayColors.primaryColor
    }
    
    /// configures the fonts of `UIElement`
    private func configureFont() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        profileLabel.font = .boldSystemFont(ofSize: 24)
    }
    
    /// configures the layout of `profileLabel`
    private func configureProfileLabel() {
        profileLabel.layer.cornerRadius = self.profileLabel.frame.height/2
        profileLabel.backgroundColor = EbayColors.primaryColor
        profileLabel.clipsToBounds = true
    }
}
