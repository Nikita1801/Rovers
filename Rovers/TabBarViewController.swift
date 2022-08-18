//
//  TabBarViewController.swift
//  Rovers
//
//  Created by Никита Макаревич on 15.08.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor.customPurple
        
        setupTabBar()
    }
    
    func setupTabBar(){
        
        let settingsViewController = SettingsViewController()
        let mainViewController = MainViewController()
        settingsViewController.roverDelegate = mainViewController
        
        let mainTabItem = createNavigationController(vc: MainViewController(), itemName: "Камеры", itemImage: "камеры")
//        let settingsViewController = createNavigationController(vc: SettingsViewController(), itemName: "Настройки", itemImage: "настройки")

        
        let item = UITabBarItem(title: "Настройки", image: UIImage(named: "настройки"), tag: 0)
        viewControllers = [mainTabItem, settingsViewController]
        settingsViewController.tabBarItem = item
    }
    
    func createNavigationController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController{
        
        let item = UITabBarItem(title: itemName, image: UIImage(named: itemImage), tag: 0)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem = item
        
        return navigationController
    }


}
