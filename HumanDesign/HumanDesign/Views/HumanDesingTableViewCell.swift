//
//  HumanDesingTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class HumanDesingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroungView: UIImageView!
    @IBOutlet weak var lineView: BodyGraphBackgroundView!
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
    
//    private var lineView: BodyGraphBackgroundView = BodyGraphBackgroundView()
    
    var activeRedNumbers: [Int] = []
    var activeBlueNumbers: [Int] = []
    
    var activeNumbers: [Int] = [] {
        didSet {
            reloadCellData()
//            lineView.setNeedsLayout()
        }
    }
    
    private let connectedByLinesGraphNumbers: [Int:Int] = [
        64:47,
        61:24,
        63:4,
        17:62,
        11:56,
        43:23,
        16:48,
        20:57,
        31:7,
        8:1,
        33:13,
        35:36,
        12:22,
        45:21,
        10:34,
        25:51,
        15:5,
        2:14,
        46:29,
        44:26,
        27:50,
        40:37,
        59:6,
        42:53,
        3:60,
        9:52,
        32:54,
        28:38,
        18:58,
        19:49,
        39:55,
        41:30
    ]
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        contentView.prepareForInterfaceBuilder()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView.numberViews = allBodyGraphNumbersCollection
        lineView.connectedByLinesGraphNumbers = connectedByLinesGraphNumbers
        lineView.setNeedsLayout()
        
    }
    
    func drawGraphLines() {
        lineView.numberViews = allBodyGraphNumbersCollection
        lineView.connectedByLinesGraphNumbers = connectedByLinesGraphNumbers
        lineView.setNeedsLayout()
    }
    
    private func reloadCellData() {
        reloadCellNumbers()
//        drawGraphLines()
    }
    
    private func reloadCellNumbers() {
        for graphNumber in allBodyGraphNumbersCollection {
            graphNumber.numberIsActive = activeNumbers.contains(graphNumber.labelsNumber)
        }
    }
}
