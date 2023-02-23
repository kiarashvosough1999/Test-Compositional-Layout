//
//  LayoutGenerator.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import UIKit

// MARK: - Abstraction

protocol LayoutGeneratorProtocol {
    
    associatedtype SectionType: Sendable, Hashable
    func generateLayout() -> UICollectionViewLayout
}

// MARK: - Impl

struct DefaultLayoutGenerator: LayoutGeneratorProtocol {
    
    typealias SectionType = ViewController.Section
    
    private var configuration: UICollectionViewCompositionalLayoutConfiguration {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        config.interSectionSpacing = 5
        return config
    }
    
    func generateLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let sectionLayoutKind = SectionType.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .myAlbum:
                return generateMyAlbumsLayout()
            case .triplet:
                return generateTripletLayout()
            case .lowHeight:
                return generateLowHeightLayout()
                
            }
        }, configuration: configuration)
    }
    
    private func generateMyAlbumsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .fractionalWidth(2/3)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    private func generateTripletLayout() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)
        )
        let tripletItem = NSCollectionLayoutItem(layoutSize: layoutSize)

        tripletItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2
        )

        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/9)
        )
        let tripletGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: groupLayoutSize,
          subitems: [tripletItem, tripletItem, tripletItem]
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let section = NSCollectionLayoutSection(group: tripletGroup)
        section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 10, bottom: 0, trailing: 10)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    private func generateLowHeightLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/3)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.95),
            heightDimension: .fractionalWidth(2/3)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
}
