//
//  TripleSpecificationTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class TripleSpecificationTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var yourTypeTitle: UILabel!
    @IBOutlet weak var yourProfileTitle: UILabel!
    @IBOutlet weak var yourDefinitionTitle: UILabel!
    
    @IBOutlet weak var yourTypeLabel: UILabel!
    @IBOutlet weak var yourProfileLabel: UILabel!
    @IBOutlet weak var yourDefinitionLabel: UILabel!
    
    @IBOutlet weak var selectTypeButton: UIButton!
    @IBOutlet weak var selectProvileButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
