import UIKit

class TabBarController: UITabBarController {

    private lazy var listenNowViewController = makeListenNowViewController()
    private lazy var browseViewController = makeBrowseViewController()
    private lazy var radioViewController = makeRadioViewController()
    private lazy var libraryViewController = makeLibraryViewController()
    private lazy var searchViewController = makeSearchViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [listenNowViewController,
                           browseViewController,
                           radioViewController,
                           libraryViewController,
                           searchViewController]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedIndex = 0
    }

}

private extension TabBarController {

    private func makeListenNowViewController() -> UINavigationController {
        let vc = ListenNowViewController()
        vc.tabBarItem = UITabBarItem(title: "Listen Now",
                                     image: UIImage(systemName: "play.circle.fill"),
                                     tag: 0)
        return UINavigationController(rootViewController: vc)
    }

    private func makeBrowseViewController() -> UINavigationController {
        let vc = BrowseViewController()
        vc.tabBarItem = UITabBarItem(title: "Browse",
                                     image: UIImage(systemName: "square.grid.2x2.fill"),
                                     tag: 1)
        return UINavigationController(rootViewController: vc)
    }

    private func makeRadioViewController() -> UINavigationController {
        let vc = RadioViewController()
        vc.tabBarItem = UITabBarItem(title: "Radio",
                                     image: UIImage(systemName: "dot.radiowaves.left.and.right"),
                                     tag: 2)
        return UINavigationController(rootViewController: vc)
    }

    private func makeLibraryViewController() -> UINavigationController {
        let vc = LibraryViewController()
        vc.tabBarItem = UITabBarItem(title: "Library",
                                     image: UIImage(systemName: "rectangle.stack.fill"),
                                     tag: 3)
        return UINavigationController(rootViewController: vc)
    }

    private func makeSearchViewController() -> UINavigationController {
        let vc = SearchViewController()
        vc.tabBarItem = UITabBarItem(title: "Search",
                                     image: UIImage(systemName: "magnifyingglass"),
                                     tag: 4)
        return UINavigationController(rootViewController: vc)
    }

}
