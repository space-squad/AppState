//
//  File.swift
//  
//
//  Created by Kevin Waltz on 28.06.22.
//

import UIKit

class BaseButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.imageView?.alpha = self.isHighlighted ? 0.2 : 1
            }
        }
    }
    
    
    init(image: UIImage? = nil, tintColor: UIColor, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        
        self.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        
        self.tintColor = tintColor
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
