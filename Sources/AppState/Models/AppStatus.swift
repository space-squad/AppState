//
//  AppStatus.swift
//  
//
//  Created by Kevin Waltz on 21.05.22.
//

import Foundation

public struct AppStatus: Codable {
    public let notificationId: String
    public let preferredLocalization: String
    public let type: StatusType
    public let notification: Notification
    
    public let startDate, endDate: String?
}

public struct StatusType: Codable {
    public let title, color, icon: String
    public let isDismissable: Bool
}

public struct Notification: Codable {
    public let language, header, message: String
}
