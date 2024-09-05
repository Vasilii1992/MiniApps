//
//  GameViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 05.09.2024.
//

import UIKit

class GameViewController: UIViewController {

    lazy var coordinator = {
        return Coordinator(controller: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.setEnviroment()

    }
    
}
