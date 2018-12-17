//
//  TypeViewTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class TypeViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView! {didSet{bgView.layer.cornerRadius=20}}
    @IBOutlet weak var typeImage: UIImageView! {didSet{typeImage.layer.cornerRadius=20}}
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var personalLabel: UILabel!
    @IBOutlet weak var notifyButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
