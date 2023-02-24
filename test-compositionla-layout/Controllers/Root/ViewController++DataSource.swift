//
//  ViewController++DataSource.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import class UIKit.UICollectionReusableView
import class UIKit.UICollectionViewDiffableDataSource
import class UIKit.UICollectionView
import class UIKit.UICollectionViewCell
import class UIKit.UIImage
import struct Foundation.IndexPath

extension ViewController {
    
    func generateDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Item> {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Item> { cell, indexPath, item in
            
            var content = cell.defaultBackgroundConfiguration()
            content.cornerRadius = 10
            content.image = UIImage(contentsOfFile: item.imageURL.path)
            cell.backgroundConfiguration = content
        }

        let supplementaryViewRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(elementKind: HeaderView.elementKind) { supplementaryView, elementKind, indexPath in
            supplementaryView.text = Section.allCases[indexPath.section].rawValue.capitalized
        }

        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in

            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .myAlbum, .triplet, .lowHeight:
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        }

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryViewRegistration, for: indexPath)
        }
        
        return dataSource
    }
}
