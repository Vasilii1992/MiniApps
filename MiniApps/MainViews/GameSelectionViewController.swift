
import UIKit

final class GameSelectionViewController: UITableViewController {

    let games = ["TicTacToe", "Wordle", "Intuition", "Weather","Crypto"]
    
    weak var delegate: GameSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = games[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGameIndex = indexPath.row
        delegate?.didSelectGame(index: selectedGameIndex)
        dismiss(animated: true, completion: nil)
    }
}
