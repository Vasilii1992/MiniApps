//
//  MainTabBarController.swift
//  MiniApps
//
//  Created by Василий Тихонов on 04.09.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let miniViewController = UINavigationController(rootViewController: MiniAppListViewController())
    let halfViewController = UINavigationController(rootViewController: InteractiveAppListViewController())
    let fullScreenViewController = UINavigationController(rootViewController: FullScreenAppViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabs()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemGray6
    }
    
    private func createTabBarItem(vc: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        let viewController = vc
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: image)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        return viewController
    }
    
    private func setTabs() {
        let miniVC = createTabBarItem(vc: miniViewController, title: "Мини-приложения", image: "checklist.unchecked", selectedImage: "checklist.checked")
        let halfVC = createTabBarItem(vc: halfViewController, title: "Интерактив", image: "equal.square", selectedImage: "equal.square.fill")
        let fullScreenVC = createTabBarItem(vc: fullScreenViewController, title: "Полный экран", image: "line.3.horizontal.decrease.circle", selectedImage: "line.3.horizontal.decrease.circle.fill")
        setViewControllers([miniVC, halfVC, fullScreenVC], animated: false)
    }
}
