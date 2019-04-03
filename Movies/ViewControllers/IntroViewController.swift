//
//  IntroViewController.swift
//  Movies
//
//  Created by Adrian Ortiz on 3/26/19.
//  Copyright © 2019 Adrian Ortiz. All rights reserved.
//

import UIKit

class IntroViewController: UIPageViewController {
    
    private lazy var listViewControllers = {
       return [instanceViewController(with: "Step1"),
               instanceViewController(with: "Step2"),
               instanceViewController(with: "Step3")]
        }() as! [UIViewController]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if let firstViewController = listViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    private func instanceViewController(with name: String) -> UIViewController? {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "\(name)ViewController") as! PageIntroViewController
        vc.delegate = self
        return vc
    }
}

extension IntroViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = listViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = listViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return listViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return listViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = listViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return listViewControllers.last
        }
        
        guard listViewControllers.count > previousIndex else {
            return nil
        }
        
        return listViewControllers[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return listViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = listViewControllers.firstIndex(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
}

extension IntroViewController: PageDelegate {
    
    func exploreCollectionPressed() {
        let homeVC = UIStoryboard.init(name: "Home", bundle: nil).instantiateInitialViewController()!
        self.navigationController?.setViewControllers([homeVC], animated: true)
    }
    
}
