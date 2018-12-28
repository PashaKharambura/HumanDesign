//
//  WhiteButtonTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class WhiteButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton! {didSet{
        button.layer.cornerRadius = 25
        button.setTitle(NSLocalizedString("Смотреть все", comment: ""), for: .normal)
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
