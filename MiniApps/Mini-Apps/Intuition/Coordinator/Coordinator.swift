
import UIKit

final class Coordinator {
    
   private weak var controller: UIViewController?
    private var view: UIView?
    
    private var UI = IntuitionUI()
    private var gameEngine = GameEngine()
    
    init(controller: UIViewController? = nil) {
        self.controller = controller
        self.view = controller?.view
    }
    
    private lazy var buttonView: UIView = {
        let view = UI.buttonsView
        view.addSubview(leftDoor)
        view.addSubview(rightDoor)
        
        return view
    }()
    
    private lazy var backBarButtonItem = MiniAppListViewController.createBackBarButtonItem(target: self, action: #selector(backBarButtonItemTapped))
    
    private lazy var leftDoor: UIButton = {
        let btn = UI.leftDoor
        btn.addTarget(self, action: #selector(selectDoor(sender: )), for: .touchUpInside)
        return btn
    }()
    
    private lazy var rightDoor: UIButton = {
        let btn = UI.rightDoor
        btn.addTarget(self, action: #selector(selectDoor(sender: )), for: .touchUpInside)
        return btn
    }()
    
    func setEnviroment() {
        guard let view = view else { return }
        UI.recordValue.text = "\(gameEngine.record)"
        controller?.title = "Intuition"
        controller?.navigationItem.leftBarButtonItem = backBarButtonItem

        view.addSubview(UI.backgroundSprite)
        view.addSubview(UI.recordLabel)
        view.addSubview(UI.recordValue)
        view.addSubview(UI.mainLabelStack)
        view.addSubview(buttonView)

        NSLayoutConstraint.activate([
            UI.backgroundSprite.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            UI.backgroundSprite.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            UI.backgroundSprite.topAnchor.constraint(equalTo: view.topAnchor),
            UI.backgroundSprite.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            UI.recordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            UI.recordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            UI.recordValue.leadingAnchor.constraint(equalTo: UI.recordLabel.trailingAnchor, constant: 15),
            UI.recordValue.centerYAnchor.constraint(equalTo: UI.recordLabel.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            UI.mainLabelStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            UI.mainLabelStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70)
        ])

        NSLayoutConstraint.activate([
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
            buttonView.widthAnchor.constraint(equalToConstant: view.bounds.width - 60),
            buttonView.heightAnchor.constraint(equalToConstant: 140)
        ])

        NSLayoutConstraint.activate([
            UI.leftDoor.trailingAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: -10),
            UI.leftDoor.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            UI.leftDoor.widthAnchor.constraint(equalToConstant: 126),
            UI.leftDoor.heightAnchor.constraint(equalToConstant: 140),
            
            UI.rightDoor.leadingAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: 10),
            UI.rightDoor.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            UI.rightDoor.widthAnchor.constraint(equalToConstant: 126),
            UI.rightDoor.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    @objc func backBarButtonItemTapped() {
        controller?.navigationController?.popViewController(animated: true)
    }

    
    @objc func selectDoor(sender: UIButton) {
        let side = sender.tag == 1 ? false : true
        if gameEngine.gameAction(side: side) {
            UI.selectedLabel.text = UI.correctLabel.text
            UI.selectedLabel.textColor = UI.correctLabel.textColor
        }
        else {
            UI.selectedLabel.text = UI.inCorrectLabel.text
            UI.selectedLabel.textColor = UI.inCorrectLabel.textColor
        }
        UI.scoreValue.text = "\(gameEngine.score)"
        UI.scoreDescription.text = LabelStrings.getCurrentResultText(score: gameEngine.score)
        UI.recordValue.text = "\(gameEngine.record)"
    }
}
