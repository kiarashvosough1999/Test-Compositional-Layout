//
//  ViewController++DataSource.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import class UIKit.UICollectionReusableView
import class UIKit.UICollectionViewDiffableDataSource
import class UIKit.UICollectionView
import struct Foundation.IndexPath

extension ViewController {
    
    func generateDataSource(for collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Item> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .myAlbum, .triplet, .lowHeight:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ImageCell.reuseIdentifier,
                    for: indexPath
                ) as? ImageCell else { fatalError("Could not create new cell") }
                cell.featuredPhotoURL = item.imageURL
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath
            ) as? HeaderView else { fatalError("Cannot create header view") }
            supplementaryView.text = Section.allCases[indexPath.section].rawValue.capitalized
            return supplementaryView
        }
        
        return dataSource
    }
}
