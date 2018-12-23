//
//  HumanDesingTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class HumanDesingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroungView: UIImageView!
    
    @IBOutlet weak var leftGraphNumberBar: BodyGraphNumericSymbolBar!
    @IBOutlet weak var rightGraphNumberBar: BodyGraphNumericSymbolBar!
    
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
    
    var activeRedNumbers: [Double] = [] {
        didSet {
            leftGraphNumberBar.symbolNumbers = activeRedNumbers
        }
    }
    
    var activeBlueNumbers: [Double] = []
    {
        didSet {
            rightGraphNumberBar.symbolNumbers = activeBlueNumbers
        }
    }
    
    var activeNumbers: [ActiveBodyGraphNumber] = [] {
        didSet {
            reloadCellData()
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
//        10:34,
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
    
    private let specificDots: [Int] = [10, 34]
    
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
        lineView.drawLineFromSpecificPlace = specificDots
        lineView.setNeedsDisplay()
    }
    
    func drawGraphLines() {
        lineView.numberViews = allBodyGraphNumbersCollection
        lineView.connectedByLinesGraphNumbers = connectedByLinesGraphNumbers
        lineView.drawLineFromSpecificPlace = specificDots
        lineView.setNeedsLayout()
    }
    
    private func reloadCellData() {
        reloadCellNumbers()
    }
    
    private func reloadCellNumbers() {
        for graphNumber in allBodyGraphNumbersCollection {
            let numbers = activeNumbers.filter {$0.number==graphNumber.labelsNumber}

            if let activeNumber = activeNumbers.first(where: { (activeNumber) -> Bool in
                activeNumber.number == graphNumber.labelsNumber
            }) {
                graphNumber.numberIsActive = true
                graphNumber.activeLineColor = activeNumber.color
                if numbers.count > 1 {
                    let red = numbers.filter {$0.color == .red}
                    let blue = numbers.filter {$0.color == .blue}
                    if red.count > 0 && blue.count > 0 {
                        graphNumber.activeLineColor = .violet
                    }
                }
            } else {
                graphNumber.activeLineColor = .white
                graphNumber.numberIsActive = false
            }
        }
    }
}
