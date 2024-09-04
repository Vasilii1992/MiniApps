//
//  InteractiveAppListViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 05.09.2024.
//

import UIKit
class InteractiveAppListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    private let appNames = ["TicTacToe", "Wordle"]
    
    private let numberOfCells = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
       
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InteractiveAppCell.identifier, for: indexPath) as! InteractiveAppCell
        
        let appName = appNames[indexPath.row % appNames.count]
        cell.configure(with: appName)
        
        cell.actionButton.tag = indexPath.row
        cell.actionButton.addTarget(self, action: #selector(openFullScreen(_:)), for: .touchUpInside)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 2.6)
    }

    @objc func openFullScreen(_ sender: UIButton) {
        let appName = appNames[sender.tag % appNames.count]
        
        if appName == "TicTacToe" {
            let ticTacToeVC = TicTacToeViewController()
            navigationController?.pushViewController(ticTacToeVC, animated: true)
        } else if appName == "Wordle" {
            let wordleVC = WordleViewController()
            navigationController?.pushViewController(wordleVC, animated: true)
        }
    }
}
