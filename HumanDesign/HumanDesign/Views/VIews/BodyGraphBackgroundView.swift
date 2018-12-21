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
        let startCoordinate = firstNumberView.superview?.convert(firstNumberView.center, to: self) ?? firstNumberView.center
        let endCoordinate = secondNumberView.superview?.convert(secondNumberView.center, to: self) ?? secondNumberView.center
        
        let middleXCoordinate = (max(startCoordinate.x, endCoordinate.x) - (abs(startCoordinate.x - endCoordinate.x)/2))
        let middleYCoordinate = (max(startCoordinate.y, endCoordinate.y) - (abs(startCoordinate.y - endCoordinate.y)/2))
        let middleOfLine = CGPoint(x: middleXCoordinate, y: middleYCoordinate)
        
        if !firstNumberView.numberIsActive && !secondNumberView.numberIsActive {
            drawLine(from: startCoordinate, to: endCoordinate, with: .white)
        } else {
            if firstNumberView.numberIsActive && secondNumberView.numberIsActive {
                drawLine(from: startCoordinate, to: endCoordinate, with: .magenta)
            } else {
                //TODO: draw right color of parts
                if firstNumberView.numberIsActive {
                    drawLine(from: startCoordinate, to: middleOfLine, with: .red)
                    drawLine(from: middleOfLine, to: endCoordinate, with: .white)
                } else {
                    drawLine(from: startCoordinate, to: middleOfLine, with: .white)
                    drawLine(from: middleOfLine, to: endCoordinate, with: .blue)
                }
            }
        }
    }
    
    private func drawLine(from firstPoint: CGPoint, to secondPoint: CGPoint, with color: UIColor) {
        let linePath = UIBezierPath()
        linePath.lineWidth = 6.0
        color.setStroke()
        linePath.move(to: firstPoint)
        linePath.addLine(to: secondPoint)
        linePath.stroke()
    }

}
