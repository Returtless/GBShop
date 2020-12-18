//
//  TabBarController.swift
//  GBShop
//
//  Created by Владислав Лихачев on 17.12.2020.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = ProductsListViewController()
        let tabOneBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "folder"), selectedImage: UIImage(systemName: "folder.fill"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        let tabTwo = ProfileViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
}
