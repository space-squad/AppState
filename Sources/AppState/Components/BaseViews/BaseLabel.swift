//
//  BaseLabel.swift
//  
//
//  Created by Kevin Waltz on 28.06.22.
//

import UIKit

class BaseLabel: UILabel {
    
    init(text: String? = nil,
         textColor: UIColor? = .label,
         textAlignment: NSTextAlignment = .left,
         font: UIFont,
         numberOfLines: Int = 1,
         textToFitWidth: Bool = false) {
        
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.numberOfLines = numberOfLines
        
        self.adjustsFontSizeToFitWidth = textToFitWidth
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
