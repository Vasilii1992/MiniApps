
import UIKit

final class IntuitionViewController: UIViewController {

    lazy var coordinator = {
        return Coordinator(controller: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.setEnviroment()

    }
}
