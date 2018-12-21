//
//  HumanDesingTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class HumanDesingTableViewCell: UITableViewCell {
    
    @IBOutlet var allBodyGraphNumbersCollection: [BodyGraphNumberView]!
    
    @IBOutlet var upTriangularNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var downTriangularNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var middleBlueRectabgilarNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var yellowRombNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var middleGrayRectangularNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var bottomBlueRectangularNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var redTriangularNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var rightBlueTriangularNumberCollection: [BodyGraphNumberView]!
    @IBOutlet var leftBlueTriangularNumberCollection: [BodyGraphNumberView]!
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        contentView.prepareForInterfaceBuilder()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
