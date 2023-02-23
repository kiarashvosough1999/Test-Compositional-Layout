//
//  ViewController.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Views

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layoutGenrator.generateLayout()
        )
        view.backgroundColor = .clear
        view.register(viewClass: HeaderView.self)
        view.register(cellClass: ImageCell.self)
        return view
    }()

    // MARK: - DataSource

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = generateDataSource(for: collectionView)

    // MARK: - Inputs

    private let layoutGenrator: any LayoutGeneratorProtocol

    init(layoutGenrator: any LayoutGeneratorProtocol) {
        self.layoutGenrator = layoutGenrator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    // MARK: - Preparing Views

    private func prepare() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "MyAlbum"
        view.backgroundColor = .white
        prepareCollectionView()
    }

    private func prepareCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        let snapShot = snapshot()
        dataSource.apply(snapShot)
    }

    private func snapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        let url = Bundle.main.url(forResource: "image", withExtension: "jpg")

        let myAlbum = Array(repating: Item.self, count: 5) {
            Item(id: UUID(), imageURL: url!)
        }
        let triplets = Array(repating: Item.self, count: 9) {
            Item(id: UUID(), imageURL: url!)
        }
        
        let lowHeight = Array(repating: Item.self, count: 5) {
            Item(id: UUID(), imageURL: url!)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.myAlbum])
        snapshot.appendItems(myAlbum)
        
        snapshot.appendSections([.triplet])
        snapshot.appendItems(triplets)
        
        snapshot.appendSections([.lowHeight])
        snapshot.appendItems(lowHeight)

        return snapshot
    }

}

// MARK: - Extensions

extension Array where Element: Identifiable {

    fileprivate init(repating: Element.Type, count: Int, builder: () -> Element) {
        self.init(
            stride(from: 0, to: count, by: 1).map { _ in
                builder()
            }
        )
    }
}
