//
//  GameViewController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 05.09.2024.
//

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
