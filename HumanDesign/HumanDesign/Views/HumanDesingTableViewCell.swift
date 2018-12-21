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
    
    private var lineView: UIView = UIView()
    
    var activeNumbers: [Int] = [] {
        didSet {
            reloadCellData()
//            setNeedsLayout()
        }
    }
    
    //TODO: use this dictionary for drawing lines
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
        3:6,
        42:53,
        3:60,
        9:52,
        32:54,
        28:38,
        17:58,
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
        lineView.removeFromSuperview()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lineView.removeFromSuperview()
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        drawGraphLines()
//    }
    
    private func reloadCellData() {
        reloadCellNumbers()
        drawGraphLines()
    }
    
    private func reloadCellNumbers() {
        for graphNumber in allBodyGraphNumbersCollection {
            graphNumber.numberIsActive = activeNumbers.contains(graphNumber.labelsNumber)
        }
    }

    func drawGraphLines() {
        let lineView = UIView(frame: self.bounds)
        for lineIndexes in connectedByLinesGraphNumbers {
            guard let startOfLine = allBodyGraphNumbersCollection.first (where: { (numberView) -> Bool in
                numberView.labelsNumber == lineIndexes.key
            }) else { return }
            guard let endOfLine = allBodyGraphNumbersCollection.first (where: { (numberView) -> Bool in
                numberView.labelsNumber == lineIndexes.value
            }) else { return }
            drawLine(from: startOfLine, to: endOfLine)
        }
        self.insertSubview(lineView, aboveSubview: backgroungView)
    }
    
    private func drawLine(from firstNumberView: BodyGraphNumberView, to secondNumberView: BodyGraphNumberView) {
        let linePath = UIBezierPath()
        linePath.lineWidth = 4.0
        linePath.move(to: firstNumberView.center)
        linePath.addLine(to: secondNumberView.center)
    }
}
