//
//  MiniAppListViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 04.09.2024.
//

import UIKit

class MiniAppListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        .init(name: "TicTacToe", image: "TicTacToe", description: "Классическая игра в кресики нолики"),
        .init(name: "Wordle", image: "wordle", description: "Игра, где нужно угадать слово")
    ]
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniAppCell.identifier, for: indexPath) as! MiniAppCell
        
 
        let appName = appNames[indexPath.row % appNames.count]
        cell.configure(with: appName.name, image: appName.image, description: appName.description)
        
        return cell
    }

   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 8)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let appName = appNames[indexPath.row % appNames.count]
   
        if appName.name == "TicTacToe" {
            let ticTacToeVC = TicTacToeViewController()
            navigationController?.pushViewController(ticTacToeVC, animated: true)
        } else if appName.name == "Wordle" {
            let wordleVC = WordleViewController()
            navigationController?.pushViewController(wordleVC, animated: true)
        }
    }
}
