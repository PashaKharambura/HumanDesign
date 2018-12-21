//
//  BodyGraphNumberView.swift
//  HumanDesign
//
//  Created by Dmytro Pasinchuk on 12/20/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

@IBDesignable class BodyGraphNumberView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBInspectable var labelsNumber: Int = 0 {
        didSet {
            numberLabel.text = String(labelsNumber)
        }
    }
    
    var labelsNumberText: String = "" {
        didSet {
            numberLabel.text = labelsNumberText
        }
    }
    
    var numberIsActive: Bool = false {
        didSet {
            contentView.backgroundColor = numberIsActive ? .black : .white
            numberLabel.textColor = numberIsActive ? .white : .black
        }
    }
    
    var activeLineColor: ActiveBodyGraphNumber.NumberColor = .blue
    
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
        contentView.prepareForInterfaceBuilder()
        loadFromXIB()
        initialPreparations()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadFromXIB()
        initialPreparations()
    }
    
    private func loadFromXIB() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("BodyGraphNumberView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(contentView)
    }
    
    private func initialPreparations() {
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        contentView.backgroundColor = .white
        self.backgroundColor = .clear
        self.numberLabel.text = String(labelsNumber)
    }
}
