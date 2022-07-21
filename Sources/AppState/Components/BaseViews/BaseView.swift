//
//  BaseView.swift
//  
//
//  Created by Kevin Waltz on 28.06.22.
//

import UIKit

class BaseView: UIView {
    
    init(backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
