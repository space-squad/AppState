//
//  CollectionViewControllerNew.swift
//  AppStateExample
//
//  Created by Kevin Waltz on 28.06.22.
//

import UIKit
import AppState

class CollectionViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupDataSource()
        applySnapshot()
    }
    
    
    
    // MARK: - Elements
    
    lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<SectionItem, SectionItem>?
    
    
    
    // MARK: - Functions
    
    private func notificationHidden() {
        FileManager.shared.fetchExamples()
        applySnapshot()
    }
    
}



// MARK: - CollectionView

fileprivate extension CollectionViewController {
    func setupCollectionView() {
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    func setupLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 18
            section.contentInsets.trailing = 18
            section.interGroupSpacing = 18
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}



// MARK: - DataSource

fileprivate extension CollectionViewController {
    func setupDataSource() {
        let appStateCell = UICollectionView.CellRegistration<AppStateCollectionViewCell, SectionItem> { _, _, _ in }
        
        dataSource = UICollectionViewDiffableDataSource<SectionItem, SectionItem>(collectionView: collectionView) { collectionView, index, item -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: appStateCell, for: index, item: item)
            cell.appStatus = item.appStatus
            cell.notificationHidden = self.notificationHidden
            return cell
        }
    }
}



// MARK: - Snapshot

fileprivate extension CollectionViewController {
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionItem, SectionItem>()
        createAppStateSections(in: &snapshot)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func createAppStateSections(in snapshot: inout NSDiffableDataSourceSnapshot<SectionItem, SectionItem>) {
        let items = FileManager.shared.examples.map { SectionItem(appStatus: $0) }
        let section = SectionItem(items: items)
        
        createAdditionalSection(for: section, in: &snapshot)
    }
    
    func createAdditionalSection(for section: SectionItem, in snapshot: inout NSDiffableDataSourceSnapshot<SectionItem, SectionItem>) {
        snapshot.appendSections([section])
        snapshot.appendItems(section.items ?? [], toSection: section)
    }
}
