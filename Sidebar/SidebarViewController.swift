import UIKit

class SidebarViewController: UIViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    private var collectionView: UICollectionView! = nil
    private var secondaryViewControllers = [UINavigationController(rootViewController: ListenNowViewController()),
                                            UINavigationController(rootViewController: BrowseViewController()),
                                            UINavigationController(rootViewController: RadioViewController()),
                                            UINavigationController(rootViewController: SearchViewController())]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureHierarchy()
        configureDataSource()
        addNavigationButtons()
        setInitialSecondaryView()
    }

    private func setInitialSecondaryView() {
        collectionView.selectItem(at: IndexPath(row: 0, section: 0),
                                  animated: false,
                                  scrollPosition: UICollectionView.ScrollPosition.centeredVertically)
        splitViewController?.setViewController(secondaryViewControllers[0], for: .secondary)
    }

    private func addNavigationButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)
    }
}

// MARK: - Layout

extension SidebarViewController {

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
            config.headerMode = section == 0 ? .none : .firstItemInSection
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }

}

// MARK: - Data

extension SidebarViewController {

    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        // Configuring cells

        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            cell.accessories = [.outlineDisclosure()]
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.image = item.image
            cell.contentConfiguration = content
            cell.accessories = []
        }

        // Creating the datasource

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            if indexPath.item == 0 && indexPath.section != 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }

        // Creating and applying snapshots

        let sections: [Section] = [.tabs, .library, .playlists]
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)

        for section in sections {
            switch section {
            case .tabs:
                var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
                sectionSnapshot.append(tabsItems)
                dataSource.apply(sectionSnapshot, to: section)
            case .library:
                let headerItem = Item(title: section.rawValue, image: nil)
                var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
                sectionSnapshot.append([headerItem])
                sectionSnapshot.append(libraryItems, to: headerItem)
                sectionSnapshot.expand([headerItem])
                dataSource.apply(sectionSnapshot, to: section)
            case .playlists:
                let headerItem = Item(title: section.rawValue, image: nil)
                var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
                sectionSnapshot.append([headerItem])
                sectionSnapshot.append(playlistItems, to: headerItem)
                sectionSnapshot.expand([headerItem])
                dataSource.apply(sectionSnapshot, to: section)
            }
        }
    }

}

// MARK: - UICollectionViewDelegate

extension SidebarViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        splitViewController?.setViewController(secondaryViewControllers[indexPath.row], for: .secondary)
    }

}

// MARK: - Structs and sample data

struct Item: Hashable {
    let title: String?
    let image: UIImage?
    private let identifier = UUID()
}

let tabsItems = [Item(title: "Listen Now", image: UIImage(systemName: "play.circle")),
                 Item(title: "Browse", image: UIImage(systemName: "square.grid.2x2")),
                 Item(title: "Radio", image: UIImage(systemName: "dot.radiowaves.left.and.right")),
                 Item(title: "Search", image: UIImage(systemName: "magnifyingglass"))]

let libraryItems = [Item(title: "Recently Added", image: UIImage(systemName: "clock")),
                    Item(title: "Artists", image: UIImage(systemName: "music.mic")),
                    Item(title: "Albums", image: UIImage(systemName: "rectangle.stack")),
                    Item(title: "Songs", image: UIImage(systemName: "music.note")),
                    Item(title: "Music Videos", image: UIImage(systemName: "tv.music.note")),
                    Item(title: "TV & Movies", image: UIImage(systemName: "tv"))]

let playlistItems = [Item(title: "All Playlists", image: UIImage(systemName: "music.note.list")),
                     Item(title: "Replay 2015", image: UIImage(systemName: "music.note.list")),
                     Item(title: "Replay 2016", image: UIImage(systemName: "music.note.list")),
                     Item(title: "Replay 2017", image: UIImage(systemName: "music.note.list")),
                     Item(title: "Replay 2018", image: UIImage(systemName: "music.note.list")),
                     Item(title: "Replay 2019", image: UIImage(systemName: "music.note.list")),]

enum Section: String {
    case tabs
    case library = "Library"
    case playlists = "Playlists"
}
