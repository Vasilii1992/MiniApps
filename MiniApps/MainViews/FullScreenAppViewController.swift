//
//  FullScreenAppViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 05.09.2024.
//

import UIKit

protocol GameSelectionDelegate: AnyObject {
    func didSelectGame(index: Int)
}

class FullScreenAppViewController: UIViewController {
    
    private var ticTacToeVC: TicTacToeViewController?
    private var wordleVC: WordleViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupNavigationBar()
        
        displaySelectedApp(index: 0)
    }
    
    private func setupNavigationBar() {
        title = "Мини-игры"
        
        let gameButton = UIBarButtonItem(title: "Выбрать игру", style: .plain, target: self, action: #selector(showGameSelection(_:)))
        navigationItem.rightBarButtonItem = gameButton
    }
    
    @objc func showGameSelection(_ sender: UIBarButtonItem) {
        let gameSelectionVC = GameSelectionViewController()
        gameSelectionVC.modalPresentationStyle = .popover
        gameSelectionVC.delegate = self
        
        if let popoverController = gameSelectionVC.popoverPresentationController {
            popoverController.barButtonItem = sender
            popoverController.permittedArrowDirections = .up
            popoverController.delegate = self
            gameSelectionVC.preferredContentSize = CGSize(width: 300, height: 400) 
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
        } else {
            // Инициализируем WordleViewController
            wordleVC = WordleViewController()
            guard let wordleVC = wordleVC else { return }
            addChild(wordleVC)
            wordleVC.view.frame = view.bounds
            view.addSubview(wordleVC.view)
            wordleVC.didMove(toParent: self)
            title = "Wordle"
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


