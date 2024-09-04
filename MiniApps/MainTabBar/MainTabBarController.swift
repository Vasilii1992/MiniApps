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
    
    }
    
    private func createTabBarItem(vc: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        let viewController = vc
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: image)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        return viewController
    }
    
    private func setTabs() {
        let miniVC = createTabBarItem(vc: miniViewController, title: "Мини-приложения", image: "house", selectedImage: "house.fill")
        let halfVC = createTabBarItem(vc: halfViewController, title: "Интерактив", image: "message", selectedImage: "message.fill")
      
        let fullScreenVC = createTabBarItem(vc: fullScreenViewController, title: "Полный экран", image: "person", selectedImage: "person.fill")
        setViewControllers([miniVC, halfVC, fullScreenVC], animated: false)
    }
}
