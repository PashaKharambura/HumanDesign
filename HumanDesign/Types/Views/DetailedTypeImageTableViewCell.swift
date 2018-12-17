//
//  DetailedTypeImageTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class DetailedTypeImageTableViewCell: UITableViewCell {

    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.typeImage.frame
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
    }
    
}
