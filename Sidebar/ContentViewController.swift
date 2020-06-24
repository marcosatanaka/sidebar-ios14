import UIKit

class ContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Albums"
        navigationController?.navigationBar.prefersLargeTitles = true
        addNavigationButtons()
    }

    private func addNavigationButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: nil)
    }

}
