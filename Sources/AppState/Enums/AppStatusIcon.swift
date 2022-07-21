//
//  AppStatusIcon.swift
//  
//
//  Created by Kevin Waltz on 23.06.22.
//

import Foundation

public enum AppStatusIcon: String, CaseIterable {
    case xMark, exclamationMark, info, app, questionMark, pencil, plane, doc, arrow, book, power, sparkle
    
    
    public var title: String {
        switch self {
        case .xMark: return "xmark.octagon.fill"
        case .exclamationMark: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        case .app: return "app.badge.fill"
        case .questionMark: return "questionmark.square.fill"
        case .pencil: return "pencil.circle.fill"
        case .plane: return "paperplane.fill"
        case .doc: return "doc.richtext.fill"
        case .arrow: return "arrowshape.turn.up.right.fill"
        case .book: return "book.fill"
        case .power: return "power.circle.fill"
        case .sparkle: return "sparkle"
        }
    }
    
}
