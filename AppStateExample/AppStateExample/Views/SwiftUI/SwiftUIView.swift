//
//  SwiftUIView.swift
//  AppStateExample
//
//  Created by Kevin Waltz on 27.06.22.
//

import SwiftUI
import AppState

struct SwiftUIView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(fileManager.examples, id: \.notificationId) { appStatus in
                    AppStateSwiftUIView(appStatus: appStatus, notificationHidden: notificationHidden)
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarTitle("SwiftUI")
    }
    
    
    
    // MARK: - Variables
    
    @ObservedObject var fileManager = FileManager.shared
    
    
    
    // MARK: - Functions
    
    private func notificationHidden() {
        FileManager.shared.fetchExamples()
    }
    
}
