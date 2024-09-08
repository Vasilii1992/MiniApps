
import UIKit
import TicTacToe
import WordleGame

final class MiniAppListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MiniAppCell.self, forCellWithReuseIdentifier: MiniAppCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let appNames: [MiniApps] = [
        .init(name: "Crypto", image: "crypto", description: "Основные криптовалюты"),
        .init(name: "Weather", image: "weather", description: "Узнай погоду в любом городе"),
        .init(name: "TicTacToe", image: "ticTacToe", description: "Классическая игра в крестики-нолики"),
        .init(name: "Wordle", image: "wordle", description: "Игра, где нужно угадать слово"),
        .init(name: "Intuition", image: "intuition", description: "Попробуй отгадай дверь")
    ]
    
    private let numberOfCells = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Список приложений"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupViews() {
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
    
    static func createBackBarButtonItem(target: Any?, action: Selector) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain,
                                            target: target,
                                            action: action)
        barButtonItem.tintColor = .black
        return barButtonItem
    }
}
    
extension MiniAppListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniAppCell.identifier, for: indexPath) as! MiniAppCell
        
        let appName = appNames[indexPath.row % appNames.count]
        cell.configure(with: appName.name, image: appName.image, description: appName.description)
        
        return cell
    }
}

extension MiniAppListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appName = appNames[indexPath.row % appNames.count]
        if appName.name == "TicTacToe" {
            let ticTacToeVC = TicTacToeViewController()
            navigationController?.pushViewController(ticTacToeVC, animated: true)
        } else if appName.name == "Wordle" {
            let wordleVC = WordleViewController()
            navigationController?.pushViewController(wordleVC, animated: true)
        } else if appName.name == "Intuition" {
            let intuitionVC = IntuitionViewController()
            navigationController?.pushViewController(intuitionVC, animated: true)
        } else if appName.name == "Weather" {
            let weatherVC = WeatherViewController()
            navigationController?.pushViewController(weatherVC, animated: true)

        } else if appName.name == "Crypto" {
            let cryptoVC = CryptoController()
            navigationController?.pushViewController(cryptoVC, animated: true)

        }
    }    
}

extension MiniAppListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        if isPad {
            let columns: CGFloat = UIDevice.current.orientation.isLandscape ? 3 : 2
            let width = (collectionView.bounds.width - (columns - 1) * 10) / columns
            let height = view.frame.size.height / 8
            return CGSize(width: width, height: height)
        } else {
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height / 8
            return CGSize(width: width, height: height)
        }
    }
}

