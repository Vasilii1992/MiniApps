
import UIKit
import TicTacToe
import WordleGame

final class InteractiveAppListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InteractiveAppCell.self, forCellWithReuseIdentifier: InteractiveAppCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    private let miniApps: [MiniAppForInteractive] = [
        MiniAppForInteractive(name: "Intuition", viewControllerFactory: { IntuitionViewController() }),
        MiniAppForInteractive(name: "Crypto", viewControllerFactory: { CryptoController() }),
        MiniAppForInteractive(name: "Weather", viewControllerFactory: { WeatherViewController()}),
        MiniAppForInteractive(name: "Wordle", viewControllerFactory: { WordleViewController() }),
        MiniAppForInteractive(name: "TicTacToe", viewControllerFactory: { TicTacToeViewController() }),
    ]
    private var miniAppControllers: [UIViewController?] = Array(repeating: nil, count: 10)
    
    private let numberOfCells = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupViews() {
        title = "Интерактивная лента"
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension InteractiveAppListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InteractiveAppCell.identifier, for: indexPath) as! InteractiveAppCell
        
        let miniApp = miniApps[indexPath.row % miniApps.count]
        
        if let miniAppVC = miniAppControllers[indexPath.row] {
            if !cell.appContainerView.subviews.contains(miniAppVC.view) {
                cell.configure(with: miniAppVC, appName: miniApp.name, parentViewController: self)
            }
        } else {
            miniAppControllers[indexPath.row] = miniApp.viewControllerFactory()
            
            if let newMiniAppVC = miniAppControllers[indexPath.row] {
                cell.configure(with: newMiniAppVC, appName: miniApp.name, parentViewController: self)
            }
        }
        
        return cell
    }

}

extension InteractiveAppListViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        if isPad {
            
            let columns: CGFloat = 2
            let width = (collectionView.bounds.width - 10 * (columns - 1)) / columns
            let height = collectionView.bounds.height / 2
            return CGSize(width: width, height: height)
        } else {
            
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height / 2
            return CGSize(width: width, height: height)
        }
    }
}
