//
//  TripleSpecificationTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class TripleSpecificationTableViewCell: UITableViewCell {

    @IBOutlet weak var yourTypeLabel: UILabel!
    @IBOutlet weak var yourProfileLabel: UILabel!
    @IBOutlet weak var yourDefinitionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
