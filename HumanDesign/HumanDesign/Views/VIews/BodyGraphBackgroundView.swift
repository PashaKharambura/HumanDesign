//
//  BodyGraphBackgroundView.swift
//  HumanDesign
//
//  Created by Dmytro Pasinchuk on 12/21/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

class BodyGraphBackgroundView: UIView {
    
    var numberViews: [BodyGraphNumberView] = []
    var connectedByLinesGraphNumbers: [Int:Int] = [:]
    
    var drawLineFromSpecificPlace: [Int] = []

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        guard !numberViews.isEmpty, !connectedByLinesGraphNumbers.isEmpty else { return }
        drawGraphLines()
    }
    
    func drawGraphLines() {
        drawSpecificLines()
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
        let startCoordinate = getCoordinateOfCenter(of: firstNumberView)
        let endCoordinate = getCoordinateOfCenter(of: secondNumberView)
        
        let middleXCoordinate = getMiddlePoint(from: startCoordinate.x, to: endCoordinate.x)
        let middleYCoordinate = getMiddlePoint(from: startCoordinate.y, to: endCoordinate.y)
        let middleOfLine = CGPoint(x: middleXCoordinate, y: middleYCoordinate)
        
        drawLine(from: startCoordinate, to: middleOfLine, with: firstNumberView.activeLineColor.lineColor)
        drawLine(from: middleOfLine, to: endCoordinate, with: secondNumberView.activeLineColor.lineColor)
        
    }
    
    private func getCoordinateOfCenter(of numberView: BodyGraphNumberView) -> CGPoint {
        return numberView.superview?.convert(numberView.center, to: self) ?? numberView.center
    }
    
    private func getMiddlePoint(from firstPoint: CGFloat, to secondPoint: CGFloat) -> CGFloat {
        return (max(firstPoint, secondPoint) - (abs(firstPoint - secondPoint)/2))
    }
    
    private func getPoint(from firstPoint: CGFloat, to secondPoint: CGFloat, onPercentDistantFromSecondPoint percentDistant: CGFloat) -> CGFloat {
        guard percentDistant <= 1 && percentDistant > 0 else { return 0 }
        return (max(firstPoint, secondPoint) - (abs(firstPoint - secondPoint) * percentDistant))
    }
    
    private func getPoint(from firstPoint: CGPoint, to secondPoint: CGPoint, onPercentDistantFromSecondPoint percentDistant: CGFloat) -> CGPoint {
        guard percentDistant <= 1 && percentDistant > 0 else { return CGPoint.zero }
        return CGPoint(x: getPoint(from: firstPoint.x, to: secondPoint.x, onPercentDistantFromSecondPoint: percentDistant), y: getPoint(from: firstPoint.y, to: secondPoint.y, onPercentDistantFromSecondPoint: (1 - percentDistant)))
    }
    
    private func drawLine(from firstPoint: CGPoint, to secondPoint: CGPoint, with color: UIColor) {
        let linePath = UIBezierPath()
        linePath.lineWidth = 6.0
        color.setStroke()
        linePath.move(to: firstPoint)
        linePath.addLine(to: secondPoint)
        linePath.stroke()
    }
    
    private func drawSpecificLines() {
        guard let (baseLineFirstCoordinate, baseLineSecondCoordinate) = getBaseLineCoordonate() else { return }
        
        drawFirstSpecificLine(from: baseLineFirstCoordinate, to: baseLineSecondCoordinate)
        drawSecondSpecificLine(from: baseLineFirstCoordinate, to: baseLineSecondCoordinate)
        
    }
    
    private func getBaseLineCoordonate() -> (baseLineFirstCoordinate: CGPoint, baseLineSecondCoordinate: CGPoint)? {
        guard let baseLineFirstView = numberViews.first(where: { (numberView) -> Bool in
            numberView.labelsNumber == 57
        }), let baseLineFirstCoordinate = baseLineFirstView.superview?.convert(baseLineFirstView.center, to: self) else { return nil }
        guard let baseLineSecondView = numberViews.first(where: { (numberView) -> Bool in
            numberView.labelsNumber == 20
        }), let baseLineSecondCoordinate = baseLineSecondView.superview?.convert(baseLineSecondView.center, to: self) else { return nil }
        
        return (baseLineFirstCoordinate, baseLineSecondCoordinate)
    }
    
    private func drawFirstSpecificLine(from baseLineFirstCoordinate: CGPoint, to baseLineSecondCoordinate: CGPoint) {
        guard let firstSpecificView = numberViews.first(where: { (numberView) -> Bool in
            numberView.labelsNumber == drawLineFromSpecificPlace.first ?? 0
        }), let firstSpecificViewCoordinate = firstSpecificView.superview?.convert(firstSpecificView.center, to: self) else { return }
        
        let middlePoint = getPoint(from: baseLineFirstCoordinate, to: baseLineSecondCoordinate, onPercentDistantFromSecondPoint: 0.33)
        
        drawLine(from: firstSpecificViewCoordinate, to: middlePoint, with: firstSpecificView.numberIsActive ? firstSpecificView.activeLineColor.lineColor : .white)
    }
    
    private func drawSecondSpecificLine(from baseLineFirstCoordinate: CGPoint, to baseLineSecondCoordinate: CGPoint) {
        guard let secondSpecificView = numberViews.first(where: { (numberView) -> Bool in
            numberView.labelsNumber == drawLineFromSpecificPlace.last ?? 0
        }), let secondSpecificViewCoordinate = secondSpecificView.superview?.convert(secondSpecificView.center, to: self) else { return }
        
        let bottomSpecificPoint = getPoint(from: baseLineFirstCoordinate, to: baseLineSecondCoordinate, onPercentDistantFromSecondPoint: 0.66)
        
        drawLine(from: secondSpecificViewCoordinate, to: bottomSpecificPoint, with: secondSpecificView.numberIsActive ? secondSpecificView.activeLineColor.lineColor : .white)
    }
    
}
