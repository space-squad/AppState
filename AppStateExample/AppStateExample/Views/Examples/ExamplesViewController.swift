//
//  ExamplesViewController.swift
//  AppStateExample
//
//  Created by Kevin Waltz on 27.06.22.
//

import UIKit
import SwiftUI
import AppState

class ExamplesViewController: UITableViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupNavigationBar()
        setupTableView()
        
        AppStateManager.shared.restoreHiddenNotifications()
        FileManager.shared.fetchExamples()
    }
    
    
    
    // MARK: - Variables
    
    fileprivate let cellID = "selectionCellID"
    
}


// MARK: - NavigationBar

extension ExamplesViewController {
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Examples"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restore", style: .plain, target: self, action: #selector(restoreHiddenNotifications))
    }
    
    @objc
    fileprivate func restoreHiddenNotifications() {
        AppStateManager.shared.restoreHiddenNotifications()
        FileManager.shared.fetchExamples()
    }
}



// MARK: - UITableView

extension ExamplesViewController {
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Example.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = Example.allCases[indexPath.item].title
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Example(rawValue: indexPath.item) {
        case .swiftui:
            let hostingController = UIHostingController(rootView: SwiftUIView())
            
            navigationController?.pushViewController(hostingController, animated: true)
        case .uitableview:
            let viewController = TableViewController()
            viewController.navigationItem.title = Example.uitableview.title
            
            navigationController?.pushViewController(viewController, animated: true)
        case .uicollectionview:
            let viewController = CollectionViewController()
            viewController.navigationItem.title = Example.uicollectionview.title
            
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
