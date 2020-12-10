//
//  PMTabBarController.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 06.12.2020.
//

import UIKit

class PMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createFactorialVC(), createFibonacciVC(), createPiVC()]
    }
   
    private func createFactorialVC() -> UINavigationController {
        let factorialVC = PMFactorialVC()
        factorialVC.title = "Factorial Implementation"
        factorialVC.tabBarItem = UITabBarItem(title: "Factorial", image: "!".image(), tag: 0)
        
        return UINavigationController(rootViewController: factorialVC)
    }
    
    
    private func createFibonacciVC() -> UINavigationController {
        let fibonacciVC = PMFibonacciVC()
        fibonacciVC.title = "Fibonacci Implementation"
        fibonacciVC.tabBarItem = UITabBarItem(title: "Fibonacci", image: "f".image(), tag: 1)
        
        return UINavigationController(rootViewController: fibonacciVC)
    }
    
    
    private func createPiVC() -> UINavigationController {
        let piVC = PMPiVC()
        piVC.title = "Get the n'th digit of Pi"
        piVC.tabBarItem = UITabBarItem(title: "Pi", image: "π".image(), tag: 2)
        return UINavigationController(rootViewController: piVC)
    }
}
