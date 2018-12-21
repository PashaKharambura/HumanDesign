//
//  BodyGraphNumericSymbolBar.swift
//  HumanDesign
//
//  Created by Dmytro Pasinchuk on 12/20/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class BodyGraphNumericSymbolBar: UIView {

    @IBOutlet var contentView: UIView!
    
    enum BarPosition {
        case left, right
    }
    
    var barPosition: BarPosition = .left {
        didSet {
            changeSymbolsColor(toLeftPositionColor: barPosition == .left)
        }
    }
    
    @IBInspectable var barIsInLeftPosition: Bool = true {
        didSet {
            changeSymbolsColor(toLeftPositionColor: barIsInLeftPosition)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXIB()
        initialPreparations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadFromXIB()
        initialPreparations()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadFromXIB()
        contentView.prepareForInterfaceBuilder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadFromXIB()
    }
    
    private func loadFromXIB() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("BodyGraphNumericSymbolBar", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(contentView)
    }
    
    private func initialPreparations() {
        contentView.layer.cornerRadius = 2
    }
    
    private func changeSymbolsColor(toLeftPositionColor: Bool) {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
