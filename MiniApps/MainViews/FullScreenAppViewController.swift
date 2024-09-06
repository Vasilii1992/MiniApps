//
//  FullScreenAppViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 05.09.2024.
//

import UIKit

// Создаем протокол делегата для передачи выбранной игры
protocol GameSelectionDelegate: AnyObject {
    func didSelectGame(index: Int)
}

class FullScreenAppViewController: UIViewController {
    
    // Контроллеры для мини-приложений
    private var ticTacToeVC: TicTacToeViewController?
    private var wordleVC: WordleViewController?
    private var intuitionVC: GameViewController?
    private var weatherVC: WeatherViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настраиваем UI
        view.backgroundColor = .white
        
        // Настраиваем Navigation Bar
        setupNavigationBar()
        
        // Устанавливаем первоначальное приложение (TicTacToe)
        displaySelectedApp(index: 0)
    }
    
    // Настройка Navigation Bar
    private func setupNavigationBar() {
        // Устанавливаем заголовок
        title = "Мини-игры"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Добавляем кнопку выбора игры в правую часть Navigation Bar
        let gameButton = UIBarButtonItem(title: "Сменить", style: .done, target: self, action: #selector(showGameSelection(_:)))
        navigationItem.rightBarButtonItem = gameButton
        gameButton.tintColor = .black
    }
    
    // Метод для отображения popover из кнопки
    @objc func showGameSelection(_ sender: UIBarButtonItem) {
        // Создаем контроллер с таблицей для отображения списка
        let gameSelectionVC = GameSelectionViewController()
        gameSelectionVC.modalPresentationStyle = .popover
        gameSelectionVC.delegate = self  // Устанавливаем делегат
        
        if let popoverController = gameSelectionVC.popoverPresentationController {
            popoverController.barButtonItem = sender // Указываем источник поповера
            popoverController.permittedArrowDirections = .up
            popoverController.delegate = self
            gameSelectionVC.preferredContentSize = CGSize(width: 300, height: 400) // Размер поповера
        }
        
        present(gameSelectionVC, animated: true, completion: nil)
    }
    
    // Метод для отображения выбранного мини-приложения
    func displaySelectedApp(index: Int) {
        // Удаляем предыдущие контроллеры, если они есть
        removeChildViewControllers()
        
        if index == 0 {
            // Инициализируем TicTacToeViewController
            ticTacToeVC = TicTacToeViewController()
            guard let ticTacToeVC = ticTacToeVC else { return }
            addChild(ticTacToeVC)
            ticTacToeVC.view.frame = view.bounds
            view.addSubview(ticTacToeVC.view)
            ticTacToeVC.didMove(toParent: self)
            title = "TicTacToe"
        } else if index == 1 {
            // Инициализируем WordleViewController
            wordleVC = WordleViewController()
            guard let wordleVC = wordleVC else { return }
            addChild(wordleVC)
            wordleVC.view.frame = view.bounds
            view.addSubview(wordleVC.view)
            wordleVC.didMove(toParent: self)
            title = "Wordle"
        } else if index == 2 {
            intuitionVC = GameViewController()
            guard let intuitionVC = intuitionVC else { return }
            addChild(intuitionVC)
            intuitionVC.view.frame = view.bounds
            view.addSubview(intuitionVC.view)
            intuitionVC.didMove(toParent: self)
            title = "Intuition"
        } else if index == 3 {
            weatherVC = WeatherViewController()
            guard let weatherVC = weatherVC else { return }
            addChild(weatherVC)
            weatherVC.view.frame = view.bounds
            view.addSubview(weatherVC.view)
            weatherVC.didMove(toParent: self)
            title = "Weather"
        }
        
    }
    
    // Метод для удаления предыдущих дочерних контроллеров
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
        // На iPhone popover будет отображаться как модальное окно
        return .none
    }
}

// Реализуем делегат для передачи выбора игры обратно
extension FullScreenAppViewController: GameSelectionDelegate {
    func didSelectGame(index: Int) {
        displaySelectedApp(index: index)  // Отображаем выбранную игру
    }
}


