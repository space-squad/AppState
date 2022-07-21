//
//  TableViewController.swift
//  AppStateExample
//
//  Created by Kevin Waltz on 27.06.22.
//

import UIKit
import AppState

class TableViewController: UITableViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    
    
    // MARK: - Functions
    
    private func notificationHidden() {
        FileManager.shared.fetchExamples()
        tableView.reloadData()
    }
    
}


// MARK: - TableView

extension TableViewController {
    fileprivate func setupTableView() {
        tableView.register(AppStateTableViewCell.self, forCellReuseIdentifier: AppStateTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FileManager.shared.examples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppStateTableViewCell.identifier, for: indexPath) as? AppStateTableViewCell else { return UITableViewCell() }
        cell.appStatus = FileManager.shared.examples[indexPath.item]
        cell.notificationHidden = notificationHidden
        return cell
    }
}
