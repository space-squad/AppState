//
//  AppStateSwiftUIView.swift
//  
//
//  Created by Kevin Waltz on 28.06.22.
//

import SwiftUI

public struct AppStateSwiftUIView: View {
    
    public init(appStatus: AppStatus, notificationHidden: (() -> Void)?) {
        self.appStatus = appStatus
        self.notificationHidden = notificationHidden
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(appStatus.notification.header)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if appStatus.type.isDismissable {
                        Button(action: hideNotification) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 20))
                        }
                    }
                }
                
                Text(appStatus.notification.message)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(12)
            
            Image(systemName: AppStatusIcon(rawValue: appStatus.type.icon)?.title ?? "")
                .foregroundColor(typeColor.opacity(0.2))
                .font(.system(size: 40))
                .padding(.trailing, 36)
                .padding(.bottom, -8)
        }
        .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(typeColor, lineWidth: 2))
        .background(backgroundColor)
        .cornerRadius(12)
    }
    
    
    
    // MARK: - Variables
    
    private let appStatus: AppStatus
    
    public var notificationHidden: (() -> Void)?
    
    
    
    // MARK: - Computed Properties
    
    private var backgroundColor: Color {
        Color(uiColor: UIColor.secondarySystemGroupedBackground)
    }
    
    private var typeColor: Color {
        Color(uiColor: UIColor(hexString: appStatus.type.color))
    }
    
    
    
    // MARK: - Functions
    
    private func hideNotification() {
        AppStateManager.shared.hideNotification(with: appStatus.notificationId)
        
        if let notificationHidden = notificationHidden {
            notificationHidden()
        }
    }
    
}
