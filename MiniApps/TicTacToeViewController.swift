import UIKit

enum Turn {
    case Nought
    case Cross
}

final class TicTacToeViewController: UIViewController {
    
    var nought = "⭕️"
    var cross = "❌"
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    var board = [UIButton]()
    var noughtsScore = 0
    var crossesScore = 0
    
    // MARK: - UI
   private lazy var turnLabel: UILabel = {
        let label = UILabel()
        label.text = "Turn\n \(cross)"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .black
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var buttons: [[UIButton]] = {
        var buttonGrid = [[UIButton]]()
        for _ in 0..<3 {
            var row = [UIButton]()
            for _ in 0..<3 {
                let button = UIButton()
                button.setTitle("", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
                button.backgroundColor = .white
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                row.append(button)
            }
            buttonGrid.append(row)
        }
        return buttonGrid
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupGrid()
        initializeBoard()
        setupConstraints()

    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(vStack)
        view.addSubview(turnLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            vStack.heightAnchor.constraint(equalTo: vStack.widthAnchor),
            
            turnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            turnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupGrid() {
        for row in buttons {
            let hStack = UIStackView(arrangedSubviews: row)
            hStack.axis = .horizontal
            hStack.spacing = 5
            hStack.alignment = .fill
            hStack.distribution = .fillEqually
            vStack.addArrangedSubview(hStack)
        }
    }
    
    private func resultAlert(title: String) {
        
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        if sender.title(for: .normal) == "" {
            if currentTurn == Turn.Nought {
                sender.setTitle(nought, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = "Turn\n" + cross
            } else if currentTurn == Turn.Cross {
                sender.setTitle(cross, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = "Turn\n" + nought
            }
            sender.isEnabled = false
            
            if checkForVictory(nought) {
                noughtsScore += 1
                resultAlert(title: "Noughts Win!")
            } else if checkForVictory(cross) {
                crossesScore += 1
                resultAlert(title: "Crosses Win!")
               
            } else if fullBoard() {
                resultAlert(title: "Draw! The board is full.")
            }
        }
    }
}

// MARK: - Game Logic
private extension TicTacToeViewController {
    
    func initializeBoard() {
        board.removeAll()
        for row in buttons {
            for button in row {
                board.append(button)
            }
        }
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = "Turn\n" + cross
        } else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = "Turn\n" + nought
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal)?.isEmpty ?? true {
                return false
            }
        }
        return true
    }
    
    func checkForVictory(_ s: String) -> Bool {
        // Check rows
        for i in 0..<3 {
            if thisSymbol(buttons[i][0], s) && thisSymbol(buttons[i][1], s) && thisSymbol(buttons[i][2], s) {
                return true
            }
        }
        // Check columns
        for i in 0..<3 {
            if thisSymbol(buttons[0][i], s) && thisSymbol(buttons[1][i], s) && thisSymbol(buttons[2][i], s) {
                return true
            }
        }
        // Check diagonals
        if thisSymbol(buttons[0][0], s) && thisSymbol(buttons[1][1], s) && thisSymbol(buttons[2][2], s) {
            return true
        }
        
        if thisSymbol(buttons[0][2], s) && thisSymbol(buttons[1][1], s) && thisSymbol(buttons[2][0], s) {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
}
