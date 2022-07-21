//
//  File.swift
//  
//
//  Created by Kevin Waltz on 28.06.22.
//

import Foundation
import Combine
import AppState

public class FileManager: ObservableObject {

    static var shared = FileManager()
    
    
    
    // MARK: - Variables
    
    @Published var examples = [AppStatus]()
    
    
    
    // MARK: - Functions
    
    func fetchExamples() {
        fetchJSONData(file: "Examples") { (result: Result<[AppStatus], Error>) in
            switch result {
            case .success(let examples):
                let filteredExamples = examples.filter {
                    !AppStateManager.shared.isHidden(with: $0.notificationId) &&
                    AppStateManager.shared.isInTimeframe(from: $0.startDate, to: $0.endDate)
                }
                
                self.examples = filteredExamples
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchJSONData<T>(file: String, completion: @escaping (Result<[T], Error>) -> Void) where T: Decodable {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            completion(.success([]))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([T].self, from: data)
            
            completion(.success(jsonData))
        } catch {
            completion(.failure(error))
            print("error:\(error)")
        }
    }
}
