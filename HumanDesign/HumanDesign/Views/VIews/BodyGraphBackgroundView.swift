//
//  BodyGraphBackgroundView.swift
//  HumanDesign
//
//  Created by Dmytro Pasinchuk on 12/21/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class BodyGraphBackgroundView: UIView {
    
//    @IBOutlet var contentView: UIView!
    
    var numberViews: [BodyGraphNumberView] = []
    var connectedByLinesGraphNumbers: [Int:Int] = [:]

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        guard !numberViews.isEmpty, !connectedByLinesGraphNumbers.isEmpty else { return }
        drawGraphLines()
    }
    
    func drawGraphLines() {
        for lineIndexes in connectedByLinesGraphNumbers {
            guard let startOfLine = numberViews.first (where: { (numberView) -> Bool in
                numberView.labelsNumber == lineIndexes.key
            }) else { return }
            guard let endOfLine = numberViews.first (where: { (numberView) -> Bool in
                numberView.labelsNumber == lineIndexes.value
            }) else { return }
            drawLine(from: startOfLine, to: endOfLine)
        }
    }
    
    private func drawLine(from firstNumberView: BodyGraphNumberView, to secondNumberView: BodyGraphNumberView) {
        let startCoordinate = firstNumberView.center
        let endCoordinate = secondNumberView.center
        
        let linePath = UIBezierPath()
        linePath.lineWidth = 4.0
        UIColor.white.setStroke()
        linePath.move(to: startCoordinate)
        linePath.addLine(to: endCoordinate)
        linePath.stroke()
        
//        let middleXCoordinate = abs(firstNumberView.center.x - secondNumberView.center.x)
//        let middleYCoordinate = abs(firstNumberView.center.y - secondNumberView.center.y)
//        let middleOfLine = CGPoint(x: middleXCoordinate, y: middleYCoordinate)
//
//        let firstPartLinePath = UIBezierPath()
//        firstPartLinePath.lineWidth = 4.0
//        UIColor.red.setStroke()
//        firstPartLinePath.move(to: startCoordinate)
//        firstPartLinePath.addLine(to: middleOfLine)
//        firstPartLinePath.stroke()
//
//        let secondPartLinePath = UIBezierPath()
//        secondPartLinePath.lineWidth = 4.0
//        UIColor.blue.setStroke()
//        secondPartLinePath.move(to: middleOfLine)
//        secondPartLinePath.addLine(to: endCoordinate)
//        secondPartLinePath.stroke()
    }

}
