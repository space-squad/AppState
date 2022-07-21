//
//  AppStateManager.swift
//  Preppy
//
//  Created by Kevin Waltz on 21.05.22.
//  Copyright © 2022 Kevin Waltz. All rights reserved.
//

import Foundation
import Combine

public class AppStateManager: ObservableObject {
    
    public static let shared = AppStateManager()
    
    
    
    // MARK: - Variables
    
    public var states = CurrentValueSubject<[AppStatus], Never>([])
    
    private let host = "https://us-central1-appstate-dev-io.cloudfunctions.net/notifications/"
    private var cancellable: AnyCancellable?
    
    private let userDefaultsKey = "appStateHiddenNotifications"
    
    private var appID = ""
    
    
    
    // MARK: - Functions
    
    
    /**
     Set the ID for for your app.
     Based on this ID, all notifications will be fetched.
     
     - Parameter appId: The ID of your app
     */
    public func setAppID(_ appID: String) {
        self.appID = appID
        self.checkNotifications()
    }
    
    /**
     Fetch available notifications for your app.
     */
    public func checkNotifications() {
        guard !appID.isEmpty, let locale = Locale.current.languageCode, let url = URL(string: host + appID + "/\(locale)") else {
            print("-----> Notifications could not be fetched!")
            return
        }
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                
                return output.data
            }
            .decode(type: [AppStatus].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print(error.localizedDescription)
                }
            }, receiveValue: { [unowned self] appStates in
                let filteredStates = appStates.filter {
                    !isHidden(with: $0.notificationId) &&
                    isInTimeframe(from: $0.startDate, to: $0.endDate)
                }
                
                self.states.send(filteredStates)
                self.cancellable?.cancel()
            })
    }
    
    
    
    /**
     Check whether today's date lies between a notification's start and end date.
     
     - Returns bool: Today's date is within given time frame
     */
    public func isInTimeframe(from startDate: String?, to endDate: String?) -> Bool {
        guard let startDate = startDate?.setFormat(), let endDate = endDate?.setFormat() else {
            return true
        }
        
        return (min(startDate, endDate) ... max(startDate, endDate)).contains(Calendar.current.startOfDay(for: Date()))
    }
    
    /**
     Check whether a specific notification was hidden by user.
     
     - Returns bool: Was notification hidden or not
     */
    public func isHidden(with id: String) -> Bool {
        if let hiddenNotifications = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            return hiddenNotifications.contains(where: { $0 == id })
        }
        
        return false
    }
    
    /**
     Hide a notification with a specified it.
     
     Hidden IDs are saved to UserDefaults.
     */
    public func hideNotification(with id: String) {
        if let hiddenNotifications = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            var hiddenNotifications = hiddenNotifications
            hiddenNotifications.append(id)
            
            UserDefaults.standard.set(hiddenNotifications, forKey: userDefaultsKey)
        } else {
            let hiddenNotifications = [id]
            UserDefaults.standard.set(hiddenNotifications, forKey: userDefaultsKey)
        }
        
        checkNotifications()
    }
    
    /**
     Show all previously hidden notifications again.
     */
    public func restoreHiddenNotifications() {
        UserDefaults.standard.set(nil, forKey: userDefaultsKey)
    }
    
}
