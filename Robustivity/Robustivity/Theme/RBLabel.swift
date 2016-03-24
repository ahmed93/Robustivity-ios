//
//  RBLabel.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 3/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

@IBDesignable class RBLabel: UILabel {
    
    @IBInspectable var labelType: Int = 0 {
        didSet {
            self.textColor = .redColor()
            loadStyle()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadStyle()
    }
    
    func loadStyle() {
        switch(self.labelType) {
        case 1000:
            Theme.customFontForLabel(self, font: Font.Regular, color: Color.lightBlack, size: Size.big)
        case 2000:
            Theme.customFontForLabel(self, font: Font.Bold, color: Color.green, size: Size.small)
        case 3000:
            Theme.customFontForLabel(self, font: Font.Bold, color: Color.blue, size: Size.big)
        case 4000:
            Theme.customFontForLabel(self, font: Font.Bold, color: Color.blue, size: Size.big)
        default:
            Theme.customFontForLabel(self, font: Font.Bold, color: Color.black, size: Size.small)
        }
    }
}
