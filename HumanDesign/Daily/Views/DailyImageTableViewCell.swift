//
//  DailyImageTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class DailyImageTableViewCell: UITableViewCell {

 
    @IBOutlet weak var dayLabel: UILabel! {
        didSet{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let stringDate = dateFormatter.string(from: Date())
            dayLabel.text = stringDate
        }
    }
    @IBOutlet weak var dayView: UIView!{
        didSet{
            dayView.layer.cornerRadius = 6
            dayView.isUserInteractionEnabled = false
        }
    }
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
