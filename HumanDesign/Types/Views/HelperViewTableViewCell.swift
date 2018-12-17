//
//  HelperViewTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class HelperViewTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView! {didSet{mainView.layer.cornerRadius = 10}}
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var button: UIButton!{didSet{button.layer.cornerRadius = 25}}

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
