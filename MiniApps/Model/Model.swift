//
//  Model.swift
//  MiniApps
//
//  Created by Василий Тихонов on 04.09.2024.
//

import UIKit

struct MiniApps {
    let name: String
    let image: String
    let description: String
}

struct MiniAppForInteractive {
    let name: String
    let viewControllerFactory: () -> UIViewController
}
