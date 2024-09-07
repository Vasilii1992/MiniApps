//
//  InteractiveAppListViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 05.09.2024.
//

import UIKit

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
        
        if miniAppControllers[indexPath.row] == nil {
            miniAppControllers[indexPath.row] = miniApp.viewControllerFactory()
        }
        
        if let miniAppVC = miniAppControllers[indexPath.row] {
            cell.configure(with: miniAppVC, parentViewController: self)
        }
        
        return cell
    }
}

extension InteractiveAppListViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 2)
    }
    
}
