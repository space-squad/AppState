//
//  SectionItem.swift
//  AppStateExample
//
//  Created by Kevin Waltz on 28.06.22.
//

import Foundation
import AppState

class SectionItem: Hashable {
    var id = UUID()
    
    var title: String?
    var items: [SectionItem]?
    var appStatus: AppStatus?
    
    
    init(title: String? = nil, items: [SectionItem]? = nil, appStatus: AppStatus? = nil) {
        self.title = title
        self.items = items
        self.appStatus = appStatus
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        lhs.id == rhs.id
    }
}
