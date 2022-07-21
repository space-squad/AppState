//
//  Example.swift
//  AppStateExample
//
//  Created by Kevin Waltz on 28.06.22.
//

import Foundation

enum Example: Int, CaseIterable {
    case swiftui, uitableview, uicollectionview
    
    var title: String {
        switch self {
        case .swiftui: return "SwiftUI"
        case .uitableview: return "UITableView"
        case .uicollectionview: return "UICollectionView"
        }
    }
}
