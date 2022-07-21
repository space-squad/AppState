//
//  BaseStackView.swift
//  
//
//  Created by Kevin Waltz on 28.06.22.
//

import UIKit

class BaseStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0, axis: NSLayoutConstraint.Axis, distribution: Distribution = .fillEqually) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach { addArrangedSubview($0) }
        
        self.spacing = spacing
        
        self.axis = axis
        self.distribution = distribution
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
