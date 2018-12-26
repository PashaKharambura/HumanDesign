//
//  HumanDesingTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

protocol BodyGraphProtocol {
    func getImage(image: UIImage)
}

class HumanDesingTableViewCell: UITableViewCell {
    @IBOutlet weak var designTitleView: UIView! {didSet{designTitleView.layer.cornerRadius = 4 }}
    @IBOutlet weak var personalityTitleView: UIView! {didSet{personalityTitleView.layer.cornerRadius = 4 }}
    @IBOutlet weak var designTltleLabel: UILabel!
    @IBOutlet weak var personalityTitleLabel: UILabel!
    
    @IBOutlet weak var firstFigure: UIImageView!  {didSet{firstFigure.setImageColor(color: .white)}}
    @IBOutlet weak var figureSecond: UIImageView!  {didSet{figureSecond.setImageColor(color: .white)}}
    @IBOutlet weak var figureThird: UIImageView!  {didSet{figureThird.setImageColor(color: .white)}}
    @IBOutlet weak var figureFourth: UIImageView!  {didSet{figureFourth.setImageColor(color: .white)}}
    @IBOutlet weak var figureFifth: UIImageView!  {didSet{figureFifth.setImageColor(color: .white)}}
    @IBOutlet weak var figureSix: UIImageView!  {didSet{figureSix.setImageColor(color: .white)}}
    @IBOutlet weak var figureSeventh: UIImageView!  {didSet{figureSeventh.setImageColor(color: .white)}}
    @IBOutlet weak var figureEight: UIImageView!  {didSet{figureEight.setImageColor(color: .white)}}
    @IBOutlet weak var figureNinth: UIImageView! {didSet{figureNinth.setImageColor(color: .white)}}
    
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
    
    var figures: [GraphFigure] = []
    var delegate: BodyGraphProtocol?
    
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
    
    var superActiveNumbers: [Int] = [] {
        didSet {
            setFiguresObjects()
            setViewsColor()
            delegate?.getImage(image: self.asImage())
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
    
    private func setFiguresObjects() {
        let first = GraphFigure(image: firstFigure, numbers: [64,63,61])
        let second = GraphFigure(image: figureSecond, numbers: [47,24,4,17,11,43])
        let third = GraphFigure(image: figureThird, numbers: [62,23,56,35,12,45,33,8,31,20,16])
        let forth = GraphFigure(image: figureFourth, numbers: [1,13,25,46,2,15,10,7])
        let fifth = GraphFigure(image: figureFifth, numbers: [21,51,26,40])
        let sixth = GraphFigure(image: figureSix, numbers: [5,14,29,34,27,42,3,9,59])
        let seventh = GraphFigure(image: figureSeventh, numbers: [48,57,44,50,32,28,18])
        let eitht = GraphFigure(image: figureEight, numbers: [36,22,37,6,49,55,30])
        let ninth = GraphFigure(image: figureNinth, numbers: [58,38,54,53,60,52,19,39,41])
        figures = [first,second,third,forth,fifth,sixth,seventh,eitht,ninth]
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
    
    private func setViewsColor() {
        let array = superActiveNumbers
        for figure in figures {
            for number in figure.numbers {
                if array.contains(number) {
                    redrawFigure(figure: figure)
                }
            }
        }
    }
    
    private func redrawFigure(figure: GraphFigure) {
        switch figure.image {
        case firstFigure,figureFourth:
            figure.image.setImageColor(color: .yellowFigure)
        case figureSecond:
            figure.image.setImageColor(color: .greenFigure)
        case figureThird,figureSeventh,figureEight,figureNinth:
            figure.image.setImageColor(color: .brownFigure)
        case figureFifth,figureSix:
            figure.image.setImageColor(color: .redFigure)
        default:
            figure.image.setImageColor(color: .white)
        }
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


