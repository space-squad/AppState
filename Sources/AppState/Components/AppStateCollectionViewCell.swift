//
//  AppStateCollectionViewCell.swift
//  
//
//  Created by Kevin Waltz on 27.06.22.
//

import UIKit

public class AppStateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 12
        clipsToBounds = true
        
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    // MARK: - Variables
    
    public var notificationHidden: (() -> Void)?
    
    public var appStatus: AppStatus? {
        didSet {
            guard let appStatus = appStatus else { return }
            
            icon.image = UIImage(systemName: AppStatusIcon(rawValue: appStatus.type.icon)?.title ?? "")
            icon.tintColor = UIColor(hexString: appStatus.type.color).withAlphaComponent(0.2)
            
            headerLabel.text = appStatus.notification.header
            messageLabel.text = appStatus.notification.message
            
            dismissButton.isHidden = !appStatus.type.isDismissable
            
            layer.borderColor = UIColor(hexString: appStatus.type.color).cgColor
            layer.borderWidth = 2
        }
    }
    
    
    
    // MARK: - Elements
    
    private let icon = BaseImageView()
    
    private let headerLabel = BaseLabel(font: .systemFont(ofSize: 16, weight: .semibold), textToFitWidth: true)
    private let messageLabel = BaseLabel(font: .systemFont(ofSize: 16), numberOfLines: 0)
    private let dismissButton = BaseButton(image: UIImage(systemName: "xmark.circle.fill"), tintColor: .lightGray)
    
    private lazy var headerStackView = BaseStackView(arrangedSubviews: [headerLabel], axis: .horizontal, distribution: .fill)
    private lazy var contentStackView = BaseStackView(arrangedSubviews: [headerStackView, messageLabel], spacing: 6, axis: .vertical, distribution: .fill)
    
    
    private func setupElements() {
        addSubview(icon)
        addSubview(contentStackView)
        addSubview(dismissButton)
        
        
        icon.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 8, paddingRight: -36, width: 44, height: 44)
        contentStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: -12, paddingRight: -12)
        
        
        dismissButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 12, paddingRight: -12, width: 24, height: 24)
        dismissButton.addTarget(self, action: #selector(hideNotification(_:)), for: .touchUpInside)
        
        
        // This is needed so the button to dismiss the notification is tappable
        sendSubviewToBack(contentView)
    }
    
    
    
    // MARK: - Functions
    
    @objc
    private func hideNotification(_ sender: UIButton) {
        guard let appStatus = appStatus else { return }
        AppStateManager.shared.hideNotification(with: appStatus.notificationId)
        
        if let notificationHidden = notificationHidden {
            notificationHidden()
        }
    }
    
}
