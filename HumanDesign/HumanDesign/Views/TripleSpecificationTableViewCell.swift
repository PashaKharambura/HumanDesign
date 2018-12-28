//
//  TripleSpecificationTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class TripleSpecificationTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var yourTypeTitle: UILabel!{didSet{yourTypeTitle.text = NSLocalizedString("Ваш тип", comment: "")}}
    @IBOutlet weak var yourProfileTitle: UILabel! {didSet{yourProfileLabel.text = NSLocalizedString("Ваш профиль", comment: "")}}
    @IBOutlet weak var yourDefinitionTitle: UILabel! {didSet{yourDefinitionLabel.text = NSLocalizedString("Вашe определение", comment: "")}}
    
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
