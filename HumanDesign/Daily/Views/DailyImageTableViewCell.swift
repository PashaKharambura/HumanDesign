//
//  DailyImageTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class DailyImageTableViewCell: UITableViewCell {

 
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayView: UIView!{didSet{dayView.layer.cornerRadius=6}}
    @IBOutlet weak var dailyImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
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
        
        gradientLayer.frame = self.dailyImage.frame
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        self.gradientView.layer.addSublayer(gradientLayer)
    }
    
}
