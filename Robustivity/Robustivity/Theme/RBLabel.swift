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
            // MyriadPro-Regular
        case 1000:              // 494949, 28
            Theme.style_1(self)
        case 1010:              // 494949, 24
            Theme.style_2(self)
        case 1020:              // 343434, 24
            Theme.style_3(self)
        case 1030:              // 343434, 28
            Theme.style_4(self)
        case 1040:              // 32C62C, 44
            Theme.style_5(self)
        case 1050:              // C30017, 28
            Theme.style_6(self)
        case 1060:              // FFFFFF, 26
            Theme.style_7(self)
        case 1070:              // 000000, 32
            Theme.style_8(self)
        case 1080:              // 828282, 22
            Theme.style_9(self)
        case 1090:              // 828282, 30
            Theme.style_10(self)
            
            // MyriadPro-boldCond
        case 2000:              // 3A95FF, 32
            Theme.style_11(self)
            
            // MyriadPro-semiBold
        case 3000:              // 494949, 28
            Theme.style_12(self)
        case 3010:              // 494949, 30
            Theme.style_13(self)
        case 3020:              // 494949, 34
            Theme.style_14(self)
        case 3030:              // 32C62C, 24
            Theme.style_15(self)
        case 3040:              // 32C62C, 32
            Theme.style_16(self)
        case 3050:              // 000000, 24
            Theme.style_17(self)
        case 3060:              // 9013FE, 24
            Theme.style_18(self)
        case 3070:              // 494949, 32
            Theme.style_19(self)
        case 3070:              // 3A95FF, 24
            Theme.style_20(self)
        default:
            break;
        }
    }
}
