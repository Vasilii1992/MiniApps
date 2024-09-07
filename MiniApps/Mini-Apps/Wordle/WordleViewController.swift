//
//  WordleViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 04.09.2024.
//

import UIKit

final class WordleViewController: UIViewController {
    
    let anwsers = [
    "after", "later", "bloke", "there", "ultra"
    ]
    var answer = ""
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5),
                                        count: 6)
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    private lazy var backBarButtonItem = MiniAppListViewController.createBackBarButtonItem(target: self, action: #selector(backBarButtonItemTapped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        answer = anwsers.randomElement() ?? "after"
        addChildren()
        
        
    }
    
    @objc func backBarButtonItemTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        title = "Wordle"
        view.backgroundColor = .systemGray6
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.datasourse = self
        view.addSubview(boardVC.view)
        
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo:keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),


        ])
    }
}

extension WordleViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        var stop = false
        
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                  guesses[i][j] = letter
                    stop = true
                    break
                    
                }
            }
            if stop {
                break
            }
        }
        boardVC.reloadData()
        checkCurrentGuess()
    }
    
    private func checkCurrentGuess() {
        for row in guesses {
            let count = row.compactMap { $0 }.count
            if count == 5 {
                let guessWord = String(row.compactMap { $0 })
                if guessWord.lowercased() == answer.lowercased() {
                    resultAlert(title: "Вы угадали слово!\n\(guessWord.uppercased())")
                }
            }
        }
    }
    
    private func resetGame() {
        guesses = Array(repeating: Array(repeating: nil, count: 5), count: 6)
        answer = anwsers.randomElement() ?? "after"
        boardVC.reloadData()
    }
    
    private func resultAlert(title: String) {
        
        let ac = UIAlertController(title: title,
                                   message: nil,
                                   preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
            self?.resetGame()
        }))
        present(ac, animated: true)
    }
}

extension WordleViewController: BoardViewControllerDataSource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        
        let count = guesses[rowIndex].compactMap { $0 }.count
        guard count == 5 else {
            return nil
        }
        
        let indexedAnswer = Array(answer)

        
        guard let letter = guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter) else { return nil }
        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        return .systemOrange
    }
}
