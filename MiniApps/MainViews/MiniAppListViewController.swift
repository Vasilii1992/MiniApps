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
        .init(name: "Weather", image: "weather", description: "Узнай погоду в любом городе"),
        .init(name: "TicTacToe", image: "TicTacToe", description: "Классическая игра в кресики нолики"),
        .init(name: "Wordle", image: "wordle", description: "Игра, где нужно угадать слово"),
        .init(name: "Intuition", image: "intuition", description: "Откадай дверь")
    ]
    
    // Количество ячеек (должно быть 10)
    private let numberOfCells = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Список приложений"
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
   static func createBackBarButtonItem(target: Any?, action: Selector) -> UIBarButtonItem {
         let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                             style: .plain,
                                             target: target,
                                             action: action)
         barButtonItem.tintColor = .black
         return barButtonItem
     }

    // Количество элементов в коллекции всегда 10
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    // Конфигурация ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniAppCell.identifier, for: indexPath) as! MiniAppCell
        
        // Берем название приложения из массива по кругу
        let appName = appNames[indexPath.row % appNames.count]
        cell.configure(with: appName.name, image: appName.image, description: appName.description)
        
        return cell
    }

    // Устанавливаем размер ячейки — 1/8 высоты экрана
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 8)
    }
    
    // Реализуем метод для обработки нажатия на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Получаем название приложения по кругу
        let appName = appNames[indexPath.row % appNames.count]
        
        // Переход на соответствующее мини-приложение
        if appName.name == "TicTacToe" {
            let ticTacToeVC = TicTacToeViewController()
            navigationController?.pushViewController(ticTacToeVC, animated: true)
        } else if appName.name == "Wordle" {
            let wordleVC = WordleViewController()
            navigationController?.pushViewController(wordleVC, animated: true)
        } else if appName.name == "Intuition" {
            let intuitionVC = GameViewController()
            navigationController?.pushViewController(intuitionVC, animated: true)
        } else if appName.name == "Weather" {
            let weatherVC = WeatherViewController()
            navigationController?.pushViewController(weatherVC, animated: true)

        }
    }
}
