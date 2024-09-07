import UIKit

protocol GameSelectionDelegate: AnyObject {
    func didSelectGame(index: Int)
}

final class FullScreenAppViewController: UIViewController {
    
    private var ticTacToeVC: TicTacToeViewController?
    private var wordleVC: WordleViewController?
    private var intuitionVC: IntuitionViewController?
    private var weatherVC: WeatherViewController?
    private var cryptoVC: CryptoController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupNavigationBar()
        displaySelectedApp(index: 4)
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let gameButton = UIBarButtonItem(title: "Сменить", style: .done, target: self, action: #selector(showGameSelection(_:)))
        navigationItem.rightBarButtonItem = gameButton
        gameButton.tintColor = .black
    }
    
    @objc func showGameSelection(_ sender: UIBarButtonItem) {
        let gameSelectionVC = GameSelectionViewController()
        gameSelectionVC.modalPresentationStyle = .popover
        gameSelectionVC.delegate = self
        
        if let popoverController = gameSelectionVC.popoverPresentationController {
            popoverController.barButtonItem = sender
            popoverController.permittedArrowDirections = .up
            popoverController.delegate = self
            gameSelectionVC.preferredContentSize = CGSize(width: 200, height: 250)
        }
        
        present(gameSelectionVC, animated: true, completion: nil)
    }
    
    
    func displaySelectedApp(index: Int) {
        removeChildViewControllers()
        
        if index == 0 {
            ticTacToeVC = TicTacToeViewController()
            guard let ticTacToeVC = ticTacToeVC else { return }
            addChild(ticTacToeVC)
            ticTacToeVC.view.frame = view.bounds
            view.addSubview(ticTacToeVC.view)
            ticTacToeVC.didMove(toParent: self)
            navigationItem.title = "TicTacToe"
        } else if index == 1 {
            wordleVC = WordleViewController()
            guard let wordleVC = wordleVC else { return }
            addChild(wordleVC)
            wordleVC.view.frame = view.bounds
            view.addSubview(wordleVC.view)
            wordleVC.didMove(toParent: self)
            navigationItem.title = "Wordle"
        } else if index == 2 {
            intuitionVC = IntuitionViewController()
            guard let intuitionVC = intuitionVC else { return }
            addChild(intuitionVC)
            intuitionVC.view.frame = view.bounds
            view.addSubview(intuitionVC.view)
            intuitionVC.didMove(toParent: self)
            navigationItem.title = "Intuition"
        } else if index == 3 {
            weatherVC = WeatherViewController()
            guard let weatherVC = weatherVC else { return }
            addChild(weatherVC)
            weatherVC.view.frame = view.bounds
            view.addSubview(weatherVC.view)
            weatherVC.didMove(toParent: self)
            navigationItem.title = "Weather"
        } else if index == 4 {
            cryptoVC = CryptoController()
            guard let cryptoVC = cryptoVC else { return }
            addChild(cryptoVC)
            cryptoVC.view.frame = view.bounds
            view.addSubview(cryptoVC.view)
            cryptoVC.didMove(toParent: self)
            navigationItem.title = "Crypto"
        }
    }
    
    private func removeChildViewControllers() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}

extension FullScreenAppViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension FullScreenAppViewController: GameSelectionDelegate {
    func didSelectGame(index: Int) {
        displaySelectedApp(index: index)
    }
}


