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
    
//    case 1000:
//      Theme.sampleHeaderLabel(self)
    
    func loadStyle() {
        switch(self.labelType) {
        case 1000:
            Theme.sampleHeaderLabel(self)
        case 2000:
            Theme.customFontForLabel(self, font: Theme.font(.Regular), color: Theme.lightGrayColor(), size: Theme.size(.big))
        case 3000:
            Theme.customFontForLabel(self, font: Theme.font(.Regular), color: Theme.lightGrayColor(), size: Theme.size(.big))
        case 4000:
            Theme.customFontForLabel(self, font: Theme.font(.Regular), color: Theme.lightGrayColor(), size: Theme.size(.big))
        default:
            break;
        }
    }
}
